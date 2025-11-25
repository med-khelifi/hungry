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

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confirm;

  late bool isLoading;
  late AuthRepo _authRepo;
  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confirm = TextEditingController();
    _authRepo = AuthRepo();
    isLoading = false;
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    pass.dispose();
    confirm.dispose();
    super.dispose();
  }

  void register() async {
    final userEmail = email.text.trim();
    final nameText = name.text.trim();
    final passwordText = pass.text.trim();
    final confirmText = confirm.text.trim();

    if (nameText.isEmpty) {
      CustomErrorSnackBar.show(context, "Please enter your full name");
      return;
    }
    if (userEmail.isEmpty) {
      CustomErrorSnackBar.show(context, "Please enter email");
      return;
    }
    if (passwordText.isEmpty) {
      CustomErrorSnackBar.show(context, "Please enter password");
      return;
    }
    if (passwordText.isEmpty) {
      CustomErrorSnackBar.show(context, "Please enter password");
      return;
    }

    if (passwordText != confirmText) {
      CustomErrorSnackBar.show(context, "Passwords do not match");
      return;
    }

    setState(() => isLoading = true);
    var res = await _authRepo.register(
      name: nameText,
      email: userEmail,
      password: passwordText,
    );
    setState(() => isLoading = false);
    if (res.isFailure) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        CustomErrorSnackBar.show(context, res.error?.message ?? "Login failed");
      }
    } else {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          Routes.root,
          (route) => false,
        );
      }
    }
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
                SizedBox(height: 80.h),
                SvgPicture.asset(AppAssets.logo, height: 130.h),
                Gap(15.h),

                Text(
                  "Create Your Account ✨",
                  style: TextStyle(
                    fontSize: 26.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(40.h),

                CustomTextFormField(
                  hint: "Full Name",
                  controller: name,
                  prefixIcon: Icons.person_rounded,
                ),
                Gap(15.h),

                CustomTextFormField(
                  hint: "Email",
                  controller: email,
                  prefixIcon: Icons.email_rounded,
                ),
                Gap(15.h),

                CustomTextFormField(
                  hint: "Password",
                  controller: pass,
                  isPassword: true,
                  prefixIcon: Icons.lock_rounded,
                ),
                Gap(15.h),

                CustomTextFormField(
                  hint: "Confirm Password",
                  controller: confirm,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline_rounded,
                ),
                Gap(35.h),

                isLoading
                    ? CupertinoActivityIndicator(color: AppColors.whiteColor)
                    : CustomAuthButton(text: "Sign Up", onPressed: register),

                Gap(25.h),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.login,
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Already have an account? Login",
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
