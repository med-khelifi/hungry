import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.color,
    this.maxLines,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines ?? 5,
      overflow: TextOverflow.ellipsis,
      textScaler: TextScaler.linear(1.0),
      textAlign: textAlign,
      text,
      style: TextStyle(
        fontSize: fontSize ?? 13.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.whiteColor,
      ),
    );
  }
}
