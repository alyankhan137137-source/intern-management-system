# Welcome Screen & Mock Authentication Implementation Plan

Build the foundational UI and authentication flow for the Intern Management System using mock data and professional design principles.

## User Review Required

> [!IMPORTANT]
> The implementation will use `StatefulWidget` for managing local UI state (loading, validation) as no external state management library (like Provider or Riverpod) is currently in `pubspec.yaml`.

## Proposed Changes

### Data Layer

#### [NEW] [user.dart](file:///E:/MY ALL FLUTTER PROJECT FILE/intern_management_system/lib/models/user.dart)
- Define `UserModel` with `email`, `role` (Intern/Admin), and basic metadata.

#### [NEW] [auth_service.dart](file:///E:/MY ALL FLUTTER PROJECT FILE/intern_management_system/lib/services/auth_service.dart)
- Implement `MockAuthService` containing:
    - Hardcoded credentials for `alyankhan@internee.pk` and `alyankhan12@gmail.com`.
    - `login(email, password, role)` method with simulated 1.5s delay.

### UI Components

#### [MODIFY] [welcome_screen.dart](file:///E:/MY ALL FLUTTER PROJECT FILE/intern_management_system/lib/views/welcome_screen.dart)
- Redesign with a professional hero layout.
- Update copywriting to be precise and professional (e.g., "Centralized Lifecycle Management for Internship Programs").
- Add navigation to the Login Screen.
- Implement subtle lift states (2-4px) on interaction for CTA buttons.

#### [NEW] [login_screen.dart](file:///E:/MY ALL FLUTTER PROJECT FILE/intern_management_system/lib/views/login_screen.dart)
- Create a dual-mode login interface (Intern vs Admin toggle).
- Implement `Form` validation with inline error messages.
- Add an `isLoading` state to the login button that replaces text with a `CircularProgressIndicator`.

#### [NEW] [home_screen.dart](file:///E:/MY ALL FLUTTER PROJECT FILE/intern_management_system/lib/views/home_screen.dart)
- Create a simple placeholder dashboard to verify successful login.

## Verification Plan

### Manual Verification
- **Welcome Screen**: Check layout responsiveness and button interaction styles.
- **Form Validation**: Trigger empty or invalid email/password inputs to see inline errors.
- **Login Flow**:
    - Test "Intern Login" with `alyankhan@internee.pk` / `123456`.
    - Test "Admin Login" with `alyankhan12@gmail.com` / `123456`.
    - Verify loading state appears in the button.
    - Verify successful navigation to the Home screen.
