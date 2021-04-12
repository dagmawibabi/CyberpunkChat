import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';

class PageTransitionProgressDots extends StatelessWidget {
  const PageTransitionProgressDots({
    Key? key,
    required this.activeIndex,
    required this.activeColor,
    required this.activePaintingStyle,
    required this.inactiveColor,
    required this.inactivePaintingStyle,
  }) : super(key: key);
  final int activeIndex;
  final Color activeColor;
  final PaintingStyle activePaintingStyle;
  final Color inactiveColor;
  final PaintingStyle inactivePaintingStyle;

  @override
  Widget build(BuildContext context) {
    final double activeDotWidth = 20.0;
    final double activeDotHeight = 10.0;
    final double inactiveDotWidth = 14.0;
    final double inactiveDotHeight = 10.0;
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30.0),
          // Dot 1
          Stack(
            children: [
              CustomPaint(
                painter: DentContainer(
                  activeIndex == 1 ? activeDotWidth : inactiveDotWidth,
                  activeIndex == 1 ? activeDotHeight : inactiveDotHeight,
                  5.0,
                  2.0,
                  activeIndex == 1 ? activeColor : inactiveColor,
                  activeIndex == 1
                      ? activePaintingStyle
                      : inactivePaintingStyle,
                ),
              ),
            ],
          ),
          activeIndex == 1 ? SizedBox(width: 30.0) : SizedBox(width: 20.0),
          // Dot 2
          Stack(
            children: [
              CustomPaint(
                painter: DentContainer(
                  activeIndex == 2 ? activeDotWidth : inactiveDotWidth,
                  activeIndex == 2 ? activeDotHeight : inactiveDotHeight,
                  5.0,
                  2.0,
                  activeIndex == 2 ? activeColor : inactiveColor,
                  activeIndex == 2
                      ? activePaintingStyle
                      : inactivePaintingStyle,
                ),
              ),
            ],
          ),
          activeIndex == 2 ? SizedBox(width: 30.0) : SizedBox(width: 20.0),
          // Dot 3
          Stack(
            children: [
              CustomPaint(
                painter: DentContainer(
                  activeIndex == 3 ? activeDotWidth : inactiveDotWidth,
                  activeIndex == 3 ? activeDotHeight : inactiveDotHeight,
                  5.0,
                  2.0,
                  activeIndex == 3 ? activeColor : inactiveColor,
                  activeIndex == 3
                      ? activePaintingStyle
                      : inactivePaintingStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
