# 📸 Instagram Clone — Offline-First, Memory-Safe Social Media Client

**A high-performance Flutter frontend for a collaborative full-stack Instagram clone, built against a custom Laravel REST API. Engineered for offline resilience, deterministic video memory management, and zero-crash production stability.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev/)
[![GetX](https://img.shields.io/badge/GetX-4.7-8B5CF6?style=flat-square)](https://pub.dev/packages/get)
[![Isar](https://img.shields.io/badge/Isar-3.1-2DD4BF?style=flat-square)](https://isar.dev/)
[![Dio](https://img.shields.io/badge/Dio-5.9-EF4444?style=flat-square)](https://pub.dev/packages/dio)
[![Laravel](https://img.shields.io/badge/Backend-Laravel-FF2D20?style=flat-square&logo=laravel&logoColor=white)](https://laravel.com/)

---

## Demo

<!-- Replace with actual recordings when available -->
| Home Feed | Reels | Offline Mode |
|:---------:|:-----:|:------------:|
| ![Feed Demo](docs/demo_feed.gif) | ![Reels Demo](docs/demo_reels.gif) | ![Offline Demo](docs/demo_offline.gif) |

---

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Flutter Client                          │
│                                                             │
│  ┌───────────┐    ┌──────────────┐    ┌──────────────────┐  │
│  │   Views    │───▶│  Controllers │───▶│    Services       │  │
│  │  (GetView) │    │   (GetX)     │    │ (FeedCache, Video)│  │
│  └───────────┘    └──────┬───────┘    └────────┬─────────┘  │
│                          │                     │             │
│                 ┌────────▼────────┐   ┌────────▼─────────┐  │
│                 │  Isar NoSQL DB  │   │  VideoService    │  │
│                 │  (Post, Reel,   │   │  (Ref-Counted    │  │
│                 │   User schemas) │   │   Controllers +  │  │
│                 │                 │   │   CacheManager)  │  │
│                 └─────────────────┘   └──────────────────┘  │
│                          │                     │             │
│                 ┌────────▼─────────────────────▼─────────┐  │
│                 │            ApiService (Dio)             │  │
│                 │  ┌─────────────────────────────────┐   │  │
│                 │  │  InterceptorsWrapper             │   │  │
│                 │  │  • Auto-attach Bearer token      │   │  │
│                 │  │  • Environment-aware error log   │   │  │
│                 │  │  • Timeout policies (30s)        │   │  │
│                 │  └─────────────────────────────────┘   │  │
│                 └────────────────────┬───────────────────┘  │
└──────────────────────────────────────┼──────────────────────┘
                                       │ HTTPS
                              ┌────────▼────────┐
                              │  Laravel API     │
                              │  (Sanctum Auth,  │
                              │   MySQL,         │
                              │   Paginated      │
                              │   Endpoints)     │
                              └─────────────────┘
```

### Data Flow — Stale-While-Revalidate (SWR)

```
User opens feed
      │
      ▼
fetchPostsService(page: 1)     ◀── Dart async* Stream generator
      │
      ├──▶ yield 1: Isar cache  ──▶ UI renders instantly (local data)
      │
      └──▶ yield 2: API response ──▶ UI seamlessly swaps in fresh data
                │                      (flicker-free page replacement)
                └──▶ Isar.writeTxn()  ──▶ Cache updated for next launch
```

> **Why a Stream?** A `Stream<PaginatedResult<Post>>` from `fetchPostsService` allows the controller to complete its `fetchPage` future on the **first** emission (cache or API), then silently patch the first page via `pagingController.value.copyWith(pages: ...)` on the second emission — preventing full-list rebuilds and eliminating flicker.

---

## Tech Stack

| Layer | Technology | Role in This Project |
|-------|-----------|---------------------|
| **Framework** | Flutter 3.x / Dart 3.x | Cross-platform UI with `ScreenUtilInit` for responsive scaling |
| **State Management** | GetX 4.7 | `GetxController` lifecycle, `Obx` reactive UI, `Get.lazyPut` DI |
| **Networking** | Dio 5.9 | Interceptor-based auth, `_safeRequest` wrapper, `ApiException` mapping |
| **Local Persistence** | Isar 3.1 (NoSQL) | `@collection` schemas for `Post`, `Reel`, `User`; indexed unique IDs |
| **Secure Storage** | flutter_secure_storage | Token persistence via OS keychain (not `SharedPreferences`) |
| **Video Playback** | video_player | Managed through ref-counted `VideoService` + `CustomCacheManager` |
| **Image Caching** | cached_network_image + flutter_cache_manager | Separated `ImageCacheService` (200 objects, 7-day stale period) |
| **Pagination** | infinite_scroll_pagination 5.x | `PagingController<int, Post>` with SWR-aware `fetchPage` |
| **Logging** | logger + custom `AppLogger` | Environment-gated (`kDebugMode`), structured, Crashlytics-ready |
| **Backend** | Laravel (PHP), MySQL, Sanctum | Custom REST API — developed by collaborator (see [Team](#the-team)) |

---

## Engineering Challenges Solved

### 🧠 OOM Crash on Media-Heavy Feeds — The "Rule of 3"

> Written in the STAR format for recruiters and engineering managers.

**Situation:**
During QA testing with 50+ mixed-media posts (carousel images + inline videos) and full-screen Reels, the app consistently crashed with `Out of Memory` on devices with ≤3 GB RAM. Android's native `MediaCodec` was holding multiple hardware video decoder surfaces simultaneously while `CachedNetworkImage` was decoding full-resolution bitmaps into the GPU texture cache.

**Task:**
Eliminate OOM crashes without sacrificing the UX of instant video playback. The user should never see a loading spinner when scrolling back to a previously-viewed reel.

**Action — a three-layer defense:**

1. **Reference-Counted `VideoService`** (`lib/core/services/video_service.dart`):
   Built a centralized `GetxService` that manages `VideoPlayerController` instances via a `Map<String, VideoPlayerController>` + `Map<String, int>` reference counter. When count drops to zero, the controller is `.dispose()`'d and removed. This prevents duplicate decoder allocations when multiple widgets request the same video URL.

2. **"Rule of 3" Enforcement** (`HomeController._enforceRuleOfThree` / `ReelsController._enforceRuleOfThree`):
   On every scroll or page change, controllers outside the `[i-1, i, i+1]` window are forcibly disposed via `MyVideoController.disposeVideo()`. This guarantees at most 3 native video decoders are alive at any time — well within Android's `MediaCodec` surface limit.

   ```dart
   void _enforceRuleOfThree(int currentIndex) {
     final keepRange = {currentIndex - 1, currentIndex, currentIndex + 1};
     final toRemove = _activeControllers.keys
         .where((i) => !keepRange.contains(i)).toList();
     for (final i in toRemove) {
       _activeControllers[i]?.disposeVideo();
       _activeControllers.remove(i);
     }
   }
   ```

3. **Nullable Controller Pattern** (`MyVideoController`):
   After `disposeVideo()`, the internal `_controller` reference is set to `null` — not just disposed. This prevents use-after-free crashes when async callbacks fire on a disposed controller. A `_pendingPause` flag captures pause intent during initialization, preventing a reel from playing even a single frame if the widget scrolled off-screen mid-async-init.

4. **Targeted Image Decoding:**
   All feed images use `memCacheWidth` / `memCacheHeight` constraints, decoding into the exact pixel budget needed for the current device width — not the source resolution. This alone cut peak memory by ~40% on a Pixel 4a test device.

**Result:**
OOM crashes dropped to zero across 100+ scroll cycles on a Samsung A12 (3 GB RAM). Video transitions remain instant thanks to the 2-ahead pre-caching strategy (`_preCacheAhead`), and tab switches trigger `cleanupAllVideos()` for full memory reclamation.

---

### 🛡️ Global Error Boundary

The entire app is wrapped in `runZonedGuarded` to intercept unhandled asynchronous Dart failures:

```dart
// main.dart
runZonedGuarded(() async {
  FlutterError.onError = (details) {
    AppLogger.error('Flutter UI Error', details.exception, details.stack);
  };
  ErrorWidget.builder = (details) => MyErrorWidget(details);
  // ... app bootstrap
  runApp(const Main());
}, (error, stack) {
  AppLogger.error('Unhandled Async Error', error, stack);
});
```

| Error Source | Handler | Behavior |
|-------------|---------|----------|
| Widget `build()` throw | `FlutterError.onError` | Logs + renders `MyErrorWidget` (debug: red screen; prod: expandable card) |
| Unhandled async `Future` / `Stream` | `runZonedGuarded` | Logs via `AppLogger.error`, prevents isolate crash |
| Dio network error | `InterceptorsWrapper.onError` | Maps to `ApiException` with status code, logs in debug only |
| Isar / cache error | `AppException` hierarchy | `NetworkException`, `ServerException`, `CacheException`, `UnknownException` |

The `AppLogger` is **environment-gated**: `DevelopmentFilter` in debug, `ProductionFilter` in release. The release path includes a `// TODO` hook for Crashlytics/Sentry forwarding.

---

## Key Features

### Authentication & Security
- Token-based auth via Laravel Sanctum/Passport
- Bearer token auto-injected via Dio `InterceptorsWrapper.onRequest`
- Tokens stored in OS keychain (`flutter_secure_storage`), never in `SharedPreferences`
- API key validation on every request

### Feed & Content
- Paginated home feed with `infinite_scroll_pagination`
- Multi-media post carousels (images + video in a single post)
- Full-screen vertical Reels with swipe navigation
- Stories with auto-advance timer (`pausable_timer`)
- Explorer grid with long-press preview
- Comments, likes (optimistic updates with rollback), saves, follows

### Offline & Caching
- Isar collections for `Post`, `Reel`, and `User` with `@Index(unique: true, replace: true)`
- SWR pattern: local-first → API refresh → cache update
- Separated cache managers: `customVideoCache` (50 objects, 3-day TTL) vs `customImageCache` (200 objects, 7-day TTL)
- Corrupted cache files auto-detected and purged (`VideoService.getController` fallback chain)

### Video Pipeline
- Pre-caching: 2-ahead download on every page fetch / page change
- Cache-hit playback from local filesystem, network fallback with `PlatformException` recovery
- Visibility-debounced play/pause via `VisibilityDetector` (200ms debounce)
- Full lifecycle management: register → play/pause → dispose → null

---

## Project Structure

```
lib/
├── main.dart                     # runZonedGuarded bootstrap, DI setup
├── app.dart                      # Root scaffold + bottom navigation
├── core/
│   ├── errors/
│   │   └── app_exceptions.dart   # AppException hierarchy (Network, Server, Cache, Unknown)
│   ├── models/
│   │   ├── post.dart             # Isar @collection with unique API ID index
│   │   ├── reel.dart             # Isar @collection with embedded User
│   │   ├── user.dart             # Shared user model (Isar-embedded)
│   │   ├── story.dart            # Story model
│   │   └── pagination_result.dart
│   ├── network/
│   │   ├── api_service.dart      # Dio wrapper, interceptors, _safeRequest
│   │   ├── api_exception.dart    # Network-layer exception
│   │   └── api_result.dart       # Sealed ApiResult<T> (ApiSuccess | ApiFailure)
│   ├── services/
│   │   ├── feed_cache_service.dart   # Isar singleton — cacheHomeFeed / getCachedHomeFeed
│   │   ├── video_service.dart        # Ref-counted VideoPlayerController pool
│   │   ├── image_cache_service.dart  # Dedicated CacheManager for images
│   │   └── storage_service.dart      # GetStorage + FlutterSecureStorage
│   ├── theme/                    # Light/dark theme data
│   ├── translations/             # Localization
│   └── utils/
│       ├── logger.dart           # AppLogger (env-gated, Crashlytics-ready)
│       ├── my_video_controller.dart  # Lifecycle-safe video wrapper
│       ├── helpers.dart
│       ├── custom_snackbar.dart
│       └── constants/
├── features/
│   ├── auth/                     # Sign in, sign up, OTP, password reset
│   ├── home/                     # Feed controller (SWR + Rule of 3), views
│   ├── reels/                    # Reels controller, per-reel player controller
│   ├── explorer/                 # Grid view with hold-to-preview
│   ├── story/                    # Story viewer with auto-advance
│   ├── profile/                  # User profile, edit profile
│   ├── posts/                    # Like, save, add post services
│   ├── comments/                 # Comments controller, views
│   ├── follows/                  # Follow/unfollow services
│   ├── search/                   # Search with local history
│   └── root/                     # AppController (tab switching, cleanup)
├── routes/
│   ├── app_pages.dart            # GetX route definitions with bindings
│   └── app_routes.dart           # Route constants
└── shared/
    ├── error_widget.dart         # Environment-aware error display
    ├── user_avatar.dart
    ├── search_field.dart
    ├── posts_grid/
    └── widgets/
```

---

## Getting Started

### Prerequisites

| Tool | Version |
|------|---------|
| Flutter SDK | ≥ 3.0.0 (stable channel) |
| Dart SDK | ≥ 3.0.0 < 4.0.0 |
| Android Studio / VS Code | Latest |
| Laravel Backend | Running instance (local or remote) |

### 1. Clone & Install

```bash
git clone https://github.com/your-username/instagram-clone.git
cd instagram-clone
flutter pub get
```

### 2. Generate Isar Schemas

The `Post`, `Reel`, and `User` models use Isar `@collection` annotations. The generated `*.g.dart` files **must** exist before the app compiles:

```bash
dart run build_runner build --delete-conflicting-outputs
```

> **Note:** If you modify any `@collection` model, re-run the command above. The `--delete-conflicting-outputs` flag ensures stale generators are purged.

### 3. Configure Environment

Copy the example and set your values:

```bash
cp .env.example .env
```

Edit `.env`:

```env
API_URL=https://your-laravel-api-url.com
API_KEY=your_api_key_here
```

> **Local development:** If running the Laravel backend locally (e.g., `php artisan serve`), use your machine's local IP (not `localhost`) when testing on a physical device. For an emulator, `10.0.2.2` maps to the host machine.

### 4. Run

```bash
flutter run
```

### Backend Setup (Laravel — Collaborator's Repo)

If running the backend locally:

```bash
# In the Laravel project directory
composer install
cp .env.example .env        # Configure DB credentials
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

---

## 🔄 Project History — From Prototype to Production-Grade

This project was **not** started as the codebase you see today. It began as a rapid prototype — a learning-stage Flutter project with minimal architecture: raw `http` calls scattered across widgets, no offline strategy, no structured error handling, and video controllers that were never properly disposed.

The systems documented in this README — the Dio interceptor pipeline, the Isar SWR layer, the `VideoService` reference-counting pool, the `AppException` hierarchy, `runZonedGuarded`, and the Rule of 3 memory enforcement — were all **retrofitted incrementally** over successive refactoring passes as my engineering standards evolved.

### What was rebuilt

| Area | Before (v1) | After (Current) |
|------|-------------|-----------------|
| **Networking** | Direct `http.get()` calls in controllers | Centralized `ApiService` with Dio interceptors, `_safeRequest` wrapper, `ApiException` mapping |
| **Auth tokens** | Stored in `SharedPreferences` (plaintext) | `FlutterSecureStorage` (OS keychain), cached in-memory for synchronous reads |
| **Offline support** | None — blank screen on network failure | Isar NoSQL persistence with SWR `async*` Stream pattern |
| **Video memory** | Unbounded `VideoPlayerController` allocation | Ref-counted `VideoService`, Rule of 3 enforcement, nullable controller pattern |
| **Error handling** | Unhandled → Red Screen of Death | `runZonedGuarded` + `FlutterError.onError` + `MyErrorWidget` + typed `AppException` hierarchy |
| **Logging** | `print()` statements | Structured `AppLogger` with environment gating and Crashlytics-ready hooks |
| **Project structure** | Flat file layout | Feature-first modular architecture (`features/`, `core/`, `shared/`) |

### What still reflects the original codebase

Legacy doesn't disappear overnight. Some areas intentionally remain closer to their original form — they work correctly but don't yet meet the same engineering bar as the systems above:

- **Some view files** still contain inline business logic that would ideally be extracted to dedicated service layers.
- **Test coverage** is limited; the refactoring prioritized runtime stability (crash elimination) over unit test infrastructure.
- **Certain naming conventions** and file organization in older features predate the current architectural standards.

> **Why share this?** Refactoring a living codebase under real constraints — without a full rewrite — is a core production engineering skill. The ability to identify technical debt, prioritize high-impact improvements (memory safety, crash prevention, offline resilience), and ship incrementally is more representative of professional work than a greenfield project that starts clean.

---

## The Team

This project was built collaboratively, dividing responsibilities across the full stack:

| Role | Responsibility | Scope |
|------|---------------|-------|
| **Frontend Engineer** — [Saleem Mahdi](https://github.com/saleem-15) | Flutter architecture, GetX state management, Isar persistence layer, Dio networking pipeline, video memory management, global error boundary, UI/UX | This repository |
| **Backend Engineer** — [Mohammed Al-Ajil](https://github.com/Mohammed-Alijl/) | Laravel API architecture, MySQL schema design, Sanctum authentication, paginated endpoint design, media upload handling | [Backend Repository](https://github.com/Mohammed-Alijl/instagram-API) |

---

## License

This project is for educational and portfolio purposes. Not affiliated with Instagram or Meta.

---

<p align="center">
  Built with ❤️ for performance and scalability.
</p>
