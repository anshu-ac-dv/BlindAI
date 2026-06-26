# 🚀 Blind AI - iOS Launch Image Assets

This directory contains the launch screen (splash screen) assets for the **Blind AI** iOS application. These images are displayed immediately when the user taps the app icon, before the Flutter engine initializes.

## 📁 Asset Specifications

To maintain a seamless transition to the app's internal `SplashScreen`, ensure these images align with the brand identity:
- **Background Color:** `#0F0F15` (Deep Dark)
- **Primary Font:** Outfit
- **Accent Colors:** Purple (`#673AB7`) & Pink (`#FF4081`)

| File Name | Scale | Usage |
| :--- | :--- | :--- |
| `LaunchImage.png` | 1x | Standard resolution devices |
| `LaunchImage@2x.png` | 2x | High-resolution Retina displays |
| `LaunchImage@3x.png` | 3x | Super Retina displays (iPhone X and newer) |

## 🛠 How to Update

### Method 1: Direct Replacement
1. Prepare your new logo/splash image in three sizes (1x, 2x, 3x).
2. Overwrite the existing `.png` files in this directory.
3. Ensure the `Contents.json` file remains intact.

### Method 2: Using Xcode
1. Open the project in Xcode: `open ios/Runner.xcworkspace`.
2. Navigate to `Runner` > `Assets.xcassets` > `LaunchImage`.
3. Drag and drop your new images into the respective slots (1x, 2x, 3x).

---
> **Tip:** Since **Blind AI** uses a custom animated splash screen (`lib/splash_screen.dart`), it is recommended to use a simple centered version of the logo on a solid `#0F0F15` background for these static assets. This ensures a seamless visual handoff when the app finishes loading.
