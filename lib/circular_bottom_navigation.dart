library circular_bottom_navigation;

import 'package:flutter/material.dart';

class CircularBottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CircularBottomNavigation();
}

class _CircularBottomNavigation extends State<CircularBottomNavigation> {
  int selectedPos = 0;
  double barHeight = 60;
  double circleSize = 40;
  double circleStrokeWidth = 2;
  List<String> items = List.of(["Home", "Search", "Reports", "Notification"]);

  @override
  Widget build(BuildContext context) {
    double full_width = MediaQuery.of(context).size.width;
    double full_height = this.barHeight + (this.circleSize / 2) + this.circleStrokeWidth;

    List<Rect> boxes = List();
    items.asMap().forEach((i, rect) {
      double left = i * (full_width / this.items.length);
      double top = full_height - this.barHeight;
      double right = full_width / this.items.length;
      double bottom = full_height;
      boxes.add(Rect.fromLTRB(left, top, right, bottom));
    });

    List<Widget> children = List();
    children.add(Container(
      color: Colors.blueGrey,
      width: full_width,
      height: full_height,
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
      left: (boxes[selectedPos].width - circleSize) / 2,
      top: 0,
    ));
    boxes.forEach((Rect r) {
      children.add(
        Positioned.fromRect(
          child: Container(
            color: Colors.red,
            child: Center(
              child: Icon(Icons.home),
            ),
          ),
          rect: r,
        ),
      );
    });

    return new Stack(
      children: children,
    );
  }
}