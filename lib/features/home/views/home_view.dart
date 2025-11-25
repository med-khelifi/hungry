import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_routes.dart';
import 'package:hungry/features/home/widgets/categories_list_header.dart';
import 'package:hungry/features/home/widgets/item_card.dart';
import 'package:hungry/features/home/widgets/search_box_header.dart';
import 'package:hungry/features/home/widgets/user_info_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<String> _categories;

  @override
  void initState() {
    super.initState();
    _categories = ["All", "Combos", "Sliders", "Classic"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.whiteColor,
                shadowColor: AppColors.whiteColor,
                surfaceTintColor: AppColors.whiteColor,
                pinned: true,
                floating: false,
                snap: false,
                automaticallyImplyLeading: false,
                toolbarHeight: 280.h,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Gap(20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: UserInfoHeader(),
                      ),
                      Gap(20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: SearchBoxHeader(),
                      ),
                      Gap(20.h),
                      CategoriesListHeader(categories: _categories),
                    ],
                  ),
                ),
              ),
              SliverGap(15.h),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 8,
                    (context, index) => GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.productDetails),
                      child: ItemCard(
                        image: AppAssets.test,
                        title: "Cheeseburger",
                        subtitle: "Wendy's Burger",
                        rating: "4.9",
                      ),
                    ),
                  ),
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
      ),
    );
  }
}
