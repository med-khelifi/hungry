import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onAdd;

  const ToppingCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85.w,
      height: 105.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 50.h,
            child: Container(
              height: 60.h,
              width: 85.w,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 13.h),
              decoration: BoxDecoration(
                color: AppColors.secondColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomText(
                      text: title,
                      color: AppColors.whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      height: 20.h,
                      width: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.redColor,
                      ),
                      child: Icon(
                        Icons.add,
                      //  fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              height: 70.h,
              width: 85.w,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Image.asset(
                imagePath,
                height: 50.h,
                width: 55.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
