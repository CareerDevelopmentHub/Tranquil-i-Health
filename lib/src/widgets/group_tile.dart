import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/theme/app_color.dart';

import '../screen/pages/chat/chat.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ChatPage(
            groupId: widget.groupId,
            groupName: widget.groupName,
            userName: widget.userName));
      },
      child: Card(
        margin: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ListTile(
            //  trailing: const Icon(Icons.info, color: primaryColor),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: primaryForegroundColor,
              child: Text(
                widget.groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            title: Text(
              widget.groupName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Talk as ${widget.userName}",
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }
}
