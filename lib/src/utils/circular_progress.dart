import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthhero/src/theme/app_color.dart';

Center circularProgress(context, Color? color) {
  return Center(
    child: SpinKitFadingCircle(
      size: 40.0,
      color: color ?? blueColor,
    ),
  );
}
