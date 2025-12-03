import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String rating;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image == null
                ? Image.asset(AppAssets.test, height: 150.h)
                : Image.network(image!, height: 150.h,errorBuilder: (context, error, stackTrace) {
                  return Image.asset(AppAssets.test, height: 150.h);
                },),
            CustomText(
              text: title,
              fontSize: 16.sp,
              color: AppColors.secondColor,
              fontWeight: FontWeight.w600,
            ),
            CustomText(
              text: subtitle,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AppColors.secondColor,
            ),
            CustomText(text: "⭐ $rating", color: AppColors.secondColor),
          ],
        ),
      ),
    );
  }
}
