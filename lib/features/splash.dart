import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_routes.dart';

import '../core/constants/app_assets.dart'; // Make sure this import is correct

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.root);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // centers vertically
            children: [
              Spacer(),
              SvgPicture.asset(
                AppAssets.logo,
                //width: 150, // optional: set width/height
              ),
              Spacer(),
              Image.asset(AppAssets.splash),
            ],
          ),
        ),
      ),
    );
  }
}
