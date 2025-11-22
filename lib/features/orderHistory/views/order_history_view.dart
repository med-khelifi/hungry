import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/orderHistory/widgets/item_history_card.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          itemBuilder: (context, index) => ItemHistoryCard(),
          separatorBuilder: (context, index) => Gap(10.h),
          itemCount: 10,
        ),
      ),
    );
  }
}
