import 'package:flutter/material.dart';
import 'package:healthhero/src/model/group_model.dart';
import 'package:healthhero/src/theme/app_color.dart';

class GroupDesignView extends StatelessWidget {
  const GroupDesignView({
    Key? key,
    required this.model,
  }) : super(key: key);
  final GroupModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: whiteColor,
          child: CircleAvatar(
              radius: 42,
              backgroundColor: lightGreenColor.withOpacity(0.5),
              backgroundImage: NetworkImage(model.url ??
                  'https://img.freepik.com/free-vector/human-internal-organ-with-intestine_1308-109110.jpg?w=740&t=st=1679403211~exp=1679403811~hmac=3a055bbee1995cc48cc35aa811e149ce7347a3b421b0b6a261cb5cabfa74c4d8')),
        ),
        const SizedBox(height: 8),
        Text(
          '${model.title}',
          style: kBodyTextBodyMediumStyle(),
        ),
      ],
    );
  }
}
