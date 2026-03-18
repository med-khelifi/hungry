# 🍔 Hungry - Food Delivery App

A modern, feature-rich food delivery mobile application built with Flutter. Hungry brings the convenience of ordering quality food to your fingertips with an intuitive interface and seamless user experience.

## 📸 Overview

**Hungry** is a complete food delivery solution that connects users with restaurants, allowing them to browse products, customize orders, manage their cart, and securely checkout. The app features a robust authentication system, real-time order tracking, and user profile management.

---

## ✨ Key Features

### 🔐 Authentication & User Management

- **User Registration & Login** - Secure authentication system with validation
- **Guest Browsing** - Browse products without creating an account
- **User Profile** - Manage account details and preferences
- **Local Storage** - Persist user preferences and session data with SharedPreferences

### 🏪 Shopping Experience

- **Product Catalog** - Browse food items organized by categories
- **Advanced Search** - Quick search functionality to find dishes
- **Product Details** - Comprehensive product information with images
- **Customization** - Topping options and spicy level selection
- **Smart Cart Management** - Add, remove, and modify items easily

### 🛒 Checkout & Payments

- **Shopping Cart** - View and manage cart items with real-time updates
- **Order Review** - Detailed checkout view before payment
- **Payment Integration** - Secure payment processing (Visa compatible)
- **Order Confirmation** - Success dialogs and order placement confirmation

### 📋 Order Management

- **Order History** - Track all past orders with detailed information
- **Order Status** - View order details and delivery information
- **Reorder** - Quick reorder functionality from order history

### 🎨 User Interface

- **Responsive Design** - Optimized for various screen sizes using ScreenUtilization
- **Skeleton Loaders** - Professional loading animations
- **Toast Notifications** - User feedback for actions
- **Clean Architecture** - Organized code structure with separation of concerns

---

## 🛠️ Technology Stack

### Framework & Language

- **Flutter** ^3.9.2 - Cross-platform mobile framework
- **Dart** - Programming language

### Dependencies

| Package              | Version | Purpose                   |
| -------------------- | ------- | ------------------------- |
| `flutter_svg`        | ^2.2.2  | SVG image rendering       |
| `flutter_screenutil` | ^5.9.3  | Responsive design scaling |
| `gap`                | ^3.0.1  | Spacing utilities         |
| `shared_preferences` | ^2.5.3  | Local data persistence    |
| `dio`                | ^5.9.0  | HTTP client for API calls |
| `skeletonizer`       | ^2.1.1  | Loading placeholders      |
| `image_picker`       | ^1.2.1  | Image selection & uploads |
| `cupertino_icons`    | ^1.0.8  | iOS-style icons           |

### Architecture Pattern

- **Multi-Layer Architecture** - Separation of data, business logic, and presentation layers
- **Repository Pattern** - Centralized data access with `*_repo.dart` files
- **Model-View Structure** - Clean separation of data models and UI views

---

## 📁 Project Structure

```
hungry/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── root.dart                    # Root widget
│   ├── app/
│   │   └── hungry.dart              # Main app configuration
│   ├── core/
│   │   ├── constants/
│   │   │   ├── api_endpoints.dart   # API configuration
│   │   │   ├── app_assets.dart      # Asset references
│   │   │   ├── app_colors.dart      # Color palette
│   │   │   ├── app_routes.dart      # Navigation routes
│   │   │   └── app_strings.dart     # String constants
│   │   ├── network/
│   │   │   ├── api_service.dart     # API service layer
│   │   │   ├── dio_client.dart      # Dio HTTP configuration
│   │   │   ├── api_error.dart       # Error models
│   │   │   └── api_exceptions.dart  # Custom exceptions
│   │   └── utils/
│   │       ├── helpers.dart         # Helper functions
│   │       ├── pref_helper.dart     # SharedPreferences wrapper
│   │       ├── response.dart        # Response wrapper
│   │       └── validators.dart      # Input validation
│   ├── features/
│   │   ├── splash.dart              # Splash screen
│   │   ├── auth/                    # Authentication feature
│   │   ├── home/                    # Home & product browsing
│   │   ├── cart/                    # Shopping cart
│   │   ├── checkout/                # Order checkout
│   │   ├── orderHistory/            # Previous orders
│   │   └── productDetails/          # Product detail view
│   └── shared/                      # Shared widgets and components
├── assets/                          # Images and SVG assets
├── android/                         # Android configuration
├── web/                             # Web configuration
└── pubspec.yaml                     # Project dependencies
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- Android SDK (for Android development)
- Xcode (for iOS development)
- A code editor (VS Code, Android Studio, or IntelliJ)

### Installation & Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/hungry.git
   cd hungry
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure API Endpoints**
   - Open `lib/core/constants/api_endpoints.dart`
   - Update API base URL and endpoints as needed

4. **Run the app**

   ```bash
   # Development
   flutter run

   # Release
   flutter run --release

   # Specific device
   flutter run -d <device_id>
   ```

5. **Build APK/App Bundle**

   ```bash
   # Debug APK
   flutter build apk --debug

   # Release APK
   flutter build apk --release

   # App Bundle (for Play Store)
   flutter build appbundle
   ```

---

## 📋 Features in Detail

### Authentication Flow

- Guest users can browse without login
- Secure login with validation
- User registration with form validation
- Profile view and management
- Session persistence with local storage

### Product Management

- Category-based product filtering
- Search functionality
- Product details with images and descriptions
- Customizable toppings and spice levels
- Real-time cart updates

### Order Management

- Add/remove items from cart
- Modify item quantities
- View order summary before checkout
- Secure payment integration
- Order confirmation with success dialog
- Order history with order details

---

## 🎨 Design System

### Color Palette

- **Primary Color**: `#4f0303` (Deep Red)
- **Secondary Color**: `#3C2F2F` (Dark Brown)
- **Accent Colors**: Red, Green, Pink
- **Neutral Colors**: White, Grey variants

### Responsive Design

- Adaptive layouts using `flutter_screenutil`
- Design size: 411.4 x 923.4 (Pixel 4a reference)
- Automatic scaling for all screen sizes

---

## 🔌 API Integration

The app uses **Dio** for HTTP requests with:

- Centralized API service (`api_service.dart`)
- Custom Dio configuration (`dio_client.dart`)
- Error handling and exception management
- API endpoint constants (`api_endpoints.dart`)

**Supported endpoints typically include:**

- Authentication (login, signup)
- Product catalog (categories, products)
- User profile management
- Order placement and history
- Payment processing

---

## 🧪 Testing

```bash
# Run tests
flutter test

# Generate coverage
flutter test --coverage
```

---

## 📦 Build & Deployment

### Android

```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👨‍💻 Author

**Your Name**

- GitHub: [@med-khelif](https://github.com/med-khelif)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All package authors whose libraries are used in this project
- Contributors and testers

---

## 📞 Support

For support, email your.email@example.com or open an issue on the GitHub repository.

---

## 🗺️ Roadmap

- [ ] Dark mode support
- [ ] Push notifications for order updates
- [ ] Multiple payment methods
- [ ] Order tracking with live map
- [ ] User ratings and reviews
- [ ] Referral program
- [ ] Loyalty points system

---

**Made with ❤️ using Flutter**
