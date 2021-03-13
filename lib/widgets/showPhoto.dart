import 'package:flutter/material.dart';
import 'package:visar/models/models.dart';

import '../colors.dart';

class ShowPhoto extends StatefulWidget {
  final Products product;
  ShowPhoto({this.product});
  @override
  _ShowPhotoState createState() => _ShowPhotoState();
}

class _ShowPhotoState extends State<ShowPhoto> {
  int _selectedPhoto = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.product.imageUrl,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.product.imageUrl.length,
              onPageChanged: (int index) {
                setState(() {
                  _selectedPhoto = index;
                });
              },
              itemBuilder: (BuildContext context, int index) => Container(
                color: Colors.transparent,
                child: Image(
                  image: AssetImage(widget.product.imageUrl[index]),
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
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
                      color: _selectedPhoto == index ? blue : white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black26,
                        )
                      ]),
                ),
              ),
            ),
          ),
          Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.clear_outlined,
                        size: 30,
                        color: white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
