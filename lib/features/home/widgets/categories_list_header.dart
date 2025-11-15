import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class CategoriesListHeader extends StatefulWidget {
  const CategoriesListHeader({super.key, required this.categories});

  final List<String> categories;

  @override
  State<CategoriesListHeader> createState() => _CategoriesListHeaderState();
}

class _CategoriesListHeaderState extends State<CategoriesListHeader> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        separatorBuilder: (context, index) => Gap(10.w),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: index == _currentIndex
                    ? AppColors.primaryColor
                    : Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CustomText(
                fontWeight: FontWeight.w500,
                text: widget.categories[index],
                fontSize: 16.sp,
                color: index == _currentIndex
                    ? AppColors.whiteColor
                    : Color(0xff6A6A6A),
              ),
            ),
          );
        },
      ),
    );
  }
}
