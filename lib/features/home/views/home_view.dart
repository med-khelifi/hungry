import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/home/widgets/home_view_header.dart';
import 'package:hungry/features/home/widgets/item_card.dart';
import 'package:hungry/shared/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<String> _categories;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _categories = ["All", "Combos", "Sliders", "Classic"];
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: HomeViewHeader(),
                  ),
                  Gap(20),
                  SizedBox(
                    height: 45.h,
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: 15.w),
                      separatorBuilder: (context, index) => Gap(10.w),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: index == _currentIndex
                                  ? AppColors.primaryColor
                                  : Color(0xffF3F4F6),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: CustomText(
                              fontWeight: FontWeight.w500,
                              text: _categories[index],
                              fontSize: 16.sp,
                              color: index == _currentIndex
                                  ? AppColors.whiteColor
                                  : Color(0xff6A6A6A),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(20),
                ],
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(childCount: 8, (
                  context,
                  index,
                ) {
                  return ItemCard(
                    image: AppAssets.test,
                    title: "Cheeseburger",
                    subtitle: "Wendy's Burger",
                    rating: "4.9",
                  );
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 0.73,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
