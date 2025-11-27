import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_routes.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry/features/auth/widgets/custom_snack_bar.dart';
import 'package:hungry/shared/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthRepo _authRepo;
  late TextEditingController _email;
  late TextEditingController _password;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepo();
    _email = TextEditingController(text: "khelifim440@gmail.com");
    _password = TextEditingController(text: "123456789");
  }

  Future<void> login() async {
    final email = _email.text.trim();
    final password = _password.text.trim();
    if (email.isEmpty) {
      CustomErrorSnackBar.show(context, "Please enter email");
      return;
    }
    if (password.isEmpty) {
      CustomErrorSnackBar.show(context, "Please enter password");
      return;
    }
    setState(() => isLoading = true);
    var res = await _authRepo.login(email: email, password: password);
    setState(() => isLoading = false);
    if (res.isFailure) {
      if (context.mounted) {
        CustomErrorSnackBar.show(context, res.error?.message ?? "Login failed");
      }
    } else {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.root,
          (route) => false,
        );
      }
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              children: [
                Gap(80.h),
                SvgPicture.asset(AppAssets.logo, height: 130.h),
                Gap(12.h),

                Text(
                  "Welcome Back 👋",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in to continue ordering food",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                ),
                Gap(50.h),

                CustomTextFormField(
                  hint: "Email",
                  controller: _email,
                  prefixIcon: Icons.email_rounded,
                ),
                Gap(15.h),

                CustomTextFormField(
                  hint: "Password",
                  controller: _password,
                  prefixIcon: Icons.lock_rounded,
                  isPassword: true,
                ),
                Gap(30.h),

                isLoading
                    ? CupertinoActivityIndicator(color: AppColors.whiteColor)
                    : CustomAuthButton(text: "Login", onPressed: login),

                Gap(25.h),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signup);
                  },
                  child: Text(
                    "Don't have an account? Create one",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.root,
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Continue as a guest",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
