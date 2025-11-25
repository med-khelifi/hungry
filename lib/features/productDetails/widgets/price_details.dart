import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_colors.dart';

class PriceDetails extends StatelessWidget {
  const PriceDetails({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "\$",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
              color: AppColors.primaryColor,
            ),
          ),
          TextSpan(
            text: text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
              color: AppColors.secondColor,
            ),
          ),
        ],
      ),
    );
  }
}
