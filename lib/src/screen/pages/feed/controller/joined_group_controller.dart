import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinedGroupController extends GetxController {
  @override
  void onInit() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page.value += 5;
        loadingMore.value = true;
      }
    });
    super.onInit();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt page = 5.obs;
  RxBool loadingMore = false.obs;
  ScrollController scrollController = ScrollController();
}
