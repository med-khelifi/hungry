import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_routes.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class GuestView extends StatelessWidget {
  const GuestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(150.h),

                // Welcome icon
                Icon(
                  Icons.person_outline,
                  size: 120.r,
                  color: AppColors.primaryColor,
                ),

                Gap(20.h),

                // Welcome text
                CustomText(
                  text: "Welcome, Guest!",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),

                Gap(10.h),

                CustomText(
                  text: "You can browse the app without an account.",
                  fontSize: 16.sp,
                  color: AppColors.primaryColor,
                  textAlign: TextAlign.center,
                ),

                Gap(80.h),

                // Login button
                CustomButton(text: "Login",height: 50.h,width: 170.w, onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.login);
                },),


                Gap(10.h),

                // Register button
                CustomButton(text: "Sign Up",height: 50.h,width: 170.w, onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signup);
                },),

                Gap(50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
