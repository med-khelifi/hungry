import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.value,
    required this.onPressedDecrease,
    required this.onPressedIncrease,
    required this.onPressedRemove,
  });

  final String value;
  final VoidCallback onPressedIncrease;
  final VoidCallback onPressedRemove;
  final VoidCallback onPressedDecrease;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(AppAssets.splash, width: 110.w, height: 100.h),
                CustomText(
                  text: "Hamburger",
                  color: AppColors.secondColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: "Veggie Burger",
                  color: AppColors.secondColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    CustomButton(
                      text: "-",
                      fontWeight: FontWeight.bold,
                      onPressed: onPressedDecrease,
                      width: 40.w,
                      height: 45.h,
                      borderRadius: 10.r,
                    ),
                    Gap(30.w),
                    CustomText(
                      text: value,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondColor,
                    ),
                    Gap(30.w),
                    CustomButton(
                      text: "+",
                      fontWeight: FontWeight.bold,
                      onPressed: onPressedIncrease,
                      width: 40.w,
                      height: 45.h,
                      borderRadius: 10.r,
                    ),
                  ],
                ),
                Gap(40.h),
                CustomButton(
                  text: "Remove",
                  onPressed: onPressedRemove,
                  height: 45.w,
                  width: 155.h,
                  borderRadius: 20.r,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
