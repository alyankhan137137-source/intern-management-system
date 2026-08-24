# Implementation Plan - Core Structure & Splash Screen

Create the foundational structure for the Intern Management System Flutter app, including professional theming, constants, and a minimalist splash screen.

## User Review Required

> [!IMPORTANT]
> - I will be adding `google_fonts` and `flutter_svg` dependencies to your `pubspec.yaml`.
> - A placeholder logo (Flutter icon) will be used in the Splash Screen if no vector logo asset is provided. You can later replace it in `assets/logo.svg`.
> - The project will be reorganized into standard Flutter folders (models, views, widgets, services, providers).

## Proposed Changes

### Dependencies & Assets
#### [MODIFY] [pubspec.yaml](file:///E:/intern_management_system/pubspec.yaml)
- Add `google_fonts` and `flutter_svg`.
- Register `assets/` folder.

### Core & Styling
#### [NEW] [app_constants.dart](file:///E:/intern_management_system/lib/core/app_constants.dart)
- Define spacing units (8, 16, 24px).
- Define border radius (8px, 12px).
#### [NEW] [app_theme.dart](file:///E:/intern_management_system/lib/core/app_theme.dart)
- Define `AppColors` (Deep Slate #0F172A, Neutral #F8FAFC, Accent #2563EB).
- Configure `ThemeData` using Google Fonts (Inter).

### Views
#### [NEW] [splash_screen.dart](file:///E:/intern_management_system/lib/views/splash_screen.dart)
- Implement minimalist UI with centered logo.
- Add fade-in animation using `AnimatedOpacity` or `TweenAnimationBuilder`.
- Implement 2-second delay before navigating to `WelcomeScreen`.
#### [NEW] [welcome_screen.dart](file:///E:/intern_management_system/lib/views/welcome_screen.dart)
- Placeholder screen for post-splash navigation.

### Main Entry
#### [MODIFY] [main.dart](file:///E:/intern_management_system/lib/main.dart)
- Update to use `AppTheme`.
- Set `SplashScreen` as the initial route.

## Verification Plan

### Manual Verification
- Run the app to verify the Splash Screen animation.
- Ensure transition to Welcome Screen happens after 2 seconds.
- Verify typography (Inter) and colors (Deep Slate/Neutral) are applied correctly.
