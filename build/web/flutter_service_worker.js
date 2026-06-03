'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "1e667cb3abc6a85e323d541204a11368",
"index.html": "c73c2dae14c7b2fd7513be5df7f4b92c",
"/": "c73c2dae14c7b2fd7513be5df7f4b92c",
"app.html": "600d155d6154bbdba7d24a391d091b8e",
"pwa/index.html": "881a23a65ab102474590312aa162292b",
"pwa/assets/AssetManifest.bin": "b3cc9953c9ecdaf834cd126ac7b0fc9f",
"pwa/assets/AssetManifest.bin.json": "20947f2ad405bf4a511610f3fc2a38b2",
"pwa/assets/AssetManifest.json": "581b2bb0b2844f4e4d5cae351c9f2a22",
"pwa/assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"pwa/assets/NOTICES": "f3ddea8e4fe0ab9733d8062a8c1f7815",
"pwa/assets/assets/images/ecg.jpg": "3380fda665bdf6c7bfeebb966e4ead7d",
"pwa/assets/assets/images/ours.jpg": "3e5d0be1bd20c2b5e4d1c5e25625d36f",
"pwa/assets/assets/pdf/ACR-au-bloc-chez-l-enfant.pdf": "abad5eb1739e01347bee06bd45713b5f",
"pwa/assets/assets/pdf/HyperthermieMaligneenfant.pdf": "f989728198dc652243c9c55681e9ac58",
"pwa/assets/assets/pdf/anaphylaxie-pediatrie.pdf": "8eb6765058dac9c95bdfe0229cd4c126",
"pwa/assets/assets/pdf/intoxication-Anesthesiques-Locaux-enfant.pdf": "8350b6b72cac15a06c92feda44137466",
"pwa/assets/assets/pdf/iot-difficile-chez-l-enfant.pdf": "d4c187c563f582a79a97461197cf1517",
"pwa/assets/assets/pdf/laryngospasmepediatrie.pdf": "c96b37ca1382a39adf2f480da0418f61",
"pwa/assets/assets/pdf/politiqueconfidentialite.pdf": "56748fa3a4bedfe5428b352a700681c1",
"pwa/assets/assets/pdf/reanimation-du-nouveau-ne-en-salle-de-naissance.pdf": "c4d0c8e38bb624ebc4919de5c3b5c2e8",
"pwa/assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"pwa/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"pwa/assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"pwa/canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"pwa/canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"pwa/canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"pwa/canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"pwa/canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"pwa/canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"pwa/canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"pwa/canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"pwa/canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"pwa/canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"pwa/canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"pwa/canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"pwa/canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"pwa/favicon.png": "bed6962dca38d27da3e1e626e0f5a864",
"pwa/favicon1.png": "5dcef449791fa27946b3d35ad8803796",
"pwa/firebase.json": "6d3847ebcab2acc4a0644f4010eac90d",
"pwa/flutter.js": "76f08d47ff9f5715220992f993002504",
"pwa/flutter_bootstrap.js": "c3aa55a2ccf374b364bde1ace298ec49",
"pwa/icons/Icon-192.png": "d75e9e40d13c8db494cdcdfd4fa77641",
"pwa/icons/Icon-512.png": "f6edeb1235654fc80ffc93e4cad865c2",
"pwa/icons/Icon-maskable-192.png": "d75e9e40d13c8db494cdcdfd4fa77641",
"pwa/icons/Icon-maskable-512.png": "f6edeb1235654fc80ffc93e4cad865c2",
"pwa/main.dart.js": "032d1ea9c1206630d77d4aa02cff6528",
"pwa/manifest.json": "40ad04d21b90632745b1fc9da4a49da2",
"pwa/service-worker.js": "9641df8c41b46773285e48ac60cfa991",
"pwa/version.json": "086fc4c00f49962fe459a50265e48ed5",
"main.dart.js": "909c02ff22afadeb57fdf4210ae8e174",
"version.json": "cb436c58d37ace5f45da48cf95472725",
"assets/assets/images/ecg.jpg": "3380fda665bdf6c7bfeebb966e4ead7d",
"assets/assets/images/ours.jpg": "3e5d0be1bd20c2b5e4d1c5e25625d36f",
"assets/assets/pdf/ACR-au-bloc-chez-l-enfant.pdf": "abad5eb1739e01347bee06bd45713b5f",
"assets/assets/pdf/HyperthermieMaligneenfant.pdf": "f989728198dc652243c9c55681e9ac58",
"assets/assets/pdf/anaphylaxie-pediatrie.pdf": "8eb6765058dac9c95bdfe0229cd4c126",
"assets/assets/pdf/iot-difficile-chez-l-enfant.pdf": "d4c187c563f582a79a97461197cf1517",
"assets/assets/pdf/politiqueconfidentialite.pdf": "56748fa3a4bedfe5428b352a700681c1",
"assets/assets/pdf/laryngospasmepediatrie.pdf": "c96b37ca1382a39adf2f480da0418f61",
"assets/assets/pdf/intoxication-Anesthesiques-Locaux-enfant.pdf": "8350b6b72cac15a06c92feda44137466",
"assets/assets/pdf/reanimation-du-nouveau-ne-en-salle-de-naissance.pdf": "c4d0c8e38bb624ebc4919de5c3b5c2e8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/fonts/MaterialIcons-Regular.otf": "c2eb9671082c115cce17af15c7137f35",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "581b2bb0b2844f4e4d5cae351c9f2a22",
"assets/AssetManifest.bin": "b3cc9953c9ecdaf834cd126ac7b0fc9f",
"assets/AssetManifest.bin.json": "20947f2ad405bf4a511610f3fc2a38b2",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "57e1d0b0318d0db8c159c492369a9f4a",
"Pedianesth.png": "6e68be4a5123d84a735a91f84428953b",
"icons/Icon-192.png": "d75e9e40d13c8db494cdcdfd4fa77641",
"icons/Icon-512.png": "f6edeb1235654fc80ffc93e4cad865c2",
"icons/Icon-maskable-192.png": "d75e9e40d13c8db494cdcdfd4fa77641",
"icons/Icon-maskable-512.png": "f6edeb1235654fc80ffc93e4cad865c2",
"favicon.png": "bed6962dca38d27da3e1e626e0f5a864",
"manifest.json": "0714e7ea179dd989f4c1d133471973da"};
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
