import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/constants/global.dart';

import '../../../../helper/database_service.dart';
import '../../../../theme/app_color.dart';
import '../../../../widgets/group_tile.dart';

class ActivityController extends GetxController {
  String userName = "";
  String email = "";
  Stream? groups;
  RxBool isLoading = false.obs;
  RxBool isFetching = true.obs;
  String groupName = "";
  String groupDesc = "";
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    gettingUserData();
    super.onInit();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    email = user!.email!;
    userName = user!.displayName!;
    printMe(FirebaseAuth.instance.currentUser!.uid, '');
    // getting the list of snapshots in our stream
    await DBService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      groups = snapshot;
      isFetching.value = false;
    });
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a group",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(color: greenColor),
                        )
                      : TextField(
                          cursorColor: primaryForegroundColor,
                          onChanged: (val) {
                            setState(() {
                              groupName = val;
                            });
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: 'Enter group name',
                              hintStyle: const TextStyle(
                                  color: greyColor, fontSize: 12),
                              labelText: 'Enter group name',
                              labelStyle: const TextStyle(
                                  color: primaryForegroundColor),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: primaryForegroundColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: primaryForegroundColor),
                                  borderRadius: BorderRadius.circular(20))),
                        )),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (groupName != "") {
                          isLoading.value = true;
                          DBService(uid: FirebaseAuth.instance.currentUser!.uid)
                              .createGroup(
                                  userName,
                                  FirebaseAuth.instance.currentUser!.uid,
                                  groupName)
                              .whenComplete(() {
                            isLoading.value = false;
                          });
                          Get.back();
                          showSnackBar("Group created successfully.",
                              greenColor, Colors.white);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: greenColor,
                          side: const BorderSide(color: greenColor)),
                      child: const Text("CREATE"),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          side: const BorderSide(color: redColor)),
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(color: redColor),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }));
        });
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  return GroupTile(
                      groupId: getId(snapshot.data['groups'][reverseIndex]),
                      groupName: getName(snapshot.data['groups'][reverseIndex]),
                      userName: snapshot.data['name']);
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(Get.context!);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
