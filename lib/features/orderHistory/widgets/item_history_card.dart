import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class ItemHistoryCard extends StatelessWidget {
  const ItemHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppAssets.splash, width: 110.w, height: 100.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Hamburger Hamburger",
                      color: AppColors.secondColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: "QTY : X3",
                      color: AppColors.secondColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: "Price : 20\$",
                      color: AppColors.secondColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
            Gap(20.h),
            CustomButton(
              text: "Order Again",
              height: 50.h,
              width: double.infinity,
              onPressed: () {},
              color: AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
