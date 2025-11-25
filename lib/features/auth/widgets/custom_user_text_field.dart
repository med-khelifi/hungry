import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUserTextField extends StatelessWidget {
  const CustomUserTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
