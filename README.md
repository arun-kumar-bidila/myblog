# myblog

**myblog** is a cross‑platform blogging application built with Flutter. It
provides a clean UI for creating and viewing blog posts, and is
architected for scalability with modular features, state management.

---

## 🗂 Folder structure

The project follows the standard Flutter directory layout:

```
myblog/
├── android/        ← Android Gradle project (Kotlin)
│   ├── app/        ← application module
│   └── build.gradle.kts, …
├── ios/            ← iOS Xcode project
├── linux/          ← Linux desktop support (CMake)
├── macos/          ← macOS desktop support
├── windows/        ← Windows desktop support (CMake)
├── lib/            ← Dart source code for the app
│   ├── common/
│   ├── core/
│   ├── features/
│   ├── init_dependencies.dart
│   ├── main.dart
│   └── splash_screen.dart
├── assets/         ← static assets (images, fonts, etc.)
├── test/           ← unit/widget tests
├── web/            ← web support (index.html)
├── build/          ← build outputs (ignored by git)
├── pubspec.yaml    ← Dart/Flutter package manifest
├── analysis_options.yaml ← linting rules
└── README.md       ← this file
```


### Source code conventions

- `lib/` is split into `common`, `core`, and `features` packages.
- Initialization logic lives in `init_dependencies.dart`.
- Entry point is `main.dart` and a simple splash screen lives in
  `splash_screen.dart`.

---

## 🛠️ Technologies & versions

The application is built with the following core SDKs and packages:

| Component                        | Version                 |
| -------------------------------- | ----------------------- |
| Flutter SDK                      | 3.38.9 (stable channel) |
| Dart SDK                         | 3.10.8                  |
| cupertino_icons                  | ^1.0.8                  |
| fpdart                           | ^1.2.0                  |
| supabase_flutter                 | ^2.12.0                 |
| flutter_bloc                     | ^9.1.1                  |
| dio                              | ^5.9.1                  |
| get_it                           | ^9.2.0                  |
| flutter_secure_storage           | ^10.0.0                 |
| dotted_border                    | ^3.1.0                  |
| image_picker                     | ^1.2.1                  |
| intl                             | ^0.20.2                 |
| internet_connection_checker_plus | ^2.9.1+2                |
| go_router                        | ^17.1.0                 |
| flutter_spinkit                  | ^5.2.2                  |
| pin_code_fields                  | ^9.0.0                  |

> All package versions are defined in `pubspec.yaml`. Run
> `flutter pub outdated` to check for upgrades.

---

## 🚀 Setup & development

To get the project running locally:

1. **Install prerequisites**
   - [Flutter SDK 3.38.9](https://docs.flutter.dev/get-started/install)
   - A supported IDE (VS Code, Android Studio, etc.) with Flutter/Dart plugins
   - Android SDK or Xcode if you plan to target mobile platforms
   - Optional desktop tooling (Visual Studio for Windows, etc.)

2. **Clone the repository**

   ```bash
   git clone <repo-url> myblog
   cd myblog
   ```

3. **Fetch dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the app**
   - Mobile: `flutter run` (connect a device or emulator)
   - Web: `flutter run -d chrome`
   - Desktop: `flutter run -d windows` (or `linux`/`macos`)

5. **Analyze & format**

   ```bash
   flutter analyze
   flutter format .
   ```

6. **Execute tests**
   ```bash
   flutter test
   ```


