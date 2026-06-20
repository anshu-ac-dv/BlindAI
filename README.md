# Blind AI - Voice & Vision Assistant

A Flutter-based AI assistant designed with Clean Architecture to help users through voice and vision.

## Features
- **Unique & Dynamic Design**: Modern Indigo/Pink theme with glassmorphism-inspired elements and smooth animations.
- **Custom Animated Logo**: A signature "Eye" logo with rotating frames and pulse effects.
- **Clean Architecture**: Organized into features (Auth, Chat, Splash) and core services.

## Project Structure
- `lib/core`: Shared models and services (TTS, Speech).
- `lib/features/auth`: Authentication logic and UI.
- `lib/features/chat`: AI interaction logic and UI.
- `lib/features/splash`: Initial loading and auth routing.

## Setup
1. Run `flutter pub get` to fetch dependencies.
2. Setup Firebase for your project and add the configuration files.
3. Configure your Gemini API key in `lib/features/chat/services/api_service.dart`.
