# 👁️ BlindAI

**Perceive with intelligence.**

BlinAI is a modern Flutter application designed to provide intelligent assistance through a sleek, accessible, and high-performance interface. Built with a focus on dark aesthetics and smooth animations, it leverages the power of AI to help users perceive their surroundings.

---

## ✨ Features

- **🚀 Animated Splash Screen**: A beautiful, high-performance entrance with shimmer effects and smooth transitions.
- **🔐 Secure Authentication**: Integrated with Firebase for robust user management (Auth BLoC).
- **🌓 Dynamic Theming**: Support for Light and Dark modes, with a deep dark (#0F0F15) signature theme.
- **🧩 Clean Architecture**: Built using a feature-based folder structure, ensuring scalability and maintainability.
- **💉 Dependency Injection**: Managed via `get_it` for clean code and easy testing.

---

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [BLoC / Cubit](https://pub.dev/packages/flutter_bloc)
- **Backend:** [Firebase](https://firebase.google.com/)
- **Animations:** [Flutter Animate](https://pub.dev/packages/flutter_animate)
- **Dependency Injection:** [Get It](https://pub.dev/packages/get_it)
- **Typography:** [Google Fonts (Outfit)](https://fonts.google.com/specimen/Outfit)

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio / VS Code
- A Firebase project

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/blind_ai.git
   cd blind_ai
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Ensure you have the [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/) installed.
   - Run `flutterfire configure` to generate `lib/firebase_options.dart`.

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📁 Project Structure

```text
lib/
├── core/               # Shared logic, themes, and failures
│   ├── theme/          # AppTheme and ThemeBloc
│   ├── error/          # Failure classes
│   └── usecases/       # Base UseCase classes
├── features/           # Feature-driven modules
│   ├── auth/           # Login, Sign up, Auth BLoC
│   └── home/           # Main dashboard
├── injection_container.dart # Dependency injection setup
└── main.dart           # Entry point
```

---

## 🎨 Design Identity

- **Background:** Deep Dark (`#0F0F15`)
- **Primary Accent:** Purple (`#673AB7`)
- **Secondary Accent:** Pink (`#FF4081`)
- **Font Family:** Outfit

---

## 🤝 Contributing

Contributions are welcome! If you have suggestions or want to add new features, feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
