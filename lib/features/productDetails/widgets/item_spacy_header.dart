import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ItemSpacyHeader extends StatefulWidget {
  const ItemSpacyHeader({super.key,required this.imagePath,required this.name,required this.des, required this.onSliderValueChanged});
  final String? imagePath;
  final String? name;
  final String? des;
  final Function(double value) onSliderValueChanged;
  @override
  State<ItemSpacyHeader> createState() => _ItemSpacyHeaderState();
}

class _ItemSpacyHeaderState extends State<ItemSpacyHeader> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// IMAGE
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12.r,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: widget.imagePath == null ? Image.asset(
                AppAssets.productDetails,
                width: double.infinity,
                fit: BoxFit.cover,
              ) : Image.network(
                widget.imagePath!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Gap(25.h),

          /// TITLE
          CustomText(
            text: widget.name ?? "Customize Your Burger",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.secondColor,
            textAlign: TextAlign.center,
          ),

          Gap(10.h),

          /// DESCRIPTION
          CustomText(
            text:
            widget.des ?? "Personalize your burger just the way you like.\nTaste the ultimate experience.",
            fontSize: 14.sp,
            color: AppColors.greyColor,
            textAlign: TextAlign.center,
          ),

          Gap(35.h),

          /// SPICY LEVEL TITLE
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: "Spicy Level",
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.secondColor,
            ),
          ),

          Gap(15.h),

          /// CHILI PROGRESS BAR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 1; i <= 5; i++)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: (_sliderValue * 5 >= i) ? 1 : 0.20,
                  child: Text(
                    "🌶️",
                    style: TextStyle(fontSize: 26.sp),
                  ),
                ),
            ],
          ),

          Gap(12.h),

          /// SLIDER
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.h,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r,elevation: 0),
            ),
            child: Slider(
              padding: EdgeInsets.zero,
              value: _sliderValue,
              onChanged: (value) => setState(() => _sliderValue = value),
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.sliderInactive,
            ),
          ),

          Gap(5.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Mild",
                fontSize: 12.sp,
                color: AppColors.greyColor,
              ),
              CustomText(
                text: "Very Hot",
                fontSize: 12.sp,
                color: AppColors.greyColor,
              ),
            ],
          ),

          Gap(20.h),
        ],
      ),
    );
  }
}
