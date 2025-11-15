import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
