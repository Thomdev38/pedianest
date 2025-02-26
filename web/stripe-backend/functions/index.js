const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");
const stripe = require("stripe")("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"); // Clé secrète Stripe

admin.initializeApp();

const app = express();
app.use(cors({ origin: true }));

// ⚠️ Express doit traiter le corps en brut pour Stripe
app.use(express.json({ verify: (req, res, buf) => { req.rawBody = buf; } }));

// 🔥 Route Webhook Stripe
app.post("/", async (req, res) => {
    const sig = req.headers["stripe-signature"];
    const endpointSecret = "whsec_x3YG2LUmItZSoq3YA2eb1hs4pCMuqVJB"; // Secret Webhook

    let event;
    try {
        event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);
    } catch (err) {
        console.error("❌ Erreur webhook:", err);
        return res.status(400).send(`Webhook Error: ${err.message}`);
    }

    if (event.type === "checkout.session.completed") {
        const session = event.data.object;
        const email = session.customer_email || (session.customer_details ? session.customer_details.email : null);

        if (!email) {
            console.error("❌ Aucune adresse email trouvée !");
            return res.status(400).json({ error: "Email non trouvé" });
        }

        // 🔥 Ajouter l'utilisateur à Firestore
        try {
            const token = Math.random().toString(36).substr(2, 10); // Génération d'un token unique
            await admin.firestore().collection("users").doc(email).set({
                email: email,
                accessGranted: true,
                token: token,
                timestamp: admin.firestore.FieldValue.serverTimestamp(),
            });

            console.log(`✅ Accès donné à : ${email} avec token : ${token}`);
        } catch (err) {
            console.error("❌ Erreur Firestore:", err);
            return res.status(500).json({ error: "Erreur Firestore" });
        }
    }

    res.json({ received: true });
});

// 📢 Exporter la fonction Firebase sous helloWorld
exports.helloWorld = functions.https.onRequest(app);
