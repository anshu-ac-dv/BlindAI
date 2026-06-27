# <p align="center"><img src="web/icons/Icon-512.png" alt="BlindAI Logo" width="120" /><br>BlindAI</p>

<p align="center">
  <strong>Perceive the world through intelligent, voice-guided vision.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/BLoC-5FB8FF?style=for-the-badge&logo=bloc&logoColor=white" alt="BLoC" />
  <img src="https://img.shields.io/badge/Material--3-7C4DFF?style=for-the-badge&logo=materialdesign&logoColor=white" alt="Material 3" />
</p>

---

## 🌟 The Vision

**BlindAI** is an advanced assistive ecosystem designed to empower visually impaired individuals. It leverages state-of-the-art **Artificial Intelligence** and **Computer Vision** to provide real-time environment interpretation, turning visual data into actionable audio feedback.

Built with a **Deep Dark** aesthetic for high-contrast accessibility and a **Voice-First** philosophy, BlindAI is more than an app—it's a digital companion.

---

## ✨ Intelligent Features

### 🎙️ Voice Interaction
- **Smart Command Processing**: Use natural language to navigate the app and trigger AI functions.
- **Interactive Voice Feedback**: Real-time audio cues and detailed descriptions of all AI operations.

### 📸 Computer Vision Suite
- **Scene Intelligence**: High-fidelity descriptions of surroundings, identifying objects, people, and spatial layouts.
- **OCR Engine (Text-to-Speech)**: Rapidly extract text from any surface and hear it read aloud with natural-sounding voices.
- **Color Specialist**: Accurate color detection to assist in daily tasks, from matching outfits to identifying groceries.

### 🛠️ Core Capabilities
- **Secure Cloud Sync**: All activity history and settings are securely backed up using Firebase.
- **Deep Dark Mode**: A signature `#121212` theme designed specifically for maximum readability and reduced eye strain.
- **Haptic Navigation**: Tactile feedback for every interaction, ensuring confidence during usage.

---

## 🏗️ Architectural Excellence

BlindAI follows the **Clean Architecture** pattern, ensuring the project remains scalable, testable, and maintainable as it grows.

### 📐 Layer Breakdown
- **Domain Layer**: Contains pure business logic, entities, and use cases (e.g., `ProcessCommandUseCase`).
- **Data Layer**: Manages data flow from Firebase, ML Kit, and local repositories.
- **Presentation Layer**: Implements **BLoC/Cubit** for robust state management and Material 3 for the UI.

---

## 🎨 Design Identity

| Element | Specification |
| :--- | :--- |
| **Theme System** | Adaptive Dark/Light (Optimized for Accessibility) |
| **Primary Color** | Deep Purple (`#673AB7`) |
| **Accent Color** | Vibrant Pink (`#FF4081`) |
| **Typography** | Poppins (Google Fonts) |
| **Corner Radius** | 15px (Fluid Material 3 Style) |
| **Animations** | `flutter_animate` for smooth transitions |

---

## 📁 Repository Structure

```text
lib/
├── core/                # Shared utilities, themes, and global error handling
├── features/            # Feature-driven modules (Auth, Vision, Home, etc.)
│   ├── auth/            # Firebase Authentication logic & UI
│   ├── vision/          # AI processing for Scene, Text, and Color
│   ├── home/            # Voice-enabled command center
│   ├── history/         # Searchable log of past interactions
│   └── settings/        # Voice speed and theme personalization
├── injection_container.dart # Service Locator (Get_It) configuration
└── main.dart            # Entry point for the Flutter application
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
    *   Initialize Firebase for your project.
    *   Place `google-services.json` / `GoogleService-Info.plist` in the respective folders.

4.  **Run the App**
    ```bash
    flutter run
    ```

---

<p align="center">
  <strong>Committed to building a world without visual barriers.</strong><br>
  Developed with ❤️ using Flutter & Firebase.
</p>
