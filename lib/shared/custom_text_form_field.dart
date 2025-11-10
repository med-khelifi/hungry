import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.validator,
    this.controller,
  });

  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isPasswordVisible,
      validator: widget.validator,
      controller: widget.controller,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: widget.isPassword
                    ? () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      }
                    : null,
                child: Icon(
                  _isPasswordVisible
                      ? CupertinoIcons.eye_slash
                      : CupertinoIcons.eye,
                ),
              )
            : null,
        fillColor: AppColors.whiteColor,
        filled: true,
        hintText: widget.hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
