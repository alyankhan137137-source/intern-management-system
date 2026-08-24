# Intern Management System (IMS)

A professional, centralized lifecycle management platform for internship programs built with Flutter. IMS simplifies tracking, documentation, and talent empowerment through a modern, responsive interface.

## 🚀 Key Features

- **Professional Hero UI**: A clean, modern Welcome Screen designed with Material 3 principles and high-fidelity interactions.
- **Dual-Mode Authentication**: Specialized login flows for both **Interns** and **Administrators**.
- **Mock Data Layer**: Fully functional authentication service using local mock data for rapid prototyping and demonstration.
- **Interactive UX**: 
  - Subtle 4px lift states on interaction.
  - Form validation with inline error messaging.
  - Integrated loading states during simulated network processes.

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)
- **UI Toolkit**: Material 3
- **Fonts**: Google Fonts (Inter)
- **Icons**: Material Icons & Cupertino Icons

## 🔑 Mock Credentials

For testing purposes, the following accounts are pre-populated:

| Role | Email | Password |
| :--- | :--- | :--- |
| **Admin** | `alyankhan12@gmail.com` | `123456` |
| **Intern** | `alyankhan@internee.pk` | `123456` |

## 📦 Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/intern_management_system.git
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

## 📂 Project Structure

- `lib/core`: App themes, constants, and global configurations.
- `lib/models`: Data models (e.g., `UserModel`).
- `lib/services`: Business logic and mock data services (e.g., `AuthService`).
- `lib/views`: UI screens (Welcome, Login, Home, etc.).
- `lib/widgets`: Reusable UI components.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
