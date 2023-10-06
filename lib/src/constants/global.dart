import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/constants/constant_literals.dart';
import 'package:healthhero/src/theme/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;


printMe(var e, var hint) {
  if (kDebugMode) {
    print("${e.toString()}------------------${hint.toString()}");
  }
}

showSnackBar(var message, Color color, Color? textColor) {
  return Get.rawSnackbar(
      title: appName,
      messageText: Text(
        message.toString(),
        style: kBodyTextSubtitleStyle(),
      ),
      // message: message,
      backgroundColor: color,
      icon: Container(
        margin: const EdgeInsets.only(left: 4, right: 4),
        child: Image.asset(
          'assets/images/ico.gif',
          // fit: BoxFit.cover,
          // height: 60,
          // width: 10,
        ),
      ));
}
