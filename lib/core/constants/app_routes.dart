import 'package:flutter/material.dart';
import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/features/auth/views/signup_view.dart';
import 'package:hungry/features/checkout/view/checkout_view.dart';
import 'package:hungry/features/productDetails/views/product_details_view.dart';
import 'package:hungry/features/splash.dart';
import 'package:hungry/root.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    Routes.splash: (context) => const Splash(),
    Routes.root: (context) => const Root(),
    Routes.productDetails: (context) => const ProductDetailsView(),
    Routes.checkout: (context) => const CheckoutView(),
    Routes.login: (context) => const LoginView(),
    Routes.signup: (context) => const SignupView(),
  };
}

class Routes {
  static const String splash = "/splash";
  static const String root = "/root";
  static const String productDetails = "/productDetails";
  static const String checkout = "/checkout";
  static const String login = "/login";
  static const String signup = "/signup";
}
