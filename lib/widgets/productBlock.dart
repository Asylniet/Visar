import 'package:flutter/material.dart';
import 'package:visar/screens/favoritesScreen.dart';
import 'package:visar/screens/productScreen.dart';
import 'package:visar/colors.dart';
import 'package:visar/widgets/favourite.dart';
import 'package:visar/models/models.dart';

import 'cost.dart';

class ProductBlock extends StatefulWidget {
  final List lists;
  final Function parentAction;
  ProductBlock({this.lists, this.parentAction});
  @override
  _ProductBlockState createState() => _ProductBlockState();
}

class _ProductBlockState extends State<ProductBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      child: ListView.builder(
        padding: EdgeInsets.all(25),
        scrollDirection: Axis.horizontal,
        itemCount: widget.lists.length,
        itemBuilder: (BuildContext context, int index) {
          final int cost = widget.lists[index].cost;
          _navigateAndDisplayProductScreen(BuildContext context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(
                  product: widget.lists[index],
                ),
              ),
            );
          }

          return Container(
            height: 335,
            width: 220,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black26,
                  )
                ]),
            child: GestureDetector(
              onTap: () => _navigateAndDisplayProductScreen(context),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: widget.lists[index].imageUrl,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage(widget.lists[index].imageUrl[0]),
                            width: 220,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        child: Favourite(
                          icon: favorites.contains(widget.lists[index])
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          function: () {
                            widget.parentAction(1.0);
                            setState(() {
                              if (favorites.contains(widget.lists[index])) {
                                favorites.removeWhere((element) =>
                                    element.laptopName ==
                                    widget.lists[index].laptopName);
                                if (favorites.isEmpty == true) {
                                  widget.parentAction(0.0);
                                  favoriteOpacity = 1;
                                }
                              } else {
                                favoriteOpacity = 0;
                                favorites.add(widget.lists[index]);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.lists[index].laptopName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 205,
                    height: 50,
                    child: Text(
                      widget.lists[index].subtitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Cost(
                        cost: cost,
                        color: blue,
                        fontSize: 20,
                      ),
                      Tooltip(
                        message: widget.lists[index].exists == true
                            ? 'есть в наличии'
                            : 'нет в наличии',
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: widget.lists[index].exists == true
                                ? Colors.green
                                : Colors.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
