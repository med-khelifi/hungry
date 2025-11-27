import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/constants/app_routes.dart';

class Hungry extends StatelessWidget {
  const Hungry({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 923.4),
      child: MaterialApp(
        initialRoute: Routes.splash,
        routes: AppRoutes.routes,
        theme: ThemeData(
          splashColor: Colors.transparent,
         // scaffoldBackgroundColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }
}
