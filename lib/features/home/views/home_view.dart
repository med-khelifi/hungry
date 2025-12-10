import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_routes.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/widgets/custom_snack_bar.dart';
import 'package:hungry/features/home/data/product_item_model.dart';
import 'package:hungry/features/home/data/product_repo.dart';
import 'package:hungry/features/home/widgets/categories_list_header.dart';
import 'package:hungry/features/home/widgets/item_card.dart';
import 'package:hungry/features/home/widgets/search_box_header.dart';
import 'package:hungry/features/home/widgets/user_info_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<String> _categories;
  late AuthRepo _authRepo;
  late ProductRepo _productRepo;
  List<ProductItemModel?>? _products;
  List<ProductItemModel?>? _searchedProducts = [];
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepo();
    _productRepo = ProductRepo();
    _categories = ["All", "Combos", "Sliders", "Classic"];
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _products = null;
    });
    final res = await _productRepo.fetchProducts();
    if (res.isSuccess) {
      setState(() {
        _products = res.data;
      });
    } else {
      CustomErrorSnackBar.show(
        context,
        res.error?.message ?? "Failed to load products",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: RefreshIndicator(
          onRefresh: _loadProducts,
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
                          child: UserInfoHeader(
                            username:_authRepo.isGuest || _authRepo.currentUser == null
                              ?  "Guest"
                               : _authRepo.currentUser.name ?? "",
                            imageUrl: _authRepo.currentUser?.image,
                          ),
                        ),
                        Gap(20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: SearchBoxHeader(onSearch: (query) {
                            if(_products == null || query.isEmpty){
                              setState(() {
                                isSearch = false;
                              });
                            }else{
                              setState(() {
                                _searchedProducts = _products?.where((product) => product?.name?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
                                isSearch = true;
                              });
                            }
                          },),
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
                  sliver: Skeletonizer.sliver(
                    enabled: _products == null,
                    child: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        childCount: isSearch ? _searchedProducts?.length ?? 6 : _products?.length ?? 6,
                        (context, index) {
                          final product = isSearch ? _searchedProducts![index] : _products?[index];
                          return GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.productDetails,arguments: product),
                          child: ItemCard(
                            image: product?.imageUrl,
                            title: product?.name ?? "Cheeseburger",
                            subtitle: product?.description ?? "Wendy's Burger",
                            rating:product?.rating.toString() ?? "4.9",
                          ),
                        );
                        },
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 0.73,
                      ),
                    ),
                  ),
                ),
                SliverGap(100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
