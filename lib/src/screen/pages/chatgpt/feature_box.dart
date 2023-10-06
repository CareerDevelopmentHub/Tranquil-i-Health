import 'package:flutter/material.dart';

import 'package:healthhero/src/theme/app_color.dart';

class CustomBox extends StatelessWidget {
  final Color color;
  final Color? Hcolor;
  final Color? Dcolor;
  final String headerText;
  final String descriptionText;
  const CustomBox({
    Key? key,
    required this.color,
    this.Hcolor,
    this.Dcolor,
    required this.headerText,
    required this.descriptionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: TextStyle(
                  color: Hcolor ?? primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  descriptionText,
                  style: TextStyle(
                    color: Dcolor ?? primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
