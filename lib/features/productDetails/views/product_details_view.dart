import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/productDetails/widgets/item_spacy_header.dart';
import 'package:hungry/features/productDetails/widgets/price_details.dart';
import 'package:hungry/features/productDetails/widgets/topping_list.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.secondColor,
            //fontWeight: FontWeight.w900,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),
              ItemSpacyHeader(),
              Gap(50.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: CustomText(
                  text: "Toppings",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondColor,
                ),
              ),
              Gap(10.h),
              ToppingList(),
              Gap(50.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: CustomText(
                  text: "Side options",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondColor,
                ),
              ),
              Gap(10.h),
              ToppingList(),
              Gap(50.h),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 35.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Total",
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.secondColor,
                        ),
                        PriceDetails(text: "19.18"),
                      ],
                    ),
                    CustomButton(text: "Add to cart", onPressed: () {}),
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
