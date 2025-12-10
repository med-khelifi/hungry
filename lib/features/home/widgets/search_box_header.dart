import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_colors.dart';

class SearchBoxHeader extends StatelessWidget {
  const SearchBoxHeader({super.key, required this.onSearch});

  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.h,
      borderRadius: BorderRadius.circular(20.r),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.search, color: AppColors.secondColor),
          hintText: "Search",
          hintStyle: TextStyle(color: AppColors.secondColor, fontSize: 16.sp),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.r),
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }
}
