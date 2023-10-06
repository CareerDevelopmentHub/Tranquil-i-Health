import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/theme/app_color.dart';
import 'package:shimmer/shimmer.dart';

createCircleShimmer() {
  return Shimmer.fromColors(
    baseColor: greyColor.withOpacity(0.25),
    highlightColor: whiteColor.withOpacity(0.6),
    period: const Duration(seconds: 2),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              10,
              (index) => Row(
                    children: const [
                      CircleAvatar(radius: 45),
                      SizedBox(width: 10),
                    ],
                  ))),
    ),
  );
}

createImageShimmer() {
  return Shimmer.fromColors(
    baseColor: greyColor.withOpacity(0.8),
    highlightColor: whiteColor.withOpacity(0.6),
    period: const Duration(seconds: 2),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        width: Get.width,
        decoration: BoxDecoration(
            color: greyColor.withOpacity(0.25),
            borderRadius: const BorderRadius.all(Radius.circular(24))),
      ),
    ),
  );
}
