import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? textColor;
  final Widget? widget;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textColor,
    this.borderRadius,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 70.h,
      color: color ?? AppColors.primaryColor,
      minWidth: width ?? 200.w,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
      ),
      child: Row(
        children: [
          CustomText(
            text: text,
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: textColor ?? AppColors.whiteColor,
          ),
          if(widget != null)
            Gap(15.w)
           , widget!,
        ],
      ),
    );
  }
}
