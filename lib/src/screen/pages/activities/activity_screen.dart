import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/screen/pages/activities/controller/activity_controller.dart';
import 'package:healthhero/src/theme/app_color.dart';

import '../search/search_screen.dart';

class ActivityScreen extends GetView<ActivityController> {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const SearchPage());
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: kDefaultIconDarkColor,
        title: const Text(
          "Groups",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: Obx(
        () => !controller.isFetching.value
            ? controller.groupList()
            : const Center(
                child: CircularProgressIndicator(
                  color: primaryForegroundColor,
                ),
              ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: const EdgeInsets.only(left: 40),
          child: FloatingActionButton(
            heroTag: 'hero-2',
            onPressed: () {
              controller.popUpDialog(context);
            },
            elevation: 0,
            backgroundColor: primaryForegroundColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
