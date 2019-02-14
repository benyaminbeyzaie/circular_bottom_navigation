library circular_bottom_navigation;

import 'package:flutter/material.dart';

class CircularBottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CircularBottomNavigation();
}

class _CircularBottomNavigation extends State<CircularBottomNavigation>
    with TickerProviderStateMixin {
  Curve _animationsCurve = Cubic(0.27, 1.21, .77, 1.09);

  AnimationController itemsController;
  Animation<double> selectedPosAnimation;
  Animation<double> itemsAnimation;

  int selectedPos = 0;
  int previousSelectedPos = 0;

  double barHeight = 60;
  double circleSize = 48;
  double circleStrokeWidth = 2;
  double iconsSize = 32;

  List<String> items = List.of(["Home", "Search", "Reports", "Notification"]);
  List<double> itemsSelectedState = List.of([1.0, 0.0, 0.0, 0.0]);

  @override
  void initState() {
    super.initState();
    itemsController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    itemsController.addListener(() {
      setState(() {
        itemsSelectedState.asMap().forEach((i, value) {
          if (i == previousSelectedPos) {
            itemsSelectedState[previousSelectedPos] =
                1.0 - itemsAnimation.value;
          } else if (i == selectedPos) {
            itemsSelectedState[selectedPos] = itemsAnimation.value;
          } else {
            itemsSelectedState[i] = 0.0;
          }
        });
      });
    });

    selectedPosAnimation = makeSelectedPosAnimation(
        selectedPos.toDouble(), selectedPos.toDouble());

    itemsAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: itemsController, curve: _animationsCurve));
  }

  Animation<double> makeSelectedPosAnimation(double begin, double end) {
    return Tween(begin: begin, end: end)
        .animate(CurvedAnimation(parent: itemsController, curve: _animationsCurve));
  }

  void onSelectedPosAnimate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double full_width = MediaQuery.of(context).size.width;
    double full_height =
        this.barHeight + (this.circleSize / 2) + this.circleStrokeWidth;
    double section_width = full_width / this.items.length;

    //Create the boxes Rect
    List<Rect> boxes = List();
    items.asMap().forEach((i, rect) {
      double left = i * section_width;
      double top = full_height - this.barHeight;
      double right = left + section_width;
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
      left: (selectedPosAnimation.value * section_width) +
          (section_width / 2) -
          (circleSize / 2),
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
      double opacity = itemsSelectedState[pos];
      if (opacity < 0.0) {
        opacity = 0.0;
      } else if (opacity > 1.0) {
        opacity = 1.0;
      }
      children.add(Positioned(
        child: Container(
          width: r.width,
          height: textHeight,
          child: Center(
              child: Opacity(
            opacity: opacity,
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
              previousSelectedPos = selectedPos;
              selectedPos = pos;

              itemsController.forward(from: 0.0);

              selectedPosAnimation = makeSelectedPosAnimation(
                  previousSelectedPos.toDouble(), selectedPos.toDouble());
              selectedPosAnimation.addListener(onSelectedPosAnimate);
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

  @override
  void dispose() {
    super.dispose();
    itemsController.dispose();
  }
}
