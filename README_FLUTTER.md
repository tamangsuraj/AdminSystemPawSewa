# PawSewa Admin Panel - Flutter

A comprehensive Flutter admin panel for PawSewa pet services management system. This application provides a complete solution for managing appointments, orders, veterinarians, riders, premium memberships, and more.

## 🚀 Features

### Core Management
- **Dashboard** - Real-time statistics, charts, and activity feed
- **Appointments** - Complete CRUD operations with status management and vet assignment
- **Pet Supplies** - Order management with rider assignment and tracking
- **Veterinarians** - Full vet management with zone assignment and performance tracking
- **Riders** - Delivery rider management with vehicle tracking and history
- **Premium Members** - Subscription management with usage tracking and benefits

### Advanced Features
- **Real-time Maps** - Google Maps integration for location tracking
- **Pet Profiles** - Comprehensive pet information with medical history
- **Order Creation** - Streamlined appointment and order creation forms
- **Audit Logs** - Complete system activity tracking and monitoring
- **User Management** - Admin user creation and role management
- **Settings** - Application configuration and preferences

### Technical Features
- **Authentication** - Secure login with Supabase Auth
- **Responsive Design** - Works on desktop, tablet, and mobile
- **Real-time Updates** - Live data synchronization
- **Offline Support** - Basic offline functionality
- **Material 3 Design** - Modern, accessible UI components
- **Dark/Light Theme** - Automatic theme switching

## 🛠 Tech Stack

- **Flutter 3.10+** - Cross-platform UI framework
- **Dart** - Programming language
- **Riverpod** - State management and dependency injection
- **Supabase** - Backend as a Service (PostgreSQL + Auth + Real-time)
- **Go Router** - Type-safe navigation
- **FL Chart** - Beautiful charts and graphs
- **Google Maps Flutter** - Maps integration
- **Material 3** - Design system and components

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

1. **Flutter SDK** (3.10 or higher)
   ```bash
   flutter --version
   ```

2. **Development Environment**
   - **Android Studio** (for Android development)
   - **Xcode** (for iOS development - macOS only)
   - **VS Code** (recommended editor)

3. **Backend Services**
   - **Supabase Project** - [Create here](https://supabase.com)
   - **Google Maps API Key** - [Get here](https://developers.google.com/maps)

## 🚀 Quick Start

### 1. Clone and Setup
```bash
git clone <repository-url>
cd pawsewa_admin
flutter pub get
```

### 2. Environment Configuration
Create a `.env` file in the root directory:
```bash
cp .env.example .env
```

Update `.env` with your credentials:
```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
GOOGLE_MAPS_API_KEY=your_google_maps_api_key
```

### 3. Platform Setup

#### Android Setup
1. Open `android/app/build.gradle`
2. Update `applicationId` if needed
3. Ensure `minSdkVersion` is 21 or higher

#### iOS Setup (macOS only)
1. Open `ios/Runner.xcworkspace` in Xcode
2. Update Bundle Identifier
3. Configure signing certificates

### 4. Run the Application
```bash
# Development mode
flutter run

# Web
flutter run -d chrome

# Specific device
flutter devices
flutter run -d <device-id>
```

## 🏗 Project Structure

```
lib/
├── core/                    # Core application setup
│   ├── config/             # App configuration
│   ├── router/             # Navigation setup
│   └── theme/              # Theme configuration
├── features/               # Feature modules
│   ├── appointments/       # Appointment management
│   ├── auth/              # Authentication
│   ├── dashboard/         # Main dashboard
│   ├── orders/            # Order management
│   ├── vets/              # Veterinarian management
│   ├── riders/            # Rider management
│   ├── premium/           # Premium membership
│   ├── pets/              # Pet profiles
│   ├── products/          # Product catalog
│   ├── maps/              # Maps integration
│   ├── tracking/          # Real-time tracking
│   ├── users/             # User management
│   ├── audit/             # Audit logs
│   └── settings/          # Application settings
├── shared/                # Shared components
│   ├── models/            # Data models
│   ├── providers/         # Global providers
│   ├── widgets/           # Reusable widgets
│   └── utils/             # Utility functions
└── main.dart              # Application entry point
```

## 🔧 Development

### Code Generation
```bash
# Generate code for Riverpod and JSON serialization
flutter packages pub run build_runner build

# Watch for changes
flutter packages pub run build_runner watch
```

### Testing
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter test integration_test/
```

### Code Quality
```bash
# Analyze code
flutter analyze

# Format code
flutter format .

# Check for unused dependencies
flutter pub deps
```

## 📱 Building for Production

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release

# Install release APK
flutter install --release
```

### iOS
```bash
# Build for iOS
flutter build ios --release

# Build IPA
flutter build ipa --release
```

### Web
```bash
# Build for web
flutter build web --release

# Serve locally
flutter build web && python -m http.server 8000 -d build/web
```

## 🔐 Authentication Setup

### Supabase Configuration
1. Create a new Supabase project
2. Go to Authentication > Settings
3. Configure email templates
4. Set up Row Level Security (RLS) policies
5. Create the following tables:
   - `appointments`
   - `orders`
   - `vets`
   - `riders`
   - `premium_members`
   - `pets`
   - `products`
   - `audit_logs`

### Database Schema
```sql
-- Example table creation
CREATE TABLE appointments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  customer TEXT NOT NULL,
  pet TEXT NOT NULL,
  service TEXT NOT NULL,
  status TEXT DEFAULT 'Pending',
  vet TEXT,
  scheduled_date DATE,
  scheduled_time TIME,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;

-- Create policy
CREATE POLICY "Enable all operations for authenticated users" ON appointments
FOR ALL USING (auth.role() = 'authenticated');
```

## 🗺 Maps Integration

### Google Maps Setup
1. Get API key from Google Cloud Console
2. Enable Maps SDK for Android/iOS
3. Add API key to platform-specific files:

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY_HERE" />
```

#### iOS (`ios/Runner/AppDelegate.swift`)
```swift
GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
```

## 🎨 Theming & Customization

### Theme Configuration
The app uses Material 3 theming. Customize in `lib/core/theme/app_theme.dart`:

```dart
static const _primaryColor = Color(0xFF6366F1);
static const _secondaryColor = Color(0xFF8B5CF6);
```

### Custom Components
Create reusable widgets in `lib/shared/widgets/`:
- Custom buttons
- Form fields
- Cards
- Loading indicators

## 📊 State Management

### Riverpod Patterns
```dart
// Provider for async data
final dataProvider = FutureProvider<List<Item>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return repository.fetchItems();
});

// StateNotifier for mutable state
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

// Consumer widget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataProvider);
    return data.when(
      data: (items) => ListView(...),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

## 🚀 Deployment

### Web Deployment
```bash
# Build
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy

# Deploy to Vercel
vercel --prod

# Deploy to GitHub Pages
# (requires additional setup)
```

### Mobile App Stores

#### Google Play Store
1. Build app bundle: `flutter build appbundle --release`
2. Upload to Play Console
3. Configure store listing
4. Submit for review

#### Apple App Store
1. Build IPA: `flutter build ipa --release`
2. Upload via Xcode or Transporter
3. Configure App Store Connect
4. Submit for review

## 🔍 Troubleshooting

### Common Issues

#### Flutter Doctor Issues
```bash
flutter doctor -v
# Fix any issues reported
```

#### Dependency Conflicts
```bash
flutter clean
flutter pub get
```

#### Build Issues
```bash
# Clear build cache
flutter clean
rm -rf build/
flutter pub get
flutter build <platform>
```

#### Supabase Connection
- Check environment variables
- Verify API keys
- Test network connectivity
- Check Supabase project status

### Performance Optimization
- Use `const` constructors
- Implement proper list virtualization
- Cache API responses
- Use `RepaintBoundary` for expensive widgets
- Profile with Flutter Inspector

## 📚 Documentation

### API Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Supabase Flutter Documentation](https://supabase.com/docs/reference/dart)
- [Go Router Documentation](https://pub.dev/packages/go_router)

### Learning Resources
- [Flutter Codelabs](https://flutter.dev/docs/codelabs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material 3 Design](https://m3.material.io)

## 🤝 Contributing

### Development Workflow
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Run code analysis
6. Submit a pull request

### Code Standards
- Follow Dart style guide
- Use meaningful variable names
- Add documentation comments
- Write unit tests
- Keep functions small and focused

### Commit Messages
```
feat: add appointment creation form
fix: resolve navigation issue in sidebar
docs: update README with setup instructions
test: add unit tests for vet management
```

## 📄 License

This project is proprietary software owned by PawSewa. All rights reserved.

**For Internal Use Only** - This application is intended for use by PawSewa operations team members only.

## 📞 Support

For technical support or questions:
- **Email**: tech@pawsewa.com
- **Internal Chat**: #dev-support
- **Documentation**: [Internal Wiki](https://wiki.pawsewa.com)

---

## 🎯 Next Steps

After setup, you can:
1. **Customize the theme** to match your brand
2. **Add real API integrations** with your Supabase database
3. **Implement push notifications** for real-time updates
4. **Add offline support** for critical features
5. **Set up CI/CD pipeline** for automated testing and deployment
6. **Add analytics** to track usage and performance
7. **Implement role-based access control** for different user types

## 🔄 Migration from React

This Flutter app replaces the previous React implementation with:
- **Better Performance** - Native compilation and optimized rendering
- **Cross-Platform** - Single codebase for web, iOS, and Android
- **Modern Architecture** - Clean architecture with proper state management
- **Enhanced UX** - Material 3 design with smooth animations
- **Better Maintainability** - Type-safe Dart code with excellent tooling

All features from the React version have been implemented with improved functionality and user experience.