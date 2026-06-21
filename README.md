# 👁️ Blind AI - Visionary Voice Assistant

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)](https://firebase.google.com/)
[![Gemini](https://img.shields.io/badge/Google%20Gemini-8E75B2?style=for-the-badge&logo=googlegemini&logoColor=white)](https://aistudio.google.com/)

**Blind AI** is a cutting-edge mobile assistant designed to empower visually impaired users. By combining the power of **Google Gemini 1.5 Flash** with a highly accessible, animated interface, it acts as a digital "set of eyes" for those who need it most.

---

## ✨ Key Features

- **📸 Intelligent Vision**: Snap a photo, and the AI provides a detailed, context-aware description of your surroundings.
- **🗣️ Voice-First Interaction**: Designed for accessibility with high-contrast UI and voice-compatible layouts.
- **🎭 Fluid Experience**: Powered by `flutter_animate`, the app features a "living" UI that pulses and reacts to user input.
- **🔐 Secure Access**: Robust authentication powered by Firebase, ensuring user data and chat history remain private.
- **🌈 Modern Design**: A premium Indigo & Pink glassmorphism theme that is both beautiful and functional.

---

## 🏗️ Clean Architecture

The project follows a modular **Clean Architecture** pattern to ensure scalability and maintainability:

-   📂 `lib/core`: The backbone. Contains shared models, navigation utilities, and base services (TTS/Speech).
-   📂 `lib/features/auth`: Handles user identity, signup, login, and password recovery.
-   📂 `lib/features/chat`: The "brain" of the app. Manages Gemini AI integration and image processing.
-   📂 `lib/features/splash`: Manages app initialization and routing logic.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Multi-platform)
- **AI Engine**: [Google Generative AI](https://pub.dev/packages/google_generative_ai) (Gemini 1.5 Flash)
- **Backend**: [Firebase Auth](https://firebase.google.com/products/auth)
- **Animations**: [Flutter Animate](https://pub.dev/packages/flutter_animate)
- **Environment**: [Flutter Dotenv](https://pub.dev/packages/flutter_dotenv) for secure API key management.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (`>=3.0.0`)
- A Firebase Project
- A Gemini API Key (get it at [Google AI Studio](https://aistudio.google.com/))

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/blind_ai.git
   cd blind_ai
   ```

2. **Setup Environment Variables**
   Create a `.env` file in the root directory:
   ```env
   GEMINI_API_KEY=your_actual_key_here
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

---

## 🤝 Contributing

Contributions make the open-source community an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License
Distributed under the MIT License. See `LICENSE` for more information.

<p align="center">Made with ❤️ for a more accessible world.</p>
