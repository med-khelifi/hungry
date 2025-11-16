import 'package:flutter/material.dart';
import 'package:hungry/features/productDetails/views/product_details_view.dart';
import 'package:hungry/features/splash.dart';
import 'package:hungry/root.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    Routes.splash: (context) => const Splash(),
    Routes.root: (context) => const Root(),
    Routes.productDetails: (context) => const ProductDetailsView(),
  };
}

class Routes {
  static const String splash = "/splash";
  static const String root = "/root";
  static const String productDetails = "/productDetails";
}
