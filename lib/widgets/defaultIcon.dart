import 'package:flutter/material.dart';
import 'package:visar/colors.dart';

class DefaultIcon extends StatefulWidget {
  final IconData icon;
  final Function function;
  final Color color;
  final Color bgColor;
  final double width;
  final double height;
  final double iconSize;
  final double margin;
  final Color boxShadowColor;
  DefaultIcon({
    this.icon,
    this.function,
    this.color = blue,
    this.bgColor = white,
    this.height = 45,
    this.width = 45,
    this.iconSize,
    this.margin = 8,
    this.boxShadowColor = Colors.black26,
  });

  @override
  _DefaultIconState createState() => _DefaultIconState();
}

class _DefaultIconState extends State<DefaultIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    animation = ColorTween(
      begin: Colors.grey,
      end: Colors.blue,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: widget.margin, vertical: 10),
      decoration: BoxDecoration(
        color: widget.bgColor,
        boxShadow: [
          BoxShadow(
            color: widget.boxShadowColor,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: IconButton(
        onPressed: widget.function,
        icon: Icon(
          widget.icon,
          color: widget.color,
          size: widget.iconSize,
        ),
      ),
    );
  }
}
