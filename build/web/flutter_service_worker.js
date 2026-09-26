'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b3cc9953c9ecdaf834cd126ac7b0fc9f", "assets/AssetManifest.bin.json": "20947f2ad405bf4a511610f3fc2a38b2", "assets/AssetManifest.json": "581b2bb0b2844f4e4d5cae351c9f2a22", "assets/assets/images/ecg.jpg": "3380fda665bdf6c7bfeebb966e4ead7d", "assets/assets/images/ours.jpg": "3e5d0be1bd20c2b5e4d1c5e25625d36f", "assets/assets/pdf/ACR-au-bloc-chez-l-enfant.pdf": "abad5eb1739e01347bee06bd45713b5f", "assets/assets/pdf/anaphylaxie-pediatrie.pdf": "8eb6765058dac9c95bdfe0229cd4c126", "assets/assets/pdf/HyperthermieMaligneenfant.pdf": "f989728198dc652243c9c55681e9ac58", "assets/assets/pdf/intoxication-Anesthesiques-Locaux-enfant.pdf": "8350b6b72cac15a06c92feda44137466", "assets/assets/pdf/iot-difficile-chez-l-enfant.pdf": "d4c187c563f582a79a97461197cf1517", "assets/assets/pdf/laryngospasmepediatrie.pdf": "c96b37ca1382a39adf2f480da0418f61", "assets/assets/pdf/politiqueconfidentialite.pdf": "56748fa3a4bedfe5428b352a700681c1", "assets/assets/pdf/reanimation-du-nouveau-ne-en-salle-de-naissance.pdf": "c4d0c8e38bb624ebc4919de5c3b5c2e8", "assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57", "assets/fonts/MaterialIcons-Regular.otf": "5e419405189a5c7cb1c87e3c579e1be2", "assets/NOTICES": "c503305beb8b664ae8f2df8d4f366020", "assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711", "assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce", "canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6", "canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360", "canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc", "canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d", "canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d", "canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506", "canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095", "canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1", "canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109", "canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f", "canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3", "canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b", "favicon.png": "bed6962dca38d27da3e1e626e0f5a864", "flutter.js": "888483df48293866f9f41d3d9274a779", "flutter_bootstrap.js": "ea7de90697bcd95aeaeeb9c2d5a1a8a6", "icons/Icon-192.png": "d75e9e40d13c8db494cdcdfd4fa77641", "icons/Icon-512.png": "f6edeb1235654fc80ffc93e4cad865c2", "icons/Icon-maskable-192.png": "d75e9e40d13c8db494cdcdfd4fa77641", "icons/Icon-maskable-512.png": "f6edeb1235654fc80ffc93e4cad865c2", "index.html": "c66ccf4fc4e4b4f31d157527f22eba1b", "/": "c66ccf4fc4e4b4f31d157527f22eba1b", "main.dart.js": "37e58c8c215607ea3b2067b7db0b8d6e", "manifest.json": "59c009166450903467b408b5bb771239", "Pedianesth.png": "6e68be4a5123d84a735a91f84428953b", "version.json": "2282e2d4a362bfdaf4359072ff375534"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
