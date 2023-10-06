import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/constants/global.dart';
import 'package:healthhero/src/screen/helper/firebase_helper.dart';
import 'package:healthhero/src/screen/pages/profile/components/camera_view.dart';
import 'package:healthhero/src/screen/pages/profile/components/favorite.dart';
import 'package:healthhero/src/screen/pages/profile/components/grid_view.dart';

class ProfileController extends GetxController {
  User? user = firebaseAuth.currentUser;

  Future getPostLength() async {
    return usersRef.doc(user?.email.toString()).get().then((value) {
      return value["post"];
    });
  }
  Future getTotalLikesLength() async {
    return usersRef.doc(user?.email.toString()).get().then((value) {
      return value["like"];
    });
  }

  Future getFollowersLength() async {
    return usersRef
        .doc(user?.email.toString())
        .collection('follwers')
        .get()
        .then((value) {
      printMe(value.size, 'follower length');
      return value.size;
    });
  }
  Future getFollowingLength() async {
    return usersRef
        .doc(user?.email.toString())
        .collection('following')
        .get()
        .then((value) {
      printMe(value.size, 'follower length');
      return value.size;
    });
  }

  List profilePages = [
    {
      'icon': Icons.grid_view,
      'page': const GridViewScreen(),
      'index': 0,
    },
    {
      'icon': Icons.video_call,
      'page': const CameraViewScreen(),
      'index': 1,
    },
    {
      'icon': Icons.favorite,
      'page': const FavViewScreen(),
      'index': 2,
    },
  ];
  RxInt idx = 0.obs;
  changeIdx(val) => idx.value = val;
  String get getUserName => sharedPreferences.getString('name') ?? 'Unknown';
  String get getUserImageUrl =>
      sharedPreferences.getString('photourl') ?? 'Unknown';
  String get getUserEmail => sharedPreferences.getString('email') ?? 'Unknown';
}
