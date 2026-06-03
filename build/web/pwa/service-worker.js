const CACHE_NAME = 'pwa-version-1.0';  // Nom du cache, tu peux le modifier
const urlsToCache = [
  '/',  // Page d'accueil
  '/index.html',  // Page principale
  '/main.dart.js',  // Le script principal
  '/manifest.json',  // Le fichier manifest
  '/icons/icon-192x192.png',  // Icône pour les appareils mobiles
  '/icons/icon-512x512.png',  // Icône grande pour l'écran d'accueil
  '/styles.css',  // Styles (si tu en as)
  '/assets/',  // Dossier des autres ressources (si applicable)
];

// Installation du service worker
self.addEventListener('install', (event) => {
  console.log('Service Worker: Installé');

  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('Service Worker: Mise en cache des fichiers');
        return cache.addAll(urlsToCache).catch((err) => {
          console.error('Erreur lors de l\'ajout au cache', err);
        });
      })
  );
});

// Activation du service worker
self.addEventListener('activate', (event) => {
  console.log('Service Worker: Activé');

  // Supprimer les anciens caches si nécessaire
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (!cacheWhitelist.includes(cacheName)) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open('v1').then(cache => {
      // Ajouter les ressources essentielles à la cache
      return cache.addAll([
        '/',
        '/index.html',
        '/styles.css',
        '/app.js',
        // Ajoute ici les fichiers PDF à mettre en cache
        '/pdfs/mon-pdf.pdf',
      ]);
    })
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(response => {
      // Si le fichier est dans le cache, retourne-le, sinon récupère-le en ligne
      return response || fetch(event.request).then(fetchResponse => {
        // Cache les fichiers PDF récupérés en ligne
        if (event.request.url.endsWith('.pdf')) {
          caches.open('v1').then(cache => {
            cache.put(event.request, fetchResponse.clone());
          });
        }
        return fetchResponse;
      });
    })
  );
});

// Interception des requêtes (fetch) et renvoi des ressources du cache
self.addEventListener('fetch', (event) => {
  console.log('Service Worker: Interception de la requête', event.request.url);
  
  // Répondre avec la ressource en cache si disponible, sinon réseau
  event.respondWith(
    caches.match(event.request)
      .then((cachedResponse) => {
        // Si la ressource est dans le cache, renvoie-la
        if (cachedResponse) {
          console.log('Service Worker: Utilisation du cache pour', event.request.url);
          return cachedResponse;
        }
        
        // Sinon, fait une requête réseau pour la récupérer
        return fetch(event.request).then((response) => {
          // On ne met en cache que les réponses valides
          if (!response || response.status !== 200 || response.type !== 'basic') {
            return response;
          }
          
          // Mettre en cache la réponse pour les futures requêtes
          const responseToCache = response.clone();
          caches.open(CACHE_NAME)
            .then((cache) => {
              cache.put(event.request, responseToCache);
            });
          
          return response;
        });
      })
  );
});
