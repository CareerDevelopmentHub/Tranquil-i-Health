import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/screen/auth/authentication_page.dart';
import 'package:healthhero/src/screen/helper/firebase_helper.dart';
import 'package:healthhero/src/screen/pages/profile/components/widgets/my_post.dart';
import 'package:healthhero/src/screen/pages/profile/controller/profile_controller.dart';
import 'package:healthhero/src/service/local_storage.dart';
import 'package:healthhero/src/theme/app_color.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: primaryColor,
          title: Text(
            'My Account',
            style: kBodyTextTitleStyle().copyWith(color: whiteColor),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Card(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: CircleAvatar(
                              radius: 20.h, // Image radius
                              backgroundImage: NetworkImage(controller
                                      .user?.photoURL ??
                                  'https://i.pinimg.com/564x/16/dd/1a/16dd1abb3f890a59e454149884a19a7c.jpg'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.getUserName.capitalizeFirst}',
                                style: kBodyTextTitleStyle()
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${controller.getUserEmail.capitalizeFirst}',
                                softWrap: true,
                                style: kBodyTextTitleStyle().copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: greyColor,
                                    fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Get.to(() => const MyPostScreen()),
                    child: Card(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        width: double.infinity,
                        child: Text(
                          'Your Post',
                          style: kProfileTextStyle(),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 10, bottom: 10),
                  //     width: double.infinity,
                  //     child: Text(
                  //       'Your Reach',
                  //       style: kProfileTextStyle(),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 10, bottom: 10),
                  //     width: double.infinity,
                  //     child: Text(
                  //       'Your Score',
                  //       style: kProfileTextStyle(),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 10, bottom: 10),
                  //     width: double.infinity,
                  //     child: Text(
                  //       'Your Data',
                  //       style: kProfileTextStyle(),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 10, bottom: 10),
                  //     width: double.infinity,
                  //     child: Text(
                  //       'Privacy',
                  //       style: kProfileTextStyle(),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 10, bottom: 10),
                  //     width: double.infinity,
                  //     child: Text(
                  //       'Data Sharing',
                  //       style: kProfileTextStyle(),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 10, bottom: 10),
                  //     width: double.infinity,
                  //     child: Text(
                  //       'Session Management',
                  //       style: kProfileTextStyle(),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Card(
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 10, bottom: 10),
                  //     width: double.infinity,
                  //     child: Text(
                  //       'Your Security Keys',
                  //       style: kProfileTextStyle(),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 38,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () {
                          firebaseAuth.signOut().then((value) {
                            LocalStorage.clearDB();
                            Get.offAll(() => const AuthenticationPage());
                          });
                        },
                        child: const Text('Logout'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _userActions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: primaryForegroundColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.person_add,
                    color: whiteColor,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    'Follow',
                    style: kBodyTextTitleStyle().copyWith(color: whiteColor),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 50,
            //width: 130,
            decoration: BoxDecoration(
              border: Border.all(color: primaryForegroundColor, width: 2),
              color: whiteColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.sms,
                    color: primaryForegroundColor,
                    //  size: 25,
                  ),
                ),
                const SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    'Message',
                    style: kBodyTextTitleStyle()
                        .copyWith(color: primaryForegroundColor),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffFAF6FE),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            // height: 50,
            // width: 20,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Ionicons.logo_twitter,
                color: primaryForegroundColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffFAF6FE),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            // height: 50,
            // width: 20,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.expand_more,
                color: primaryForegroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _userInfo() {
    // printMe(postLengthRef.doc(controller.user?.email.toString()).get(), 'hint');
    // FutureBuilder(
    //     future: postLengthRef.get(),
    //     builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasData) {
    //         printMe(snapshot.data, 'hint');
    //         return const Text('data');
    //       } else {
    //         printMe(snapshot.data, 'hint');
    //         return const Text('data');
    //       }
    //     }));
    // StreamBuilder(
    //     stream:
    //         postLengthRef.doc(controller.user?.email.toString()).snapshots(),
    //     builder: (context, AsyncSnapshot snapshot) =>
    //         printMe(snapshot.data.docs, 'hint'));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            // StreamBuilder(
            //   stream: postLengthRef
            //       .doc(controller.user?.email.toString())
            //       .snapshots(),
            //   builder: (context, AsyncSnapshot snapshot) => snapshot.hasData
            //       ? Text(snapshot.data!.docs["post"].toString())
            //       : const Text('0'),
            // ),
            FutureBuilder(
                future: controller.getPostLength(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Text(
                        snapshot.data.toString(),
                        style: kBodyTextTitleStyle(),
                      )
                    : Text('0', style: kBodyTextTitleStyle())),
            //  Text(controller.getPostLength().toString()),
            const SizedBox(height: 10),
            const Text('Posts'),
          ],
        ),
        Container(
          color: Colors.black45,
          height: 50,
          width: 2,
        ),
        Column(
          children: [
            FutureBuilder(
                future: controller.getFollowersLength(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Text(
                        snapshot.data.toString(),
                        style: kBodyTextTitleStyle(),
                      )
                    : Text('0', style: kBodyTextTitleStyle())),
            const SizedBox(height: 10),
            const Text('Followers'),
          ],
        ),
        Container(
          color: Colors.black45,
          height: 50,
          width: 2,
        ),
        Column(
          children: [
            FutureBuilder(
                future: controller.getFollowingLength(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Text(
                        snapshot.data.toString(),
                        style: kBodyTextTitleStyle(),
                      )
                    : Text('0', style: kBodyTextTitleStyle())),
            const SizedBox(height: 10),
            const Text('Following'),
          ],
        ),
        Container(
          color: Colors.black45,
          height: 50,
          width: 2,
        ),
        Column(
          children: [
            FutureBuilder(
                future: controller.getTotalLikesLength(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Text(
                        snapshot.data.toString(),
                        style: kBodyTextTitleStyle(),
                      )
                    : Text('0', style: kBodyTextTitleStyle())),
            const SizedBox(height: 10),
            const Text('Likes'),
          ],
        ),
      ],
    );
  }
}
