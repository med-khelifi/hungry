import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_routes.dart';
import 'package:hungry/features/auth/widgets/custom_snack_bar.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/cart/data/cart_repo.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';
import 'package:hungry/features/productDetails/widgets/price_details.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartRepo cartRepo;
   CartModel? cart;
  @override
  void initState() {
    super.initState();
    cartRepo = CartRepo();
    fetchCart();
  }
  void fetchCart() async {
    final response = await cartRepo.fetchCart();
    if (response.isSuccess) {
      setState(() {
        cart = response.data!;
      });
    }
    else {
     CustomErrorSnackBar.show(context, response.error?.message ?? "Failed to fetch cart");
    }
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
              child: Skeletonizer(
                enabled: cart == null,
                child: ListView.separated(
                  itemBuilder: (context, index) => CartItem(
                    id: cart?.items[index]?.itemId ?? index,
                    itemCount: cart?.items[index]?.quantity?.toString() ?? "0",
                    onPressedDecrease: () {},
                    onPressedIncrease: () {},
                    onPressedRemove: () {},
                    image: cart?.items[index]?.image,
                    name: cart?.items[index]?.name,
                  ),
                  separatorBuilder: (context, index) => Gap(20.h),
                  itemCount: cart?.items.length ?? 4,
                ),
              ),
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Skeletonizer(
                  enabled: cart == null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Total",
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.secondColor,
                      ),
                      PriceDetails(text: cart?.totalPrice.toString() ?? "0"),
                    ],
                  ),
                ),
                CustomButton(
                  text: "Checkout",
                  onPressed: () {
                    if(cart == null){
                      return;
                    }
                    Navigator.pushNamed(context, Routes.checkout);
                  },
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Gap(110.h),
          ],
        ),
      ),
    );
  }
}
