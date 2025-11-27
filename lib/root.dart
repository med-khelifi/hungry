import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/views/profile_view.dart';
import 'package:hungry/features/cart/views/card_view.dart';
import 'package:hungry/features/home/views/home_view.dart';
import 'package:hungry/features/orderHistory/views/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  late final PageController _pageController;

  final List<Widget> _screens = const [
    HomeView(),
    CartView(),
    OrderHistoryView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // Your pages
          PageView(
            clipBehavior: Clip.none,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),


          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    elevation: 0,
                    currentIndex: _currentIndex,
                    selectedItemColor: Colors.black87,
                    unselectedItemColor: Colors.black54,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 26.sp,
                    selectedFontSize: 12.sp,
                    unselectedFontSize: 11.sp,
                    onTap: (index) {
                      setState(() => _currentIndex = index);
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    items: const [
                      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
                      BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'Cart'),
                      BottomNavigationBarItem(icon: Icon(Icons.local_restaurant), label: 'Orders'),
                      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
