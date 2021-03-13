import 'package:flutter/material.dart';
import 'package:visar/colors.dart';

class Favourite extends StatefulWidget {
  final IconData icon;
  final function;
  final Color color;
  final Color bgColor;
  final double width;
  final double height;
  final double iconSize;
  Favourite({
    this.icon,
    this.function,
    this.color = blue,
    this.bgColor = white,
    this.height = 45,
    this.width = 45,
    this.iconSize = 30,
  });

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(
          milliseconds: 250), // how long should the animation take to finish
      lowerBound: 0.6,
      value: 0.6,
      upperBound: 1,
    );
    animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCirc);
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      },
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void control() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: widget.bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Center(
        child: ScaleTransition(
          scale: animation,
          child: IconButton(
            onPressed: () {
              _controller.forward();
              widget.function();
            },
            icon: Icon(
              widget.icon,
              color: widget.color,
              size: widget.iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
