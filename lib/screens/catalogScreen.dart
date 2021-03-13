import 'package:flutter/material.dart';
import 'package:visar/widgets/categorySelector.dart';

import '../colors.dart';

class CatalogScreen extends StatelessWidget {
  final Function opacity;
  CatalogScreen({this.opacity});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Категории",
                  style: TextStyle(
                      fontSize: 23, color: blue, fontWeight: FontWeight.w300),
                ),
                Text(
                  "Все",
                  style: TextStyle(
                    fontSize: 23,
                    color: grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          CategorySelector(
            opacity: opacity,
          ),
        ],
      ),
    );
  }
}
