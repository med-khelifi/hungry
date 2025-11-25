import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ItemSpacyHeader extends StatefulWidget {
  const ItemSpacyHeader({super.key});

  @override
  State<ItemSpacyHeader> createState() => _ItemSpacyHeaderState();
}

class _ItemSpacyHeaderState extends State<ItemSpacyHeader> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 21.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Image.asset(AppAssets.productDetails)),
          Gap(20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Customize",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.secondColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text:
                            " Your Burger\n to Your Tastes. Ultimate\n Experience",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.secondColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(25.h),
                    CustomText(
                      text: "Spacy",
                      color: AppColors.secondColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    Gap(10.h),
                    Slider(
                      value: _sliderValue,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                     // padding: EdgeInsets.zero,
                      activeColor: AppColors.primaryColor,
                      inactiveColor: AppColors.sliderInactive,
                    ),
                    Gap(7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: "🥶"),
                        CustomText(text: "🌶️"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
