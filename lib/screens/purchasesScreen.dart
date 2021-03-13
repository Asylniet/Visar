import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:visar/models/models.dart';
import 'package:visar/screens/productScreen.dart';
import 'package:visar/widgets/cost.dart';
import 'package:visar/widgets/indexedText.dart';

import '../colors.dart';

class PurchasesScreen extends StatefulWidget {
  final Function parentAction;
  PurchasesScreen({this.parentAction});
  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

double opacity = 1.0;

class _PurchasesScreenState extends State<PurchasesScreen> {
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
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      messageText: Center(
        child: Text(
          "Удалено",
          style: TextStyle(
            color: blue,
            fontSize: 20,
          ),
        ),
      ),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    List<int> costs = List();
    purchases.forEach((element) {
      costs.add(element.cost * element.amount);
    });

    int sum = costs.fold(0, (p, c) => p + c);
    return purchases.isNotEmpty
        ? Stack(
            children: [
              Container(
                // margin: EdgeInsets.only(bottom: 110.0),
                child: ListView.builder(
                  itemCount: purchases.length,
                  itemBuilder: (BuildContext context, int index) {
                    int selectedColor = purchases[index].selectedColor;
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        height: 150,
                        color: white,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 90,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black26,
                                    )
                                  ]),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.card_travel,
                                    color: blue,
                                  ),
                                  onPressed: () {}),
                            ),
                            Container(
                              height: 90,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black26,
                                    )
                                  ]),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {}),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            purchases.remove(purchases.removeAt(index));
                          });
                          _showFlushBar(context);
                          setState(() {
                            Future.delayed(Duration(milliseconds: 300), () {
                              setState(() {
                                if (purchases.isEmpty) {
                                  opacity = 1;
                                }
                              });
                            });
                          });
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                product: purchases[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black26,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 15),
                                child: Image(
                                  image: AssetImage(purchases[index].typeImage),
                                  width: 150,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          purchases[index].laptopName,
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.place,
                                              color: Colors.black26,
                                            ),
                                            Text(
                                              "доставка",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black26,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Cost(
                                      cost: purchases[index].cost *
                                          purchases[index].amount,
                                      fontSize: 24,
                                      color: blue,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          transform: Matrix4.translationValues(
                                              -10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AnimatedOpacity(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                opacity:
                                                    purchases[index].amount == 1
                                                        ? 0.5
                                                        : 1,
                                                child: IconButton(
                                                  padding: EdgeInsets.all(0),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (purchases[index]
                                                              .amount >
                                                          1) {
                                                        purchases[index]
                                                            .amount--;
                                                      }
                                                      if (purchases[index]
                                                              .amount <
                                                          2) {}
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.remove,
                                                    size: 24,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                purchases[index]
                                                    .amount
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              AnimatedOpacity(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                opacity:
                                                    purchases[index].amount ==
                                                            10
                                                        ? 0.5
                                                        : 1,
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (purchases[index]
                                                              .amount <
                                                          10) {
                                                        purchases[index]
                                                            .amount++;
                                                      }
                                                      if (purchases[index]
                                                              .amount >
                                                          1) {}
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.add,
                                                    size: 24,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: purchases[index]
                                                  .colors[selectedColor],
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 10,
                                                  color: Colors.black26,
                                                )
                                              ]),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black26,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Cost(
                        cost: sum,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: blue,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: blue.withOpacity(0.5),
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        : AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: opacity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    child: Stack(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 50,
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: blue,
                              border: Border.all(color: white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                "0",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Собирайте товары в корзину, а затем купите из разом!",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IndexedText(
                    text: "попробовать",
                    bgColor: blue,
                    fontColor: white,
                    fontSize: 24,
                    width: 180,
                    height: 50,
                    function: () {
                      widget.parentAction(0);
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
