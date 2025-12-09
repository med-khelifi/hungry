import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/widgets/custom_snack_bar.dart';
import 'package:hungry/features/orderHistory/data/order_item_model.dart';
import 'package:hungry/features/orderHistory/data/order_history_repo.dart';
import 'package:hungry/features/orderHistory/widgets/item_history_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  late OrderHistoryRepo _orderHistoryRepo;
  List<OrderItemModel?>? _orderHistory;
  @override
  void initState() {
    super.initState();
    _orderHistoryRepo = OrderHistoryRepo();
    getOrderHistory();
  }
  Future<void> getOrderHistory() async {
    setState(() => _orderHistory = null,);
    final response = await _orderHistoryRepo.getOrderHistory();
    if (response.isSuccess) {
      setState(() {
        _orderHistory = response.data;
        print(response.data);
      });
    }
    else{
      CustomErrorSnackBar.show(context, response.error?.message ?? "Something went wrong");
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: getOrderHistory,
        child: Skeletonizer(
          enabled: _orderHistory == null,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
                  itemBuilder: (context, index) => index == (_orderHistory?.length ?? 6) - 1 ? Column(
                    children: [
                      ItemHistoryCard(orderItem: _orderHistory?[index],),
                      Gap(70.h),
                    ],
                  ) : ItemHistoryCard(orderItem: _orderHistory?[index],),
                  separatorBuilder: (context, index) => Gap(10.h),
                  itemCount: _orderHistory?.length ?? 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
