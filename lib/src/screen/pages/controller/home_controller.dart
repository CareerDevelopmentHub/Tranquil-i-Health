import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/screen/pages/activities/activity_screen.dart';
import 'package:healthhero/src/screen/pages/feed/feed_screen.dart';
import 'package:healthhero/src/screen/pages/profile/profile_screen.dart';
import 'package:healthhero/src/screen/pages/search/search_screen.dart';
import 'package:ionicons/ionicons.dart';

class HomeController extends GetxController {
  RxInt index = 0.obs;
  changeIndex(newVal) {
    index.value = newVal;
  }

  List pages = [
    {
      'title': 'Home',
      'icon': Ionicons.home,
      'page': const FeedsScreen(),
      'index': 0,
    },
    {
      'title': 'Search',
      'icon': Ionicons.search,
      'page': const SearchPage(),
      'index': 1,
    },
    {
      'title': 'unsee',
      'icon': Ionicons.add_circle,
      'page': const Text('nes'),
      'index': 2,
    },
    {
      'title': 'Notification',
      'icon': Ionicons.chatbox,
      'page': const ActivityScreen(),
      'index': 3,
    },
    {
      'title': 'Profile',
      'icon': CupertinoIcons.person_fill,
      'page': const ProfileScreen(),
      'index': 4,
    },
  ];
}
