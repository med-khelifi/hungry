import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/features/productDetails/widgets/topping_card.dart';

class ToppingList extends StatelessWidget {
  const ToppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        separatorBuilder: (context, index) => Gap(30.w),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return ToppingCard(
            imagePath: AppAssets.tomato,
            onAdd: () {},
            title: "Tomato",
          );
        },
      ),
    );
  }
}
