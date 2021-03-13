import 'package:flutter/material.dart';

import '../colors.dart';

class CustomAnimatedIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double iconSize;

  CustomAnimatedIcon({
    this.color = blue,
    this.icon = Icons.ac_unit,
    this.iconSize = 30,
    Key key,
  }) : super(key: key);

  @override
  CustomAnimatedIconState createState() => CustomAnimatedIconState();
}

class CustomAnimatedIconState extends State<CustomAnimatedIcon>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(
          milliseconds: 250), // how long should the animation take to finish
      value: 0.6,
      upperBound: 1,
      lowerBound: 0.6,
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCirc);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: Icon(
        widget.icon,
        color: widget.color,
        size: widget.iconSize,
      ),
    );
  }
}
