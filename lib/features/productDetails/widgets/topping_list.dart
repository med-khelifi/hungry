import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/features/productDetails/data/topping_option_model.dart';
import 'package:hungry/features/productDetails/widgets/topping_card.dart';

class ToppingList extends StatelessWidget {
  const ToppingList({super.key,required this.selection, required this.toppings, required this.onToppingSelected});

  final List<bool> selection ;
  final List<ToppingOptionModel>? toppings ;
  final Function(int index,int id) onToppingSelected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        separatorBuilder: (context, index) => Gap(30.w),
        scrollDirection: Axis.horizontal,
        itemCount:toppings?.length ?? 5,
        itemBuilder: (context, index) {
          return ToppingCard(
            isSelected: selection?[index] ?? false,
            imagePath: toppings?[index]?.imagePath,
            onTap: () {
               onToppingSelected(index,toppings?[index]?.id ?? 0);
            },
            title: toppings?[index]?.name ?? "Tomato",
          );
        },
      ),
    );
  }
}
