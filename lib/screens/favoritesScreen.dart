import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:visar/models/models.dart';
import 'package:visar/screens/productScreen.dart';
import 'package:visar/widgets/cost.dart';
import 'package:visar/widgets/indexedText.dart';

import '../colors.dart';

class FavoritesScreen extends StatefulWidget {
  final Function parentAction;
  FavoritesScreen({this.parentAction});
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

double favoriteOpacity = 1.0;

class _FavoritesScreenState extends State<FavoritesScreen> {
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
    return favorites.isNotEmpty
        ? ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
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
                      favorites.remove(favorites.removeAt(index));
                    });
                    _showFlushBar(context);
                    setState(() {
                      Future.delayed(Duration(milliseconds: 300), () {
                        setState(() {
                          if (favorites.isEmpty) {
                            favoriteOpacity = 1;
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
                          product: favorites[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 15, top: 10),
                          child: Image(
                            image: AssetImage(favorites[index].typeImage),
                            height: 150,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                favorites[index].laptopName,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                favorites[index].subtitle,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black26,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Cost(
                                    cost: favorites[index].cost *
                                        favorites[index].amount,
                                    fontSize: 24,
                                    color: blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: favorites[index].exists
                                        ? Colors.green
                                        : Colors.yellow,
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
          )
        : AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: favoriteOpacity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    child: Stack(
                      children: [
                        Icon(
                          Icons.bookmarks_outlined,
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
                    "Сохраняйте товары и всегда имейте к ним доступ!",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IndexedText(
                    text: "сохранить товары",
                    bgColor: blue,
                    fontColor: white,
                    fontSize: 24,
                    width: 250,
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
