import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/constants/global.dart';
import 'package:healthhero/src/model/post_model.dart';
import 'package:healthhero/src/screen/helper/firebase_helper.dart';
import 'package:healthhero/src/screen/pages/controller/feed_controller.dart';
import 'package:healthhero/src/screen/pages/feed/design/post_design.dart';
import 'package:healthhero/src/theme/app_color.dart';
import 'package:healthhero/src/utils/circle_shimmer.dart';
import 'package:healthhero/src/utils/circular_progress.dart';

class MyPostScreen extends StatelessWidget {
  const MyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FeedController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Your Post'),
      ),
      body: RefreshIndicator(
        color: blueColor,
        onRefresh: () {
          printMe('refreshing', 'feed_screen.dart');
          return FirebaseFirestore.instance
              .collection('user')
              .doc(firebaseAuth.currentUser?.email)
              .collection('posts')
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
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(firebaseAuth.currentUser?.email)
                .collection('posts')
                .orderBy('timestamp', descending: true)
                .limit(controller.page.value)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                var snap = snapshot.data;
                List docs = snap!.docs;
                printMe(snap, docs);
                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    PostModel posts = PostModel.fromJson(docs[index].data());
                    printMe(posts, index);
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DesignPost(model: posts),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                printMe('printing', 'connecting');
                return circularProgress(context, blueColor);
              } else {
                printMe('No feed', '90');
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                          placeholder: (context, url) => createImageShimmer(),
                          imageUrl:
                              'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-626.jpg?w=996&t=st=1684603923~exp=1684604523~hmac=1b2294270b2a11896b8be511790ab06d9a36a41af19f9b294090c301069b349d'),
                      Text('No post found', style: kBodyTextTitleStyle()),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
