const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");
const stripe = require("stripe")("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"); // Remplace par ta clé secrète Stripe

admin.initializeApp();

const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

app.post("/", async (req, res) => {  // Laisse "/" si la fonction est déjà déployée sous helloWorld
    const sig = req.headers["stripe-signature"];
    const endpointSecret = "whsec_x3YG2LUmItZSoq3YA2eb1hs4pCMuqVJB"; // Remplace par ta clé webhook Stripe

    let event;
    try {
        event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);
    } catch (err) {
        console.error("❌ Erreur de vérification du webhook :", err);
        return res.status(400).send(`Webhook Error: ${err.message}`);
    }

    if (event.type === "checkout.session.completed") {
        const session = event.data.object;
        const email = session.customer_email;

        // Ajouter l'utilisateur à Firestore
        await admin.firestore().collection("users").doc(email).set({
            email: email,
            accessGranted: true,
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
        });

        console.log(`✅ Accès donné à : ${email}`);
    }

    res.json({ received: true });
});

// Modifier la fonction helloWorld pour appeler cette app
exports.helloWorld = functions.https.onRequest(app);
