import 'package:flutter/material.dart';

import 'package:healthhero/src/theme/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.actions,
    this.leading,
    this.showLead = false,
    this.centerTitle = true,
    this.backgroundColor,
    this.preferredSize = const Size.fromHeight(57),
  }) : super(key: key);
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? showLead;
  final bool? centerTitle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      actions: actions,
      title: Text('', style: kBodyTextTitleStyle()),
      centerTitle: centerTitle,
      automaticallyImplyLeading: showLead ?? false,
      backgroundColor: whiteColor,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  final Size preferredSize;
}
