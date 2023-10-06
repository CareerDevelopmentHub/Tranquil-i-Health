import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/theme/app_color.dart';

import '../screen/pages/createpost/create_post.dart';

class AddIconContainer extends StatelessWidget {
  const AddIconContainer({
    Key? key,
    this.page,
    required this.icon,
    required this.mini,
  }) : super(key: key);
  final Widget? page;
  final IconData icon;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return page!;
      },
      closedElevation: 4.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56 / 2),
        ),
      ),
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return FloatingActionButton(
          backgroundColor: primaryForegroundColor,
          onPressed: () {
            chooseUpload(context);
          },
          mini: mini,
          child: Icon(
            icon,
            color: whiteColor,
            size: 28,
          ),
        );
      },
    );
  }

  chooseUpload(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text('Share thought',
                      textAlign: TextAlign.center,
                      style: kBodyTextSubtitleStyle()
                          .copyWith(color: primaryColor)),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.camera_on_rectangle,
                  size: 25.0,
                ),
                title: const Text('Make a post'),
                onTap: () {
                  Get.to(() => const CreatePost());
                  // Navigator.pop(context);
                  // Navigator.of(context).push(
                  //   CupertinoPageRoute(
                  //     builder: (_) => CreatePost(),
                  //   ),
                  // );
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     CupertinoIcons.camera_on_rectangle,
              //     size: 25.0,
              //   ),
              //   title: const Text('Add to story'),
              //   onTap: () async {
              //     // await viewModel.pickImage(context: context);
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}
