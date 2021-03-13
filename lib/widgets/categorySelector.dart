import 'package:flutter/material.dart';
import 'package:visar/colors.dart';
import 'package:visar/widgets/defaultIcon.dart';
import 'package:visar/models/models.dart';
import 'package:visar/widgets/productBlock.dart';
import 'package:visar/widgets/shopBlock.dart';

class CategorySelector extends StatefulWidget {
  final Function opacity;
  CategorySelector({this.opacity});
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _tabController = new TabController(
      length: categories.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: <Widget>[
            Container(
              height: 85,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: TabBar(
                  tabs: List<Widget>.generate(
                    categories.length,
                    (index) => DefaultIcon(
                      icon: categories[index].icons,
                      color: index == _selectedIndex ? white : blue,
                      bgColor: index == _selectedIndex ? blue : white,
                      margin: 8,
                      boxShadowColor:
                          index != _selectedIndex ? Colors.black26 : blue.withOpacity(0.5),
                    ),
                  ),
                  unselectedLabelColor: const Color(0xffacb3bf),
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 1.0,
                  isScrollable: true,
                  controller: _tabController,
                  onTap: onTap,
                  labelPadding: EdgeInsets.all(0),
                ),
              ),
            ),
            Container(
              height: 415,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: List<Widget>.generate(
                  categories.length,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          categories[index].categoryName,
                          style: TextStyle(
                            fontSize: 23,
                            color: blue,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        child: index == 0
                            ? ShopBlock()
                            : ProductBlock(
                                lists: categories[index].lists,
                                parentAction: widget.opacity,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
