import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/widgets/custom_snack_bar.dart';
import 'package:hungry/features/home/data/product_item_model.dart';
import 'package:hungry/features/productDetails/data/product_details_repo.dart';
import 'package:hungry/features/productDetails/data/topping_option_model.dart';
import 'package:hungry/features/productDetails/widgets/item_spicy_header.dart';
import 'package:hungry/features/productDetails/widgets/price_details.dart';
import 'package:hungry/features/productDetails/widgets/topping_list.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late ProductDetailsRepo _productDetailsRepo;
  List<ToppingOptionModel>? _toppings;
  List<ToppingOptionModel>? _sideOptions;
  List<bool> _toppingSelection = List.filled(5, false);
  List<bool> _sideOptionSelection = List.filled(5, false);

  List<int> selectedToppings = [];
  List<int> selectedSideOptions = [];

  late ProductItemModel? _product;
  double _spicyValue = 0;
  bool isAdding = false;

  @override
  void initState() {
    super.initState();
    _productDetailsRepo = ProductDetailsRepo();
    _loadToppings();
    _loadSideOptions();
  }

  Future<void> addToCart() async {
    final data = {
      "items": [
        {
          "product_id": _product?.id,
          "quantity": 1,
          "spicy": _spicyValue,
          "toppings": selectedToppings,
          "side_options": selectedSideOptions,
        },
      ],
    };
    setState(()=> isAdding = true,);
    final res = await _productDetailsRepo.addToCart(data);
    setState(()=> isAdding = false,);
    if(res.isSuccess){
      CustomErrorSnackBar.show(
        context,
        "Item added to cart",
        isError: false
      );
    }else{
      CustomErrorSnackBar.show(
        context,
        res.error?.message ?? "Failed to add item to cart",
      );
    }

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    _product = arg is ProductItemModel ? arg : null;
  }

  void _loadToppings() async {
    final res = await _productDetailsRepo.fetchToppings();
    if (res.isSuccess) {
      setState(() {
        _toppings = res.data;
        _toppingSelection = List.filled(_toppings?.length ?? 5, false);
      });
    } else {
      CustomErrorSnackBar.show(
        context,
        res.error?.message ?? "Failed to load toppings",
      );
    }
  }

  void _loadSideOptions() async {
    final res = await _productDetailsRepo.fetchSideOptions();
    if (res.isSuccess) {
      setState(() {
        _sideOptions = res.data;
        _sideOptionSelection = List.filled(_sideOptions?.length ?? 5, false);
      });
    } else {
      CustomErrorSnackBar.show(
        context,
        res.error?.message ?? "Failed to load side options",
      );
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
            //fontWeight: FontWeight.w900,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),
              ItemSpicyHeader(
                imagePath: _product?.imageUrl,
                name: _product?.name,
                des: _product?.description,
                onSliderValueChanged: (double value) {
                  _spicyValue = value;
                },
              ),
              Gap(50.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: CustomText(
                  text: "Toppings",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondColor,
                ),
              ),
              Gap(10.h),
              Skeletonizer(
                enabled: _toppings == null,
                child: ToppingList(
                  toppings: _toppings,
                  selection: _toppingSelection,
                  onToppingSelected: (int index, int id) {
                    if (_toppings == null || _toppings!.isEmpty) return;
                    setState(() {
                      _toppingSelection[index] = !_toppingSelection[index];
                      selectedToppings.contains(id)
                          ? selectedToppings.remove(id)
                          : selectedToppings.add(id);
                    });
                  },
                ),
              ),
              Gap(50.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: CustomText(
                  text: "Side options",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondColor,
                ),
              ),
              Gap(10.h),
              Skeletonizer(
                enabled: _sideOptions == null,
                child: ToppingList(
                  toppings: _sideOptions,
                  selection: _sideOptionSelection,
                  onToppingSelected: (int index, int id) {
                    if (_sideOptions == null || _sideOptions!.isEmpty) return;
                    setState(() {
                      _sideOptionSelection[index] =
                          !_sideOptionSelection[index];
                      selectedSideOptions.contains(id)
                          ? selectedSideOptions.remove(id)
                          : selectedSideOptions.add(id);
                    });
                  },
                ),
              ),
              Gap(50.h),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 35.h),
                child: Row(
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
                   CustomButton(text: "Add to cart",
                       onPressed: addToCart,
                       widget: isAdding ? CupertinoActivityIndicator(color: AppColors.whiteColor,):
                       Icon(Icons.add_shopping_cart,color: AppColors.whiteColor,)
                   ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
