# SMEfin - SME Financing Application

A production-ready Flutter application for SME business registration and financing requests, built with clean architecture principles.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Project Structure](#project-structure)
- [Assumptions & Trade-offs](#assumptions--trade-offs)

## 🎯 Overview

SMEfin is a cross-platform mobile application that enables Small and Medium Enterprises (SMEs) to register their business details and request financing. The app features a multi-step onboarding flow with offline support, automatic draft saving, and image compression.


## Light Mode Screen Shorts
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/4470b25b-1cf2-4eda-a23f-34abb1ec63d5" alt="Screenshot 1" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/90b53a09-f3b5-4b49-90d3-3cb008d52e1e" alt="Screenshot 2" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/0a2e77fb-77e0-4d4d-ae18-b1d458acee03" alt="Screenshot 3" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/20b4571d-1082-4ace-8c59-466e395e02ba" alt="Screenshot 4" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/b46dd757-89f5-46d2-b820-dd754bce7ca1" alt="Screenshot 5" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/5995a5ce-e801-4f08-b47d-0eaeedf4f7e7" alt="Screenshot 6" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/9bf3ee10-da90-4237-991a-c1a9d95d5ea6" alt="Screenshot 7" width="120"></td>
  </tr>
</table>

## Dark Mode Screen Shorts
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/b68e4d15-03fb-49b0-afec-4a3b5eedb1a4" alt="Screenshot 1" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/b769440b-5f9b-41e2-8259-29c1dd2a9881" alt="Screenshot 2" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/609d067d-aa67-4b7e-9446-35a1cfea3248" alt="Screenshot 3" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/cb7d6684-5451-42a1-8fe7-d746a6f2725e" alt="Screenshot 4" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/46369377-90a6-4388-9371-5bf2caec22f8" alt="Screenshot 5" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/4fa21820-3809-4a98-ac67-3217e21809c0" alt="Screenshot 6" width="120"></td>
    <td><img src="https://github.com/user-attachments/assets/7a8e01a9-aa7f-46c3-b8b2-cd8b3eba4835" alt="Screenshot 7" width="120"></td>
  </tr>
</table>

<br/>  

## Download the App

You can download the latest APK of the app from Google Drive:

[Download APK](https://drive.google.com/file/d/18mhthcwxdwZGfZ9bOX5Ql_azRADhWRih/view?usp=sharing)

<br/>  

## ✨ Features

### Core Functionality
- **Multi-step Onboarding Flow**
    - Email verification
    - Personal details collection
    - Business information capture
    - Trade license document upload
    - Summary confirmation

- **Offline Support**
    - Automatic draft saving using Hive
    - Data restoration on app restart
    - Offline-first architecture

- **Image Handling**
    - On-device image compression before upload
    - Support for multiple file formats (PDF, JPG, PNG)
    - Optimized storage and transmission

- **Network Simulation**
    - Mock API with artificial delays
    - Random success/failure scenarios (80% success rate)
    - Realistic error handling

- **UI/UX**
    - Material 3 design components
    - Dark mode support
    - Loading states and error handling with retry
    - Progress indicators

## 🏗️ Architecture

The project follows **Feature-First Clean Architecture** with clear separation of concerns:

```
.
└── lib/
    └── src/
        ├── core/
        │   ├── di/              # Dependency injection (get_it)
        │   ├── errors/          # Error handling (failures & exceptions)
        │   ├── network/         # Network layer (Dio, connectivity)
        │   ├── routes/          # Navigation (go_router)
        │   ├── services/        # Local storage (Hive), SnackBar, etc.
        │   ├── theme/           # App theming (Material 3)
        │   └── utils/           # Utilities (App Constants, validators, image compression, etc.)
        └── features/
            └── onboarding/
                ├── data/
                │   ├── datasources/
                │   │   ├── local_datasource.dart    # Hive implementation
                │   │   └── remote_datasource.dart   # Mock Dio API
                │   ├── models/                    # Data models
                │   └── repositories/              # Repository implementation
                ├── domain/
                │   ├── entities/                  # Business entities
                │   ├── repositories/              # Repository interfaces
                │   └── usecases/                  # Business logic
                └── presentation/
                    ├── bloc/                      # State management (BLoC)
                    ├── pages/                     # UI screens
                    └── widgets/                   # Reusable widgets
```

### Architecture Layers

1. **Presentation Layer**
    - BLoC for state management
    - UI components and pages
    - User interaction handling

2. **Domain Layer**
    - Business entities
    - Use cases (business logic)
    - Repository interfaces

3. **Data Layer**
    - Repository implementations
    - Data sources (local & remote)
    - Data models with JSON serialization

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Flutter (latest stable) |
| **State Management** | flutter_bloc |
| **Navigation** | go_router |
| **Network** | Dio |
| **Local Storage** | Hive |
| **Dependency Injection** | get_it |
| **Functional Programming** | dartz |
| **Equality** | equatable |
| **Connectivity** | connectivity_plus |
| **Image Handling** | extended_image, flutter_image_compress |
| **Testing** | bloc_test, mocktail, integration_test |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.38.5)
- Dart SDK (3.10.4)
- Android Studio / Xcode (for mobile development)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/rifathossain82/sme-fin.git
   cd sme-fin
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```

## 📱 Running the Application

### Android

```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Build APK
flutter build apk --release
```

### iOS

```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Build IPA
flutter build ios --release
```

### Web (Optional)

```bash
flutter run -d chrome
```

## 🧪 Testing

### Unit Tests

Run all unit tests:
```bash
flutter test
```

Run specific test file:
```bash
flutter test test/features/onboarding/presentation/bloc/onboarding_bloc_test.dart
```

### Integration Tests

```bash
# Android
flutter test integration_test/onboarding_flow_test.dart

# iOS
flutter test integration_test/onboarding_flow_test.dart
```

### Test Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📁 Project Structure

```
.
├── sme-fin/
├── ├── android/                 # Android native code
├── ├── ios/                     # iOS native code
├── ├── lib/
├── │   ├── src/
├── │   │   ├── core/            # Core utilities and services (DI, network, theme, utils, etc.)
├── │   │   └── features/        # Feature modules (e.g., onboarding, auth, dashboard)
├── │   └── main.dart            # App entry point
├── ├── test/                    # Unit tests
├── ├── integration_test/        # Integration tests
├── ├── pubspec.yaml             # Dependencies
└── └── README.md                # Project documentation
```

## 🔍 Key Implementation Details

### State Management (BLoC)

The app uses BLoC pattern for predictable state management:
- **Events**: User actions (e.g., `SendVerificationCodeEvent`)
- **States**: UI states (e.g., `OnboardingLoading`, `OnboardingError`)
- **BLoC**: Business logic processor

### Error Handling

Functional error handling using `dartz`:
```dart
Either<Failure, Success>
```

- **Left**: Failure (NetworkFailure, ServerFailure, CacheFailure)
- **Right**: Success

### Data Persistence

- **Hive**: NoSQL database for local storage
- **Auto-save**: Data saved on every step
- **Draft restoration**: Automatic on app restart

### Network Layer

- **Mock API**: Simulated backend with Dio
- **Artificial delays**: 1-2.5 seconds
- **Random failures**: 20% failure rate for testing
- **Connectivity check**: Before network requests

## 💡 Assumptions & Trade-offs

### Assumptions

1. **No Real Backend**: Mock API simulates server responses
2. **Email Verification**: Any 4-digit code is accepted in mock mode
3. **File Upload**: Files are stored locally, not uploaded to server
4. **Single User**: No multi-user support or authentication persistence
5. **Network Simulation**: 80% success rate for realistic testing

### Trade-offs

1. **Feature-First vs Layer-First**
    - ✅ Chose feature-first for better scalability
    - ❌ Slightly more initial setup

2. **BLoC vs Riverpod**
    - ✅ BLoC for enterprise-grade state management
    - ❌ More boilerplate code

3. **Hive vs SQLite**
    - ✅ Hive for simpler key-value storage
    - ❌ Less suitable for complex queries

4. **Mock API vs Real Backend**
    - ✅ Faster development and testing
    - ❌ Requires backend integration later

5. **Image Compression**
    - ✅ Reduces storage and bandwidth
    - ❌ Processing time on device

## 🎨 UI/UX Highlights

- **Material 3**: Modern design system
- **Dark Mode**: System-aware theme switching
- **Progress Indicators**: Visual feedback for multi-step flow
- **Error Handling**: User-friendly error messages with retry
- **Loading States**: Smooth transitions and feedback
- **Form Validation**: Real-time input validation

## 🔐 Security Considerations

- Input validation on all form fields
- File type restrictions for uploads
- No sensitive data in logs
- Local storage encryption (can be added with Hive encryption)

## 📄 License

This project is created for demonstration purposes.

**Built with ❤️ using Flutter**