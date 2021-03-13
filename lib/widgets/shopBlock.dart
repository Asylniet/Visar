import 'package:flutter/material.dart';
import 'package:visar/colors.dart';
import 'package:visar/models/models.dart';

class ShopBlock extends StatefulWidget {
  @override
  _ShopBlockState createState() => _ShopBlockState();
}

class _ShopBlockState extends State<ShopBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      child: ListView.builder(
        padding: EdgeInsets.all(25),
        scrollDirection: Axis.horizontal,
        itemCount: shops.length,
        itemBuilder: (BuildContext context, int index) {
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
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage(shops[index].imageUrl),
                    width: 220,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  shops[index].shopName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 205,
                  height: 60,
                  child: Text(
                    shops[index].subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      shops[index].products + ' товаров',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.yellow,
                        ),
                        Text(shops[index].rating),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
