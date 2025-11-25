import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/widgets/custom_user_text_field.dart';
import 'package:hungry/shared/custom_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(10.h),

                /// --- Profile Picture ---
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 55.r,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        backgroundImage: const AssetImage(AppAssets.profile),
                      ),
                      Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 18.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(30.h),

                CustomUserTextField(
                  controller: nameController,
                  labelText: "name",
                ),

                Gap(15.h),

                CustomUserTextField(
                  controller: emailController,
                  labelText: "Email Address",
                ),
                Gap(15.h),
                CustomUserTextField(
                  controller: addressController,
                  labelText: "Address",
                ),

                Gap(30.h),

                /// Divider
                Divider(color: Colors.white.withOpacity(0.4), thickness: 1),
                SizedBox(height: 30.h),
                _paymentTile(
                  value: "Card",
                  title: "Debit Card",
                  subtitle: "3566 **** **** 0505",
                  icon: Image.asset(AppAssets.viza, width: 55.w),
                ),
                SizedBox(height: 30.h),

                /// Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                /// Logout Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _paymentTile({
    required String value,
    required String title,
    String? subtitle,
    required Widget icon,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(15.r),
      elevation: 3,
      child: RadioListTile<String>(
        value: value,
        groupValue: "viza",
        activeColor: AppColors.secondColor,
        onChanged: (value) {
          // setState(() => selectedPayment = value!);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
        title: Row(
          children: [
            icon,
            Gap(15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: AppColors.secondColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                if (subtitle != null)
                  CustomText(
                    text: subtitle,
                    color: AppColors.greyColor,
                    fontSize: 14.sp,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
