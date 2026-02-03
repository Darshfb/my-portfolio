# Premium Portfolio

A modern, feature-rich portfolio application built with Flutter, showcasing professional experience, projects, blog posts, and resume. The application follows Clean Architecture principles and is designed for both mobile and web platforms with Firebase backend integration.

[![Flutter](https://img.shields.io/badge/Flutter-3.10.7+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-Private-red.svg)](LICENSE)

## 🌟 Features

### Core Features
- **🏠 Home Page**: Dynamic landing page with professional introduction, expertise showcase, and testimonials
- **💼 Projects Portfolio**: Showcase projects with detailed information, technologies, STAR narratives, and metrics
- **📝 Blog & Insights**: Full-featured blog with markdown support, categories, tags, comments, and multi-language support
- **📄 Resume/CV**: Downloadable PDF resume with online preview
- **🔐 Admin Dashboard**: Secure admin panel for content management
- **🌐 Multi-language**: English and Arabic localization support via `easy_localization`
- **🎨 Premium UI/UX**: Modern, responsive design with animations and dark/light theme support

### Technical Capabilities
- **Clean Architecture**: Separation of concerns with domain, data, and presentation layers
- **State Management**: BLoC pattern with `flutter_bloc` for predictable state management
- **Dependency Injection**: Using `get_it` and `injectable` for modular architecture
- **Firebase Integration**: 
  - Authentication (Admin access)
  - Cloud Firestore (Data persistence)
  - Storage (Image uploads)
  - Analytics (User tracking)
- **Routing**: Declarative routing with `go_router`
- **SEO Optimization**: Web-optimized with SEO support for better discoverability
- **Responsive Design**: Adaptive layouts for mobile, tablet, and desktop

## 📁 Project Structure

```
lib/
├── core/
│   ├── di/                    # Dependency injection setup
│   │   ├── injection.dart
│   │   └── register_module.dart
│   ├── error/                 # Error handling & failures
│   ├── layout/                # Main layout & responsive wrappers
│   ├── localization/          # Localization helpers
│   ├── router/                # App routing configuration
│   ├── services/              # Core services (config, image upload)
│   ├── theme/                 # App theming & colors
│   └── widgets/               # Reusable widgets & splash screen
│
├── features/
│   ├── admin/                 # Admin dashboard
│   │   └── presentation/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   ├── auth/                  # Authentication
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── blog/                  # Blog & content management
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   ├── home/                  # Landing page
│   │   └── presentation/
│   │
│   ├── projects/              # Projects showcase
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── resume/                # Resume/CV management
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── social_links/          # Social media links
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── firebase_options.dart      # Firebase configuration
└── main.dart                  # App entry point

assets/
└── translations/              # Localization files
    ├── en.json                # English translations
    └── ar.json                # Arabic translations
```

## 🏗️ Architecture

This application follows **Clean Architecture** principles with three main layers:

### 1. Domain Layer
- **Entities**: Core business objects (Project, BlogPost, User, etc.)
- **Repositories**: Abstract interfaces for data operations
- **Use Cases**: Business logic and application rules

### 2. Data Layer
- **Data Sources**: Remote (Firebase) and local data access
- **Models**: Data transfer objects with JSON serialization
- **Repository Implementations**: Concrete implementations of domain repositories

### 3. Presentation Layer
- **Pages**: UI screens
- **Widgets**: Reusable UI components
- **BLoC/Cubit**: State management for UI logic

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.10.7)
- Dart SDK
- Firebase account and project setup
- Android Studio / VS Code (optional but recommended)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd myprofile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Authentication, Firestore, and Storage
   - Download and configure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Run FlutterFire CLI to generate configuration:
     ```bash
     flutterfire configure
     ```

4. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   # For web
   flutter run -d chrome
   
   # For mobile
   flutter run
   ```

## 🔧 Configuration

### Firebase Configuration

Update `lib/firebase_options.dart` with your Firebase project credentials.

### Localization

Add or modify translations in:
- `assets/translations/en.json` (English)
- `assets/translations/ar.json` (Arabic)

### Theme

Customize colors and theme in:
- `lib/core/theme/app_colors.dart`
- `lib/core/theme/app_theme.dart`

## 📦 Key Dependencies

### Core
- **flutter_bloc**: ^9.1.0 - State management
- **get_it**: ^9.2.0 - Dependency injection
- **injectable**: ^2.5.0 - Code generation for DI
- **go_router**: ^17.0.1 - Declarative routing
- **equatable**: ^2.0.7 - Value equality

### Firebase
- **firebase_core** - Firebase initialization
- **cloud_firestore** - NoSQL database
- **firebase_auth** - Authentication
- **firebase_storage** - File storage
- **firebase_analytics** - Analytics tracking

### UI/UX
- **flutter_animate**: ^4.5.2 - Animations
- **google_fonts**: ^8.0.0 - Custom fonts
- **cached_network_image**: ^3.4.1 - Image caching
- **font_awesome_flutter**: ^10.7.0 - Icons

### Content & Documents
- **flutter_markdown**: ^0.7.3+1 - Markdown rendering
- **pdf**: ^3.10.8 - PDF generation
- **printing**: ^5.11.1 - PDF printing/download

### Localization
- **easy_localization**: ^3.0.7 - Multi-language support
- **intl**: ^0.20.2 - Internationalization

### Development
- **build_runner**: ^2.4.15 - Code generation
- **injectable_generator**: ^2.6.4 - DI code generation
- **freezed**: ^3.2.4 - Immutable classes
- **json_serializable**: ^6.9.1 - JSON serialization

## 🎯 Features Detail

### Projects Management
- Support for multiple project types (Flutter, QA, Other)
- Rich project details with:
  - Cover and gallery images
  - Technologies used
  - STAR narrative (Situation, Task, Action, Result)
  - Client testimonials
  - QA metrics (for testing projects)
  - Project timeline (start/end dates)
  - External links (demo, source code, case study)

### Blog System
- Markdown-based content
- Categories and tags
- Multi-language posts (English/Arabic)
- Like and comment functionality
- Search and filter capabilities
- Related posts recommendations
- Admin content management

### Admin Dashboard
- Secure authentication
- Create, edit, and delete blog posts
- Manage projects
- Manage social links
- Upload CV/Resume
- Dashboard statistics

### Resume/CV
- Upload and store PDF resume in Firebase Storage
- Download PDF functionality
- Online preview
- Last updated tracking

## 🌐 Supported Platforms

- ✅ **Web** (Primary platform with SEO optimization)
- ✅ **Android**
- ✅ **iOS**
- ✅ **Windows**
- ✅ **macOS**
- ✅ **Linux**

## 🎨 UI/UX Highlights

- **Premium Color Palette**: Deep Navy (#0A192F) with Teal Gold accents (#64FFDA, #FFD700)
- **Smooth Animations**: Page transitions and micro-interactions
- **Responsive Design**: Breakpoints for mobile, tablet, and desktop
- **Dark/Light Themes**: System-aware theme switching
- **Glassmorphism Effects**: Modern UI design trends
- **Accessibility**: Proper semantic structure and navigation

## 🔐 Security

- Firebase Authentication for admin access
- Protected admin routes
- Firestore security rules
- Storage security rules

## 📊 Analytics

Firebase Analytics is integrated to track:
- Page views
- User navigation
- Content engagement
- Admin activities

## 🛠️ Development

### Code Generation

Generate necessary code files:
```bash
# Generate dependency injection code
dart run build_runner build --delete-conflicting-outputs

# Watch for changes
dart run build_runner watch
```

### Linting

```bash
flutter analyze
```

### Testing

```bash
flutter test
```

## 🚀 Deployment

### Web Deployment (Firebase Hosting)

1. Build the web version:
   ```bash
   flutter build web
   ```

2. Deploy to Firebase:
   ```bash
   firebase deploy
   ```

### Mobile Deployment

#### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## 📝 Environment Variables

Set up your Firebase configuration in:
- `lib/firebase_options.dart` (auto-generated by FlutterFire CLI)

## 🤝 Contributing

This is a personal portfolio project. However, if you find bugs or have suggestions, feel free to open an issue.

## 📄 License

This project is private and proprietary. All rights reserved.

## 👨‍💻 Author

**Mostafa**
- Senior QA Engineer & Flutter Developer
- Specializing in Clean Architecture, Flutter Development, and QA Automation

## 🔗 Links

- Portfolio: [Your Portfolio URL]
- GitHub: [Your GitHub Profile]
- LinkedIn: [Your LinkedIn Profile]

## 📞 Contact

For inquiries or collaboration opportunities, please use the contact form on the portfolio website.

---

**Built with ❤️ using Flutter & Firebase**
