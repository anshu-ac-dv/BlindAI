# <p align="center"><img src="web/icons/Icon-512.png" alt="BlindAI Logo" width="120" /><br><strong>BLINDAI</strong><br><small>Perceive with intelligence</small></p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/BLoC-5FB8FF?style=for-the-badge&logo=bloc&logoColor=white" alt="BLoC" />
  <img src="https://img.shields.io/badge/Material--3-7C4DFF?style=for-the-badge&logo=materialdesign&logoColor=white" alt="Material 3" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square" alt="PRs Welcome" />
  <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=flat-square" alt="Maintained" />
  <img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square" alt="License" />
</p>

---

## 🌌 The Vision

> "Empowering the visually impaired to navigate the world with confidence and independence through the power of AI."

**BlindAI** is an advanced assistive ecosystem designed to empower visually impaired individuals. It leverages state-of-the-art **Artificial Intelligence** and **Computer Vision** to provide real-time environment interpretation, turning visual data into actionable audio feedback.

Built with a **Deep Dark** aesthetic for high-contrast accessibility and a **Voice-First** philosophy, BlindAI is more than an app—it's a digital companion.

---

## ✨ Intelligent Features

| Feature | Description | Icon |
| :--- | :--- | :---: |
| **Voice Interaction** | Smart Command Processing & Interactive Voice Feedback | 🎙️ |
| **Scene Intelligence** | High-fidelity descriptions of surroundings | 📸 |
| **OCR Engine** | Text-to-Speech: Extract and hear text from any surface | 📄 |
| **Color Specialist** | Accurate color detection for daily tasks | 🎨 |
| **Secure Sync** | Firebase backed activity history and settings | ☁️ |
| **Haptic Navigation** | Tactile feedback for every interaction | 📳 |

---

## 🏗️ Architectural Excellence

BlindAI follows the **Clean Architecture** pattern, ensuring the project remains scalable, testable, and maintainable.

### 📐 Layer Breakdown
- **🔵 Domain Layer**: Pure business logic, entities, and use cases.
- **🟢 Data Layer**: Data flow from Firebase, ML Kit, and local repositories.
- **🔴 Presentation Layer**: BLoC/Cubit state management and Material 3 UI.

---

## 🎨 Design Identity

| Element | Specification |
| :--- | :--- |
| **Theme System** | 🌙 Adaptive Dark/Light (Optimized) |
| **Primary Color** | 🟣 Deep Purple (`#673AB7`) |
| **Accent Color** | 💖 Vibrant Pink (`#FF4081`) |
| **Typography** | 🖋️ Poppins (Google Fonts) |
| **Animations** | ✨ `flutter_animate` |

---

## 📁 Repository Structure

```text
lib/
├── ⚙️ core/                # Utilities, themes, and global error handling
├── 📦 features/            # Feature-driven modules
│   ├── 🔐 auth/            # Firebase Authentication
│   ├── 👁️ vision/          # Scene, Text, and Color AI
│   ├── 🏠 home/            # Voice-enabled command center
│   ├── 📜 history/         # Searchable interaction logs
│   └── 🛠️ settings/        # Personalization
├── 💉 injection_container.dart
└── 🚀 main.dart            # Entry point
```

---

## 🚀 Installation & Setup

1.  **Clone the Repository**
    ```bash
    git clone https://github.com/yourusername/blind_ai.git
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Firebase Configuration**
    *   Initialize Firebase and place `google-services.json` / `GoogleService-Info.plist` in the respective folders.

4.  **Run the App**
    ```bash
    flutter run
    ```

---

<p align="center">
  <strong>Committed to building a world without visual barriers.</strong><br>
  Developed with ❤️ using Flutter & Firebase.
</p>

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=100&section=footer" />
</p>
