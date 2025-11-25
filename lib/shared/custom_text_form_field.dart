import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.prefixIcon,
  });

  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? prefixIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword ? _obscure : false,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 15.sp,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: Colors.white, size: 22.sp)
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
