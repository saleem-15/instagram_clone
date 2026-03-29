<h1 align="center">Instagram Clone (Flutter)</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/GetX-%23E84393.svg?style=for-the-badge" />
</p>

## 📖 About This Project

This project is a feature-rich, complex Instagram clone built with Flutter. It was originally developed in late 2022 to push the boundaries of mobile UI development, focusing on scalable state management, robust networking, and intricate native-like animations.

> **Note on Backend:** The backend for this application is a custom Laravel API developed by a colleague. You can view the backend repository here: [Insert Backend Repository Link Here]

### 💡 The Developer's Backstory
> *"I built this application to prove my capability in handling complex architectural patterns in Flutter. However, due to the war in Gaza, my career was placed on an unavoidable, forced hiatus from July 2023 to January 2026—a period where I survived without basic infrastructure like electricity and internet. Returning to the tech industry, the first thing I did was successfully compile and modernize this codebase. This project stands not just as a portfolio piece, but as a testament to my profound resilience, adaptability, and unwavering dedication to software engineering."*

---

## 📸 Visual Showcase

*(Recruiters: Replace these placeholders with actual screenshots or GIFs showing the app running in Light and Dark mode, and a GIF of scrolling through Reels/Stories).*

| Feed & Explore | Reels & Video Playback | Profile & Dark Mode |
| :---: | :---: | :---: |
| <img src="[Link to Feed Image 1]" width="250"/> | <img src="[Link to Reels GIF]" width="250"/> | <img src="[Link to Profile Image]" width="250"/> |

---

## 🛠 Technical Highlights & Architecture

This application goes far beyond a standard "UI clone," implementing real-world engineering solutions for complex mobile problems.

*   **Clean Architecture & State Management (GetX):** 
    Engineered using a strict, clean, module-based folder structure (separating bindings, controllers, and views). Leveraged GetX for highly reactive state management, seamless dependency injection, and efficient route handling.
*   **Robust Networking Layer (Dio):** 
    Implemented a scalable REST API communication layer utilizing the `dio` package, ensuring structured error handling and reliable data fetching across the app.
*   **High-Performance UI & Media Handling:** 
    *   **Infinite Feeds:** Utilized `infinite_scroll_pagination` to handle massive datasets gracefully, providing a seamless scrolling experience without memory leaks.
    *   **Concurrent Media:** Integrated `video_player` and `carousel_slider` to build complex, memory-efficient Reels and Story views.
*   **State-of-the-Art Responsiveness:** 
    Integrated `flutter_screenutil` to dynamically scale UI topography and typography, guaranteeing pixel-perfect layouts across any screen size or orientation.
*   **Intelligent Routing:** 
    Handles dynamic routing edge cases, including smart detection of device SafeAreas (`Navigator.canPop(context)`) to automatically resolve status-bar padding conflicts in nested navigation flows.

---

## ✨ App Features

- **Authentication:** Secure user sign-up/sign-in with OTP verification and password recovery capabilities.
- **Infinite Feeds:** Seamlessly scroll through global and personalized post feeds using robust pagination metrics.
- **Reels & Video Integration:** A fully functional, swipeable vertical video feed with custom caching to optimize playback performance.
- **Stories System:** Horizontal tap-to-progress story viewing with duration indicators and media management.
- **Profile Management:** Comprehensive profiles including edit functionality, follower/following management, and a dedicated saved posts grid.
- **Engagement:** Like, save, and comment on posts with support for nested comment replies and animated UI feedback.
- **Search & Discovery:** Robust search functionality with recent search history and dedicated user result views.

---

## 🎯 Core Architecture

This project strictly adheres to a robust architectural pattern leveraging **GetX** and a dedicated Service Layer:

- **Controllers:** Manages business logic and highly reactive state execution.
- **Bindings:** Handles dependency injection, ensuring controllers/services are strictly memory-managed.
- **Services:** A dedicated Data Abstraction Layer exclusively handling API calls and database operations.
- **Views/Screens:** Pure UI components observing the state.
- **Models:** Strongly typed data structures for JSON serialization.

### Design Patterns Used
- **MVC Pattern:** Clean separation of concerns between UI, Data, and business logic.
- **Repository / Service Pattern:** Abstracts all network/data operations away from controllers.
- **Dependency Injection:** Ensures loose coupling and lifecycle management via GetX bindings.
- **Singleton Pattern:** Shared API services and global controllers are instantiated once for memory efficiency.
- **Observer Pattern:** Implements reactive state management (`Obx`, `Rx`) for flawless UI updates without calling `setState`.

---

## 🚀 Getting Started

If you are a recruiter or an engineer who wants to pull and test the code locally:

### Prerequisites
- Flutter SDK (>= 2.17.6)
- Android Studio / Xcode

### Installation

1. Clone the repository:
   ```bash
   git clone [Your Repository URL Here]
   ```
2. Navigate to the directory:
   ```bash
   cd instagram_clone
   ```
3. Get the packages:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```
