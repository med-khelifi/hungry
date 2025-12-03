import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const ToppingCard({
    super.key,
    required this.title,
    this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 85.w,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isSelected ?
          AppColors.primaryColor.withOpacity(0.1) :
          AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
          border: isSelected ? Border.all(color: AppColors.primaryColor, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// IMAGE
            imagePath == null ?
            Image.asset(
              AppAssets.tomato,
              height: 50.h,
              width: 50.w,
              fit: BoxFit.contain,
            ) : Image.network(
              imagePath!,
              height: 50.h,
              width: 50.w,
              fit: BoxFit.contain,
            ),

            /// TITLE
            CustomText(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.secondColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
