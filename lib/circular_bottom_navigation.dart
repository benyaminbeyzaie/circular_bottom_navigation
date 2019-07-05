library circular_bottom_navigation;

import 'dart:core';

import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';

typedef CircularBottomNavSelectedCallback = Function(int selectedPos);

class CircularBottomNavigation extends StatefulWidget {
  final List<TabItem> tabItems;
  final int selectedPos;
  final double barHeight;
  final Color barBackgroundColor;
  final double circleSize;
  final double circleStrokeWidth;
  final double iconsSize;
  final Color selectedIconColor;
  final Color normalIconColor;
  final TextStyle labelStyle;
  final Duration animationDuration;
  final CircularBottomNavSelectedCallback selectedCallback;
  final CircularBottomNavigationController controller;

  CircularBottomNavigation(this.tabItems,
      {this.selectedPos = 0,
      this.barHeight = 60,
      this.barBackgroundColor = Colors.white,
      this.circleSize = 58,
      this.circleStrokeWidth = 4,
      this.iconsSize = 32,
      this.selectedIconColor = Colors.white,
      this.normalIconColor = Colors.grey,
      this.labelStyle,
      this.animationDuration = const Duration(milliseconds: 300),
      this.selectedCallback,
      this.controller})
      : assert(
            tabItems != null && tabItems.length != 0, "tabItems is required");

  @override
  State<StatefulWidget> createState() => _CircularBottomNavigationState();
}

class _CircularBottomNavigationState extends State<CircularBottomNavigation>
    with TickerProviderStateMixin {
  Curve _animationsCurve = Cubic(0.27, 1.21, .77, 1.09);

  AnimationController itemsController;
  Animation<double> selectedPosAnimation;
  Animation<double> itemsAnimation;

  List<double> _itemsSelectedState;

  int selectedPos;
  int previousSelectedPos;

  CircularBottomNavigationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller;
      previousSelectedPos = selectedPos = _controller.value;
    } else {
      previousSelectedPos = selectedPos = widget.selectedPos;
      _controller = CircularBottomNavigationController(selectedPos);
    }

    _controller.addListener(_newSelectedPosNotify);

    _itemsSelectedState = List.generate(widget.tabItems.length, (index) {
      return selectedPos == index ? 1.0 : 0.0;
    });

    itemsController = new AnimationController(
        vsync: this, duration: widget.animationDuration);
    itemsController.addListener(() {
      setState(() {
        _itemsSelectedState.asMap().forEach((i, value) {
          if (i == previousSelectedPos) {
            _itemsSelectedState[previousSelectedPos] =
                1.0 - itemsAnimation.value;
          } else if (i == selectedPos) {
            _itemsSelectedState[selectedPos] = itemsAnimation.value;
          } else {
            _itemsSelectedState[i] = 0.0;
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
    return Tween(begin: begin, end: end).animate(
        CurvedAnimation(parent: itemsController, curve: _animationsCurve));
  }

  void onSelectedPosAnimate() {
    setState(() {});
  }

  void _newSelectedPosNotify() {
    _setSelectedPos(widget.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight =
        widget.barHeight + (widget.circleSize / 2) + widget.circleStrokeWidth;
    double sectionsWidth = fullWidth / widget.tabItems.length;

    //Create the boxes Rect
    List<Rect> boxes = List();
    widget.tabItems.asMap().forEach((i, tabItem) {
      double left = i * sectionsWidth;
      double top = fullHeight - widget.barHeight;
      double right = left + sectionsWidth;
      double bottom = fullHeight;
      boxes.add(Rect.fromLTRB(left, top, right, bottom));
    });

    List<Widget> children = List();

    // This is the full view transparent background (have free space for circle)
    children.add(Container(
      width: fullWidth,
      height: fullHeight,
    ));

    // This is the bar background (bottom section of our view)
    children.add(Positioned(
      child: Container(
        width: fullWidth,
        height: widget.barHeight,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: widget.barBackgroundColor,
            boxShadow: [new BoxShadow(color: Colors.grey, blurRadius: 2.0)]),
      ),
      top: fullHeight - widget.barHeight,
      left: 0,
    ));

    // This is the circle handle
    children.add(new Positioned(
      child: Container(
        width: widget.circleSize,
        height: widget.circleSize,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.tabItems[selectedPos].color,
            border: Border.all(
                width: widget.circleStrokeWidth,
                color: widget.barBackgroundColor)),
      ),
      left: (selectedPosAnimation.value * sectionsWidth) +
          (sectionsWidth / 2) -
          (widget.circleSize / 2),
      top: 0,
    ));

    //Here are the Icons and texts of items
    boxes.asMap().forEach((int pos, Rect r) {
      // Icon
      Color iconColor = pos == selectedPos
          ? widget.selectedIconColor
          : widget.normalIconColor;
      double scaleFactor = pos == selectedPos ? 1.2 : 1.0;
      children.add(
        Positioned(
          child: Transform.scale(
            scale: scaleFactor,
            child: Icon(
              widget.tabItems[pos].icon,
              size: widget.iconsSize,
              color: iconColor,
            ),
          ),
          left: r.center.dx - (widget.iconsSize / 2),
          top: r.center.dy -
              (widget.iconsSize / 2) -
              (_itemsSelectedState[pos] *
                  ((widget.barHeight / 2) + widget.circleStrokeWidth)),
        ),
      );

      // Text
      double textHeight = fullHeight - widget.circleSize;
      double opacity = _itemsSelectedState[pos];
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
              widget.tabItems[pos].title,
              textAlign: TextAlign.center,
              style: widget.labelStyle
                      .copyWith(color: widget.tabItems[pos].color) ??
                  TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.tabItems[pos].color),
            ),
          )),
        ),
        left: r.left,
        top: r.top +
            (widget.circleSize / 2) -
            (widget.circleStrokeWidth * 2) +
            ((1.0 - _itemsSelectedState[pos]) * textHeight),
      ));

      if (pos != selectedPos) {
        children.add(Positioned.fromRect(
          child: GestureDetector(
            onTap: () {
              _controller.value = pos;
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

  void _setSelectedPos(int pos) {
    previousSelectedPos = selectedPos;
    selectedPos = pos;

    itemsController.forward(from: 0.0);

    selectedPosAnimation = makeSelectedPosAnimation(
        previousSelectedPos.toDouble(), selectedPos.toDouble());
    selectedPosAnimation.addListener(onSelectedPosAnimate);

    if (widget.selectedCallback != null) {
      widget.selectedCallback(selectedPos);
    }
  }

  @override
  void dispose() {
    super.dispose();
    itemsController.dispose();
    _controller.removeListener(_newSelectedPosNotify);
  }
}

class CircularBottomNavigationController extends ValueNotifier<int> {
  CircularBottomNavigationController(int value) : super(value);
}
