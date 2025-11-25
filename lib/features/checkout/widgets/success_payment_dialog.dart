import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class SuccessPaymentDialog extends StatelessWidget {
  const SuccessPaymentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(20.h),
            Icon(
              Icons.check_circle,
              color: AppColors.primaryColor,
              size: 150.sp,
            ),
            Gap(20.h),
            CustomText(
              text: "Success !",
              textAlign: TextAlign.center,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            Gap(20.h),
            Center(
              child: CustomText(
                text:
                    "Your payment was successful.A receipt for this purchase has been sent to your email.",
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.greyColor,
              ),
            ),
            Gap(20.h),
            CustomButton(
              text: "Go Back",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
