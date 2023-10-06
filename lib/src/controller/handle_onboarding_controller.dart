import 'dart:async';

import 'package:get/get.dart';

import '../constants/global.dart';
import '../screen/auth/authentication_page.dart';
import '../screen/pages/home_screen.dart';

class HandleOnBoardingController extends GetxController {
  @override
  void onInit() {
    takeDecision();
    super.onInit();
  }

  takeDecision() {
    Timer(const Duration(seconds: 3), () {
      if (sharedPreferences.getString('logged') != null) {
        Get.off(() => const HomePage());
      } else {
        Get.off(() => const AuthenticationPage());
      }
    });
  }
}
