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

    //Create the boxes Rect
    List<Rect> boxes = List();
    items.asMap().forEach((i, rect) {
      double left = i * (full_width / this.items.length);
      double top = full_height - this.barHeight;
      double right = left + (full_width / this.items.length);
      double bottom = full_height;
      boxes.add(Rect.fromLTRB(left, top, right, bottom));
    });

    List<Widget> children = List();

    // This is the full view transparent background (have free space for circle)
    children.add(Container(
      width: full_width,
      height: full_height,
    ));

    // This is the bar background (bottom section of our view)
    children.add(Positioned(
      child: Container(
        color: Colors.pink,
        width: full_width,
        height: barHeight,
      ),
      top: full_height - barHeight,
      left: 0,
    ));

    // This is the circle handle
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

    //Here are the Icons and texts of items
    boxes.asMap().forEach((int pos, Rect r) {
      // Icon
      children.add(
        Positioned(
          child: Icon(
            Icons.home,
            size: iconsSize,
          ),
          left: r.center.dx - (iconsSize / 2),
          top: r.center.dy -
              (iconsSize / 2) -
              (itemsSelectedState[pos] * (barHeight / 2)),
        ),
      );

      // Text
      double textHeight = full_height - circleSize;
      children.add(Positioned(
        child: Container(
          width: r.width,
          height: textHeight,
          child: Center(
              child: Opacity(
            opacity: itemsSelectedState[pos],
            child: Text(
              "Item $pos",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )),
        ),
        left: r.left,
        top: r.top +
            (circleSize / 2) -
            (circleStrokeWidth * 2) +
            ((1.0 - itemsSelectedState[pos]) * textHeight),
      ));

      if (pos != selectedPos) {
        children.add(Positioned.fromRect(
          child: GestureDetector(
            onTap: () {
              print("Tapped on $pos");
              setState(() {
                selectedPos = pos;
                itemsSelectedState.asMap().forEach((i, value) {
                  if (i == selectedPos) {
                    itemsSelectedState[i] = 1.0;
                  } else {
                    itemsSelectedState[i] = 0.0;
                  }
                });
              });
            },
          ),
          rect: r,
        ));
      }
    });

    return Stack(
      children: children,
    );
  }
}
