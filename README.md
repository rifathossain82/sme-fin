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
- [Docker Support](#docker-support)
- [Project Structure](#project-structure)
- [Assumptions & Trade-offs](#assumptions--trade-offs)

## 🎯 Overview

SMEfin is a cross-platform mobile application that enables Small and Medium Enterprises (SMEs) to register their business details and request financing. The app features a multi-step onboarding flow with offline support, automatic draft saving, and image compression.

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
lib/
├── core/
│   ├── di/              # Dependency injection (get_it)
│   ├── error/           # Error handling (failures & exceptions)
│   ├── network/         # Network layer (Dio, connectivity)
│   ├── router/          # Navigation (go_router)
│   ├── storage/         # Local storage (Hive)
│   ├── theme/           # App theming (Material 3)
│   └── utils/           # Utilities (validators, image compression)
│
└── features/
    └── onboarding/
        ├── data/
        │   ├── datasources/
        │   │   ├── local_datasource.dart    # Hive implementation
        │   │   └── remote_datasource.dart   # Mock Dio API
        │   ├── models/                      # Data models
        │   └── repositories/                # Repository implementation
        │
        ├── domain/
        │   ├── entities/                    # Business entities
        │   ├── repositories/                # Repository interfaces
        │   └── usecases/                    # Business logic
        │
        └── presentation/
            ├── bloc/                        # State management (BLoC)
            ├── pages/                       # UI screens
            └── widgets/                     # Reusable widgets
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

- Flutter SDK (3.10.4 or later)
- Dart SDK (3.10.4 or later)
- Android Studio / Xcode (for mobile development)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd smefin
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

## 🐳 Docker Support

### Build with Docker

```bash
# Build the Docker image
docker-compose build

# Run tests
docker-compose run flutter-test

# Build APK
docker-compose run flutter-build
```

### Docker Commands

```bash
# Build image
docker build -t smefin-app .

# Run tests in container
docker run --rm smefin-app flutter test

# Build APK in container
docker run --rm -v $(pwd):/app smefin-app flutter build apk
```

## 📁 Project Structure

```
smefin/
├── android/                 # Android native code
├── ios/                     # iOS native code
├── lib/
│   ├── core/               # Core utilities and services
│   ├── features/           # Feature modules
│   └── main.dart           # App entry point
├── test/                   # Unit tests
├── integration_test/       # Integration tests
├── Dockerfile              # Docker configuration
├── docker-compose.yml      # Docker Compose configuration
├── pubspec.yaml            # Dependencies
└── README.md              # This file
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

## 🚧 Future Enhancements

- [ ] Backend API integration
- [ ] Biometric authentication
- [ ] Multi-language support
- [ ] Analytics integration
- [ ] Push notifications
- [ ] Advanced file preview
- [ ] OCR for license scanning

## 📄 License

This project is created for demonstration purposes.

## 👨‍💻 Development

### Code Style

- Follow Flutter/Dart style guide
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused

### Git Workflow

```bash
# Create feature branch
git checkout -b feature/your-feature

# Commit changes
git commit -m "feat: add your feature"

# Push to remote
git push origin feature/your-feature
```

## 📞 Support

For issues or questions, please create an issue in the repository.

---

**Built with ❤️ using Flutter**
