import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.id,
    required this.itemCount,
    required this.onPressedDecrease,
    required this.onPressedIncrease,
    required this.onPressedRemove,
    required this.image,
    required this.name,
  });

  final String? itemCount;
  final int id;
  final String? image;
  final String? name;
  final VoidCallback onPressedIncrease;
  final VoidCallback onPressedRemove;
  final VoidCallback onPressedDecrease;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: CustomText(text: 'Remove Item', fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.secondColor),
            content:  CustomText(text:'Are you sure you want to remove this item from the cart?', fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.secondColor),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: CustomText(text:'Cancel',color: AppColors.secondColor,fontSize: 16.sp,fontWeight: FontWeight.w600,),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: CustomText(text: 'Remove',color: AppColors.secondColor,fontSize: 16.sp,fontWeight: FontWeight.w600,),
              ),
            ],
          ),
        );
      },
      background: Container(
        color: AppColors.secondColor.withOpacity(0.12),
        child: Icon(Icons.delete,color: AppColors.redColor,size: 40.sp,),
      ),
      child: Card(
        elevation: 6,
        shadowColor: AppColors.secondColor.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: image != null
                        ? Image.network(
                      image!,
                      height: 110.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            AppAssets.splash,
                            height: 110.h,
                          ),
                    )
                        : Image.asset(
                      AppAssets.splash,
                      height: 110.h,
                    ),
                  ),
                  Gap(10.h),
                  SizedBox(
                    width: 110.w,
                    child: CustomText(
                      text: name ?? "Product",
                      color: AppColors.secondColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              Gap(15.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: onPressedDecrease,
                          child: Container(
                            width: 38.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppColors.secondColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Icon(Icons.remove),
                          ),
                        ),

                        Gap(25.w),

                        CustomText(
                          text: itemCount.toString(),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondColor,
                        ),

                        Gap(25.w),

                        InkWell(
                          onTap: onPressedIncrease,
                          child: Container(
                            width: 38.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppColors.secondColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),

                    Gap(25.h),

                    CustomButton(
                      text: "Remove",
                      onPressed: onPressedRemove,
                      height: 45.h,
                      width: 140.w,
                      borderRadius: 30.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
