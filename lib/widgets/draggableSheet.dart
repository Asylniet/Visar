import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:visar/models/models.dart';
import 'package:visar/screens/purchasesScreen.dart';
import 'package:visar/widgets/indexedText.dart';
import 'package:visar/screens/homeScreen.dart';
import 'dart:async';

import '../colors.dart';
import 'cost.dart';

double position = 0;

class DraggableSheet extends StatefulWidget {
  var product;
  DraggableSheet({this.product});
  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  Flushbar flush;
  void _showFlushBar(BuildContext context) {
    flush = Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 10),
      duration: Duration(seconds: 3),
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      borderRadius: 20,
      backgroundColor: white,
      boxShadows: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black26,
        )
      ],
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      messageText: Text(
        "Добавлено в корзину",
        style: TextStyle(
          color: blue,
          fontSize: 20,
        ),
      ),
      mainButton: IndexedText(
        text: "отменить",
        fontColor: white,
        bgColor: blue,
        width: 120,
        height: 50,
        fontSize: 20,
        function: () {
          purchases.removeLast();
          flush.dismiss();
        },
      ),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    int amount = widget.product.amount;
    final int cost = widget.product.cost * widget.product.amount;

    var productsBuy = Products(
      laptopName: widget.product.laptopName,
      cost: widget.product.cost,
      isLiked: widget.product.isLiked,
      colors: widget.product.colors,
      selectedColor: widget.product.selectedColor,
      amount: widget.product.amount,
      typeImage: widget.product.typeImage,
      imageUrl: widget.product.imageUrl,
      exists: widget.product.exists,
      subtitle: widget.product.subtitle,
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
            )
          ]),
      child: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    height: 2,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Colors.black26,
                    ),
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Image.asset(
                        widget.product.typeImage,
                        height: 179,
                      ),
                      AnimatedPositioned(
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 300),
                        bottom: 1,
                        left: position,
                        child: Image.asset(
                          widget.product.typeImage,
                          height: 179,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: widget.product.amount == 1 ? 0.5 : 1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (widget.product.amount > 1) {
                                widget.product.amount--;
                              }
                              if (widget.product.amount < 2) {
                                position = 0;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 28,
                            color: blue,
                          ),
                        ),
                      ),
                      Text(
                        ' $amount ',
                        style: TextStyle(
                          fontSize: 35,
                          color: blue,
                        ),
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: widget.product.amount == 10 ? 0.5 : 1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (widget.product.amount < 10) {
                                widget.product.amount++;
                              }
                              if (widget.product.amount > 1) {
                                position = 40;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            size: 28,
                            color: blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                left: 10,
                top: 70,
                child: Container(
                  width: 60,
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.product.colors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.product.selectedColor = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.ease,
                            margin: EdgeInsets.all(10),
                            height:
                                widget.product.selectedColor == index ? 50 : 40,
                            width: 40,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black26,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25),
                              color: widget.product.colors[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Cost(
            cost: cost,
          ),
          SizedBox(
            height: 10,
          ),
          IndexedText(
            text: "Купить сейчас",
            bgColor: blue,
            fontColor: white,
          ),
          IndexedText(
            text: "Отправить в корзину",
            function: () {
              purchases.add(productsBuy);
              Navigator.pop(context);
              _showFlushBar(context);
              setState(() {
                opacity = 0;
                dotOpacitis[1] = 1;
                Timer(Duration(milliseconds: 300), () {
                  widget.product.selectedColor = 0;
                  widget.product.amount = 1;
                  position = 0;
                });
              });
            },
          ),
        ],
      ),
    );
  }
}
