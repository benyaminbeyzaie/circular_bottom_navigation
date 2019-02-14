library circular_bottom_navigation;

import 'package:flutter/material.dart';

class CircularBottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CircularBottomNavigation();
}

class _CircularBottomNavigation extends State<CircularBottomNavigation> {
  int selectedPos = 0;
  double barHeight = 60;
  double circleSize = 48;
  double circleStrokeWidth = 2;
  double iconsSize = 32;

  List<String> items = List.of(["Home", "Search", "Reports", "Notification"]);
  List<double> itemsSelectedState = List.of([1.0, 0.0, 0.0, 0.0]);
  @override
  Widget build(BuildContext context) {
    double full_width = MediaQuery.of(context).size.width;
    double full_height =
        this.barHeight + (this.circleSize / 2) + this.circleStrokeWidth;

    List<Rect> boxes = List();
    items.asMap().forEach((i, rect) {
      double left = i * (full_width / this.items.length);
      double top = full_height - this.barHeight;
      double right = left + (full_width / this.items.length);
      double bottom = full_height;
      boxes.add(Rect.fromLTRB(left, top, right, bottom));
    });

    List<Widget> children = List();
    children.add(Container(
      width: full_width,
      height: full_height,
    ));
    children.add(Positioned(
      child: Container(
        color: Colors.pink,
        width: full_width,
        height: barHeight,
      ),
      top: full_height - barHeight,
      left: 0,
    ));
    children.add(new Positioned(
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
            border: Border.all(width: circleStrokeWidth, color: Colors.white)),
      ),
      left: boxes[selectedPos].center.dx - (circleSize / 2),
      top: 0,
    ));
    boxes.asMap().forEach((int pos, Rect r) {
      children.add(
        Positioned(
          child: Icon(
            Icons.home,
            size: iconsSize,
          ),
          left: r.center.dx - (iconsSize / 2),
          top: r.center.dy - (iconsSize / 2) - (itemsSelectedState[pos] *(barHeight / 2)),
        ),
      );
    });

    return new Stack(
      children: children,
    );
  }
}
