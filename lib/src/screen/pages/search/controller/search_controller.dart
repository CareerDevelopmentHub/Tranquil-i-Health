import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/screen/pages/chat/chat.dart';

import '../../../../constants/global.dart';
import '../../../../helper/database_service.dart';
import '../../../../theme/app_color.dart';

class SearchController extends GetxController {
  @override
  void onInit() {
    getCurrentUserIdandName();
    super.onInit();
  }

  TextEditingController searchController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  QuerySnapshot? searchSnapshot;
  RxBool hasUserSearched = false.obs;
  String userName = "";
  RxBool isJoined = false.obs;
  User? user = FirebaseAuth.instance.currentUser;

  getCurrentUserIdandName() async {
    userName = user!.displayName!;
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      isLoading.value = true;
      await DBService().searchByName(searchController.text).then((snapshot) {
        searchSnapshot = snapshot;
        isLoading.value = false;
        hasUserSearched.value = true;
      });
    }
  }

  groupList() {
    return Obx(() => hasUserSearched.value
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                userName,
                searchSnapshot!.docs[index]['groupId'],
                searchSnapshot!.docs[index]['groupName'],
                searchSnapshot!.docs[index]['admin'],
              );
            },
          )
        : Container());
  }

  joinedOrNot(
      String userName, String groupId, String groupname, String admin) async {
    await DBService(uid: user!.uid)
        .isUserJoined(groupname, groupId, userName)
        .then((value) {
      printMe(value, 'hint');
      isJoined.value = value;
    });
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    // function to check whether user already exists in group
    joinedOrNot(userName, groupId, groupName, admin);
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: primaryForegroundColor,
          child: Text(
            groupName.substring(0, 1).toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(groupName,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text("Admin: ${getName(admin)}"),
        trailing: InkWell(
            onTap: () async {
              await DBService(uid: user!.uid)
                  .toggleGroupJoin(groupId, userName, groupName);
              if (!isJoined.value) {
                isJoined.value = !isJoined.value;
                showSnackBar(
                    "Successfully joined the group", greenColor, Colors.white);
                Future.delayed(const Duration(seconds: 1), () {
                  Get.to(() => ChatPage(
                      groupId: groupId,
                      groupName: groupName,
                      userName: userName));
                });
              } else {
                isJoined.value = !isJoined.value;
                showSnackBar("Successfully Left the group $groupName", redColor,
                    Colors.white);
              }
            },
            child: Obx(
              () => isJoined.value
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryForegroundColor,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const Text(
                        "Joined",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryForegroundColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const Text("Join Now",
                          style: TextStyle(color: Colors.white)),
                    ),
            )),
      ),
    );
  }
}
