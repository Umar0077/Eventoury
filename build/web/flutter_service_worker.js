'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "22a10d7fc101cf24c07c74ac8848b21f",
"assets/AssetManifest.bin.json": "0d0294677b6484ff2cad1ac7902f6bfb",
"assets/AssetManifest.json": "f13108e33c4f8e641206f24735286c5c",
"assets/assets/app_logos/logo.png": "718e939a6504cb2d1c086ccd77af6d74",
"assets/assets/app_logos/logo_2.png": "e111e2df9cccb1d327a91ea5fd6d8d52",
"assets/assets/app_logos/logo_3.png": "b581b6bf36a534dff951f0012f41ff93",
"assets/assets/app_logos/logo_4.png": "d4005a4ef5511e669945364ad4c8a272",
"assets/assets/app_logos/logo_5.png": "463aacd5c1803cfc5fb72e968e568489",
"assets/assets/font/Montserrat-Black.ttf": "d414a87f1942b9c4ae40ef793f171dae",
"assets/assets/font/Montserrat-BlackItalic.ttf": "e11421af6f75c947f1d2837f4e534611",
"assets/assets/font/Montserrat-Bold.ttf": "c300fff4e4ae0ca994c58ac9f6639b19",
"assets/assets/font/Montserrat-BoldItalic.ttf": "4a2d6e65e13b83c26996da3990d4fcd0",
"assets/assets/font/Montserrat-ExtraBold.ttf": "8a50619755ab4ca7bc9433d892f43d49",
"assets/assets/font/Montserrat-ExtraBoldItalic.ttf": "1e928a19babcb4c39dc17e946e7413a3",
"assets/assets/font/Montserrat-ExtraLight.ttf": "985b2147a6b955ceea74741f3d70885f",
"assets/assets/font/Montserrat-ExtraLightItalic.ttf": "2ea0576ae2d6795e7786b364f39e54fe",
"assets/assets/font/Montserrat-Italic.ttf": "ba6062606d5a7342cbce5a5d4b391bc4",
"assets/assets/font/Montserrat-Light.ttf": "5cbf5cdcf7ec24681e0ea4adeadc2822",
"assets/assets/font/Montserrat-LightItalic.ttf": "4eacf0be3abf18d7e743598b0991554e",
"assets/assets/font/Montserrat-Medium.ttf": "9d496514aedf5c9bb3f689de8b094cd8",
"assets/assets/font/Montserrat-MediumItalic.ttf": "426a2f39048d24a78a94737908603fe3",
"assets/assets/font/Montserrat-Regular.ttf": "203d753a80557746c23ce95191fbf013",
"assets/assets/font/Montserrat-SemiBold.ttf": "c1bd726715a688ead84c2dbf4c82f88d",
"assets/assets/font/Montserrat-SemiBoldItalic.ttf": "7e5c023c68d940a51ea9f9fcaeb711a7",
"assets/assets/font/Montserrat-Thin.ttf": "da2373e271b755f87874ba215a117b4a",
"assets/assets/font/Montserrat-ThinItalic.ttf": "8a84aafae4cb52c75074e12636fed0ca",
"assets/assets/home_screen/circle%2520(1).png": "c55cd47ef40e7acda890ea27a28ec549",
"assets/assets/home_screen/circle.png": "ae310efd3fb46a913f01e6d3a56921ad",
"assets/assets/home_screen/events.jpg": "ac3dbffdfef7fa8501cd5cedbc927709",
"assets/assets/home_screen/line.png": "4ce68d28706ef3a5ebdc6c25dccf9b63",
"assets/assets/home_screen/tour_packages.jpeg": "850ae58e8fc00020be0befb47c5b2e93",
"assets/assets/home_screen/transport.jpg": "261fefde680295d4f3de4c035fde58a1",
"assets/assets/loader/loader_dark.gif": "d1875cc822b26ec74c335f33b6dfd155",
"assets/assets/loader/loader_light.gif": "aad143a4946a2214eda8787150757f45",
"assets/assets/onboarding_images/onboarding_1.jpeg": "40804f566f3f6e5ee85b6e3318cf7482",
"assets/assets/onboarding_images/onboarding_2.jpeg": "6ca49f4041ec293fbad2a7df02d371d8",
"assets/assets/onboarding_images/onboarding_3.jpeg": "b84087ca63a15d8f335380a0b47bd08e",
"assets/assets/onboarding_images/onboarding_4.jpeg": "a958cc74585a670cb0978e5a5e3ba721",
"assets/assets/onboarding_images/onboarding_5.jpeg": "fc5fa49b1a66e1214df966acabe17787",
"assets/assets/onboarding_images/onboarding_6.jpeg": "f1f23c0096f3a4f18d579c54d076ac04",
"assets/assets/payment/120978-payment-successful.json": "23257c5bfbb6517be2883084bac86fe7",
"assets/assets/payment/master-card.png": "647f4f9e11f4fa27fc415b1190a1d9e0",
"assets/assets/payment/Success%2520animation.json": "845d0f6b3ac9e4231a122db2edccabdd",
"assets/assets/payment/visa.png": "dcd36d867f0f60f1ddf675f28b460981",
"assets/FontManifest.json": "30c6c30bc286bda474165734f6e0a0a1",
"assets/fonts/MaterialIcons-Regular.otf": "721ca1708e6a82e794b63ced4b5aae64",
"assets/NOTICES": "568627d2ed4b413fa43be57c371543a5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5e827635151e096a28166581f82588f8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "262525e2081311609d1fdab966c82bfc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "ae683f383e721e41bffe60ce9d69e0c2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "2271bedce26a18d7e377152882db754f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "973c8c8294bee0c6cd016007e08256ec",
"/": "973c8c8294bee0c6cd016007e08256ec",
"main.dart.js": "6a5d8e4d18fe52190f84b4b6fa22f88b",
"manifest.json": "f4b17573d13f705f6f2f38c4bfbf0d0c",
"splash/img/dark-1x.gif": "9704fac9ba949e9500902d0f9e0278cc",
"splash/img/dark-1x.png": "e058748989aa06e5e2aafc5bc0350486",
"splash/img/dark-2x.gif": "1876f1db188f253c3510bb5449f0058a",
"splash/img/dark-2x.png": "46d9b2b78f45ad9c20741e2872b12121",
"splash/img/dark-3x.gif": "746bb1d78f648c6d7b36354d105cabdc",
"splash/img/dark-3x.png": "ce425824099e6ce756a882297de9213e",
"splash/img/dark-4x.gif": "42aa8199ff5b38d3cd7b084f54a2f76f",
"splash/img/dark-4x.png": "adca15443307b32384087e2ad8d6c52a",
"splash/img/light-1x.gif": "9704fac9ba949e9500902d0f9e0278cc",
"splash/img/light-1x.png": "e058748989aa06e5e2aafc5bc0350486",
"splash/img/light-2x.gif": "1876f1db188f253c3510bb5449f0058a",
"splash/img/light-2x.png": "46d9b2b78f45ad9c20741e2872b12121",
"splash/img/light-3x.gif": "746bb1d78f648c6d7b36354d105cabdc",
"splash/img/light-3x.png": "ce425824099e6ce756a882297de9213e",
"splash/img/light-4x.gif": "42aa8199ff5b38d3cd7b084f54a2f76f",
"splash/img/light-4x.png": "adca15443307b32384087e2ad8d6c52a",
"version.json": "63cc73f50c50f1f9515e8a42ea5a1b19"};
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
