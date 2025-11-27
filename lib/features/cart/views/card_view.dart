import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_routes.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';
import 'package:hungry/features/productDetails/widgets/price_details.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> itemsCount;

  @override
  void initState() {
    super.initState();
    itemsCount = List.filled(10, 1);
  }

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
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => CartItem(
                  value: itemsCount[index].toString(),
                  onPressedDecrease: () {
                    if (itemsCount[index] > 1) {
                      itemsCount[index]--;
                      setState(() {});
                    }
                  },
                  onPressedIncrease: () {
                    itemsCount[index]++;
                    setState(() {});
                  },
                  onPressedRemove: () {},
                ),
                separatorBuilder: (context, index) => Gap(20.h),
                itemCount: 10,
              ),
            ),
            Gap(10.h),
            Row(
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
                CustomButton(
                  text: "Checkout",
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.checkout);
                  },
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Gap(100.h),
          ],
        ),
      ),
    );
  }
}
