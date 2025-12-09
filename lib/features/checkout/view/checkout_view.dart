import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/widgets/custom_snack_bar.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/checkout/data/checkout_repo.dart';
import 'package:hungry/features/checkout/data/order_item_model.dart';
import 'package:hungry/features/checkout/widgets/success_payment_dialog.dart';
import 'package:hungry/features/productDetails/widgets/price_details.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  List<OrderItemModel?> orderItems = [];
  CheckoutRepo checkoutRepo = CheckoutRepo();
  double totalPrice =0;
  bool isLoading = false;
  CartModel? cart;
  double taxes = 0.30;
  double deliveryFees = 1.50;
  double allPrice = 0;
  bool isAgree = false;
  late AuthRepo authRepo;

  // selected payment method
  String? selectedPayment = "Cash";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authRepo = AuthRepo();
    cart = ModalRoute.of(context)?.settings.arguments as CartModel;
    allPrice = cart?.totalPrice ?? 0 + taxes + deliveryFees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Order summary",
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                      color: AppColors.secondColor,
                    ),
                    Gap(25.h),

                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Column(
                        children: [
                          _summaryRow("Order", "\$$totalPrice", false),
                          Gap(10.h),
                          _summaryRow("Taxes", "\$$taxes", false),
                          Gap(10.h),
                          _summaryRow("Delivery fees", "\$$deliveryFees", false),
                          Gap(10.h),
                          Divider(
                            thickness: 1,
                            color: AppColors.greyPaymentViewDividerColor,
                          ),
                          Gap(25.h),
                          _summaryRow(
                            "Total:",
                            "\$$allPrice",
                            true,
                            color: AppColors.secondColor,
                          ),
                          Gap(20.h),
                          _summaryRow(
                            "Estimated delivery time:",
                            "15 - 30 mins",
                            true,
                            color: AppColors.secondColor,
                          ),
                        ],
                      ),
                    ),

                    Gap(70.h),

                    CustomText(
                      text: "Payment Method",
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                      color: AppColors.secondColor,
                    ),

                    Gap(20.h),

                    _paymentTile(
                      value: "Cash",
                      title: "Cash on Delivery",
                      icon: Image.asset(AppAssets.dollar, width: 35.w),
                    ),

                    Gap(20.h),

                   if(authRepo.currentUser!.viza != null)
                     _paymentTile(
                      value: "Card",
                      title: "Debit Card",
                      subtitle: "3566 **** **** 0505",
                      icon: Image.asset(AppAssets.viza, width: 55.w),
                    ),

                    Gap(20.h),

                   if(authRepo.currentUser!.viza != null)
                     Row(
                      children: [
                        Checkbox(
                          value: isAgree,
                          onChanged: (value) {
                            setState(() {
                              isAgree = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          side: BorderSide(),
                          checkColor: AppColors.whiteColor,
                          activeColor: AppColors.pinkCheckboxColor,
                        ),
                        CustomText(
                          text: "Save card details for future payments",
                          color: AppColors.greyColor,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// payment button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyPaymentViewColor,
                    blurRadius: 20.r,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Total Price",
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.secondColor,
                      ),
                      PriceDetails(text: allPrice.toString()),
                    ],
                  ),
                  CustomButton(
                    text: "Pay Now",
                    widget: isLoading ? CupertinoActivityIndicator( color: AppColors.whiteColor,) : null,
                    fontSize: 18.sp,
                    onPressed: () async {
                      orderItems = cart?.items.map((e) => OrderItemModel(
                        itemId: e.itemId,
                        quantity: e.quantity,
                        spicy: e.spicy,
                        toppings: e.toppings,
                        sideOptions: e.sideOptions,
                      )).toList() ?? [];
                      final data = {
                        "items" : orderItems.map((e) => e?.toJsonWithToppingsIds() ?? {}).toList(),
                      };
                      print(data);
                      setState(() => isLoading = true,);
                        final res = await checkoutRepo.checkout(data);
                        setState(() => isLoading = false,);
                        if(res.isSuccess){
                          showDialog(context: context, builder: (context) => SuccessPaymentDialog(),);
                        }
                        else{
                          CustomErrorSnackBar.show(context, res.error?.message ?? "Something went wrong");
                        }

                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String text, String value, bool isBold, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text,
          color: color ?? AppColors.greyPaymentViewColor,
          fontSize: 18.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        ),
        CustomText(
          text: value,
          color: color ?? AppColors.greyPaymentViewColor,
          fontSize: 18.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        ),
      ],
    );
  }

  Widget _paymentTile({
    required String value,
    required String title,
    String? subtitle,
    required Widget icon,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(15.r),
      elevation: 3,
      child: RadioListTile<String>(
        value: value,
        groupValue: selectedPayment,
        activeColor: AppColors.secondColor,
        onChanged: (value) {
          setState(() => selectedPayment = value!);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
        title: Row(
          children: [
            icon,
            Gap(15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: AppColors.secondColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                if (subtitle != null)
                  CustomText(
                    text: subtitle,
                    color: AppColors.greyColor,
                    fontSize: 14.sp,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
