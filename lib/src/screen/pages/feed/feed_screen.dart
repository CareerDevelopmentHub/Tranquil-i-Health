import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/constants/constant_literals.dart';
import 'package:healthhero/src/constants/global.dart';
import 'package:healthhero/src/screen/hospital/custom_hospital_rating.dart';
import 'package:healthhero/src/screen/pages/controller/feed_controller.dart';
import 'package:healthhero/src/screen/pages/feed/design/post_design.dart';
import 'package:healthhero/src/theme/app_color.dart';
import '../../../model/post_model.dart';
import '../../../utils/circle_shimmer.dart';
import '../../../utils/circular_progress.dart';
import '../../helper/firebase_helper.dart';
import '../activities/activity_screen.dart';
import 'components/group_screen_view.dart';
import 'design/group_design.dart';
import '../../../model/group_model.dart';

class FeedsScreen extends GetView<FeedController> {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: Text(appName,
            style: kBodyTextTitleStyle().copyWith(color: whiteColor)),
        centerTitle: true,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(
                Icons.chat,
                size: 30.0,
              ),
              onPressed: () {
                Get.to(() => const ActivityScreen());
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(
                height: 140,
                width: double.infinity,
                child: FutureBuilder(
                    future: groupsRef.get(),
                    builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        var snap = snapshot.data;
                        List docs = snap!.docs;
                        printMe(snap, docs);
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          //  controller: controller.scrollController,
                          itemCount: docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            GroupModel group =
                                GroupModel.fromMap(docs[index].data());
                            // PostModel posts =
                            //     PostModel.fromJson(docs[index].data());
                            //printMe(posts, index);
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      GroupScreenView(route: '${group.title}'));
                                },
                                child: GroupDesignView(model: group),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        printMe('printing', 'connecting for group');
                        return createCircleShimmer();
                      } else {
                        printMe('No group', '85');
                        return createCircleShimmer();
                      }
                    }))),
            Expanded(
              child: RefreshIndicator(
                color: blueColor,
                onRefresh: () {
                  printMe('refreshing', 'feed_screen.dart');
                  return postRef
                      .orderBy('timestamp', descending: true)
                      .limit(controller.page.value)
                      .get();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: StreamBuilder(
                    stream: postRef
                        .orderBy('timestamp', descending: true)
                        .limit(controller.page.value)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        var snap = snapshot.data;
                        List docs = snap!.docs;
                        return ListView.builder(
                          controller: controller.scrollController,
                          itemCount: docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            PostModel posts =
                                PostModel.fromJson(docs[index].data());

                            printMe(posts, index);
                            return GestureDetector(
                              onTap: () {
                                // print(posts.description?.split('**')[0].trim());
                                Get.to(() => CustomHospitalRankingScreen(
                                      appbarText: posts.description!
                                          .split('**')[0]
                                          .trim(),
                                      hospitalName: posts.description!
                                          .split('**')[0]
                                          .trim(),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DesignPost(model: posts),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        printMe('printing', 'connecting');
                        return circularProgress(context, blueColor);
                      } else {
                        printMe('No feed', '90');
                        return Center(
                          child: Text('No Posts', style: kBodyTextTitleStyle()),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
