import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/controller/all_controller.dart';
import 'package:healthhero/src/screen/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: ((context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: const HandleOnBoarding(),
            initialBinding: AllBindings(),
          )),
    );
  }
}
