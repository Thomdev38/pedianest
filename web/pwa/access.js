// Vérifie l'accès de l'utilisateur via Firestore
async function checkAccess() {
    const email = localStorage.getItem("user_email") || prompt("Entrez votre email pour accéder à la PWA :");

    if (!email) {
        alert("Email requis !");
        window.location.href = "achat.html"; // Redirige vers la page d'achat
        return;
    }

    localStorage.setItem("user_email", email); // Stocke l'email localement pour éviter de redemander

    try {
        const userDoc = await db.collection("users").doc(email).get();

        if (userDoc.exists && userDoc.data().accessGranted) {
            console.log("✅ Accès accordé :", email);
        } else {
            alert("Accès refusé. Veuillez acheter un accès !");
            window.location.href = "achat.html";
        }
    } catch (error) {
        console.error("❌ Erreur Firestore :", error);
        alert("Erreur de vérification d'accès. Réessayez plus tard.");
        window.location.href = "achat.html";
    }
}

// Exécute la vérification à l'ouverture de la PWA
window.addEventListener("load", checkAccess);
