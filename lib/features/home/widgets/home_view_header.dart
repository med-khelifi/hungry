import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppAssets.logo,
                  height: 46.h,
                  color: AppColors.primaryColor,
                ),
                Gap(10.h),
                CustomText(
                  text: "Hello, Rich Sonic",
                  fontSize: 18.sp,
                  color: Color(0xff6A6A6A),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: AssetImage(AppAssets.profile),
              radius: 40.r,
            ),
          ],
        ),
        Gap(20),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20.r),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.black),
              hintText: "Search",
              hintStyle: TextStyle(color: Color(0xff000000), fontSize: 16.sp),
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
        ),
      ],
    );
  }
}
