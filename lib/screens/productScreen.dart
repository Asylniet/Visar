import 'package:flutter/material.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:visar/models/models.dart';
import 'package:visar/screens/favoritesScreen.dart';
import 'package:visar/widgets/cost.dart';
import 'package:visar/widgets/defaultIcon.dart';
import 'package:visar/widgets/draggableSheet.dart';
import 'package:visar/widgets/favourite.dart';
import 'package:visar/widgets/showPhoto.dart';
import '../colors.dart';
import 'arScreen.dart';
import 'homeScreen.dart';

class ProductScreen extends StatefulWidget {
  final Products product;
  ProductScreen({this.product});
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  var squareScaleA = 1.0;
  AnimationController _controllerA;

  @override
  void initState() {
    _controllerA = AnimationController(
        vsync: this,
        lowerBound: 0.96,
        value: 1.0,
        duration: Duration(milliseconds: 200));
    _controllerA.addListener(() {
      setState(() {
        squareScaleA = _controllerA.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllerA.dispose();
    super.dispose();
  }

  double scale = 1;
  int _selectedPhoto = 0;
  @override
  Widget build(BuildContext context) {
    void _showSheet(BuildContext context) {
      _controllerA.reverse();
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true, // set this to true
        builder: (_) {
          return DraggableScrollableSheet(
            initialChildSize: 0.63,
            expand: false,
            builder: (_, controller) {
              return DraggableSheet(
                product: widget.product,
              );
            },
          );
        },
      ).whenComplete(() {
        setState(() {
          _controllerA.forward();
          position = 0;
          widget.product.selectedColor = 0;
          widget.product.amount = 1;
        });
      });
    }

    void _viewPhoto() {
      Navigator.push(
        context,
        PageTransition(
          child: ShowPhoto(
            product: widget.product,
          ),
          type: PageTransitionType.bottomToTop,
        ),
      );
    }

    final cost = widget.product.cost;

    return Scaffold(
      backgroundColor: Colors.black26,
      bottomNavigationBar: Container(
        color: white,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DefaultIcon(
              width: 165,
              height: 65,
              icon: Icons.threed_rotation,
              iconSize: 35,
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ARScreen()),
                );
              },
            ),
            DefaultIcon(
              width: 165,
              height: 65,
              icon: Icons.shopping_cart,
              bgColor: blue,
              color: white,
              iconSize: 35,
              function: () {
                _showSheet(context);
              },
            )
          ],
        ),
      ),
      body: Transform.scale(
        scale: squareScaleA,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: white,
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(50),
            //   topRight: Radius.circular(50),
            // ),
          ),
          child: GestureDetector(
            onLongPress: () {
              Navigator.pop(context);
            },
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 290,
                          child: GestureDetector(
                            onTap: _viewPhoto,
                            child: Hero(
                              tag: widget.product.imageUrl,
                              child: PageView.builder(
                                onPageChanged: (int index) {
                                  setState(() {
                                    _selectedPhoto = index;
                                  });
                                },
                                itemCount: widget.product.imageUrl.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                  child: Image(
                                    image: AssetImage(
                                        widget.product.imageUrl[index]),
                                    height: 290,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultIcon(
                                icon: Icons.arrow_back,
                                function: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Favourite(
                                icon: favorites.contains(widget.product)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                function: () {
                                  setState(() {
                                    if (favorites.contains(widget.product)) {
                                      favorites.removeWhere((element) =>
                                          element.laptopName ==
                                          widget.product.laptopName);
                                      if (favorites.isEmpty == true) {
                                        setState(() {
                                          dotOpacitis[2] = 0;
                                          favoriteOpacity = 1;
                                        });
                                      }
                                    } else {
                                      favorites.add(widget.product);
                                      setState(() {
                                        dotOpacitis[2] = 1;
                                        favoriteOpacity = 0;
                                      });
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(
                              widget.product.imageUrl.length,
                              (index) => AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOutCirc,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: _selectedPhoto == index ? 26 : 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _selectedPhoto == index ? 10 : 8),
                                    color:
                                        _selectedPhoto == index ? blue : white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black26,
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.laptopName,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: ExpandText(
                        widget.product.subtitle,
                        overflow: TextOverflow.ellipsis,
                        expandOnGesture: false,
                        maxLines: 7,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    Cost(
                      cost: cost,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: widget.product.exists == true
                                ? Colors.green
                                : Colors.yellow,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.product.exists == true
                                ? 'есть в наличии'
                                : 'нет в наличии',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Окрас устройства',
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 25,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
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
                                margin: EdgeInsets.all(10),
                                width: 40,
                                height: widget.product.selectedColor == index
                                    ? 50
                                    : 40,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
