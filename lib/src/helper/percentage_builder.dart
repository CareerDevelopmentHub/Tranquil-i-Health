import 'package:flutter/material.dart';

class PercentageContainer extends StatelessWidget {
  final double percentage;
  final Color color;

  const PercentageContainer(
      {super.key, required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 300,
      color:
          const Color(0xffc4c4c4), // Default color if no percentage is provided
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final filledWidth = constraints.maxHeight * (percentage / 300);
          return Stack(
            children: [
              Container(
                height: filledWidth,
                width: 80,
                color: color,
              ),
            ],
          );
        },
      ),
    );
  }
}
