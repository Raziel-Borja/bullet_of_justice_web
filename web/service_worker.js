const CACHE_NAME = "bullet_of_justice_cache_v1";
const urlsToCache = [
  "/",
  "index.html",
  "main.dart.js",
  "manifest.json",
  "icons/icon-192.png",
  "icons/icon-512.png"
];

// Instalar el Service Worker y cachear los archivos necesarios
self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(urlsToCache);
    })
  );
});

// Interceptar solicitudes y responder desde la caché si es posible
self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});

// Activar el Service Worker y eliminar cachés antiguas
self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames
          .filter((cacheName) => cacheName !== CACHE_NAME)
          .map((cacheName) => caches.delete(cacheName))
      );
    })
  );
});
