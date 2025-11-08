import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../core/constants/app_assets.dart'; // Make sure this import is correct

class Splash extends StatelessWidget {
  const Splash({super.key});

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
              SvgPicture.asset(AppAssets.logo,
                //width: 150, // optional: set width/height
              ),
              Spacer(),
              Image.asset(AppAssets.splash)
            ],
          ),
        ),
      ),
    );
  }
}
