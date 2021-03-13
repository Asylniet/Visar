import 'package:flutter/material.dart';
import 'package:visar/screens/accountScreen.dart';
import 'package:visar/screens/catalogScreen.dart';
import 'package:visar/screens/favoritesScreen.dart';
import 'package:visar/screens/purchasesScreen.dart';
import 'package:visar/widgets/animatedIcon.dart';
import '../widgets/defaultIcon.dart';
import '../colors.dart';

import 'dart:math' as math;

class CustomNotchedRectangle extends NotchedShape {
  const CustomNotchedRectangle();

  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    const double s1 = 20.0;
    const double s2 = 15.0;
    const double addedRadius = 6;

    final double notchRadius = guest.width / 2.0 + addedRadius;
    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset> p = List<Offset>(6);

    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    for (int i = 0; i < p.length; i += 1) p[i] += guest.center;

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

List<double> dotOpacitis = [
  0,
  0,
  0,
  0,
];

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  GlobalKey<CustomAnimatedIconState> customAnimatedIconKey0 =
      GlobalKey<CustomAnimatedIconState>();
  GlobalKey<CustomAnimatedIconState> customAnimatedIconKey1 =
      GlobalKey<CustomAnimatedIconState>();
  GlobalKey<CustomAnimatedIconState> customAnimatedIconKey2 =
      GlobalKey<CustomAnimatedIconState>();
  GlobalKey<CustomAnimatedIconState> customAnimatedIconKey3 =
      GlobalKey<CustomAnimatedIconState>();
  int _selectedIndex = 0;
  TabController _tabController;
  PageController pageController;

  void onTap(int index) async {
    int pageTarget = index;
    int pageCurrent = pageController.page.round();
    if (index == 1) {
      setState(() {
        dotOpacitis[1] = 0;
      });
    }
    if (index == 2) {
      setState(() {
        dotOpacitis[2] = 0;
      });
    }
    if (pageCurrent > pageTarget) {
      setState(() {
        opacitis[pageTarget + 1] = 0;
      });
      pageController.jumpToPage(pageTarget + 1);
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      setState(() {
        opacitis[index] = 1;
      });
    } else if (pageCurrent < pageTarget) {
      setState(() {
        opacitis[pageTarget - 1] = 0;
      });
      pageController.jumpToPage(pageTarget - 1);
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      setState(() {
        opacitis[index] = 1;
      });
    }
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        customAnimatedIconKey0.currentState.controller.forward();
      } else if (_selectedIndex == 1) {
        customAnimatedIconKey1.currentState.controller.forward();
      } else if (_selectedIndex == 2) {
        customAnimatedIconKey2.currentState.controller.forward();
      } else if (_selectedIndex == 3) {
        customAnimatedIconKey3.currentState.controller.forward();
      }
    });
  }

  @override
  void initState() {
    pageController = PageController();
    _tabController = new TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void opacity(double opacity) {
    setState(() {
      dotOpacitis[2] = opacity;
    });
  }

  List<IconData> icons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.bookmarks,
    Icons.person,
  ];

  List<String> titles = [
    "Каталог",
    "Покупки",
    "Сохраненные",
    "Аккаунт",
  ];

  List<double> opacitis = [
    1,
    1,
    1,
    1,
  ];

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    // ]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: white,
      appBar: AppBar(
        toolbarHeight: 65,
        title: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultIcon(icon: Icons.menu),
              Text(
                titles[_selectedIndex],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
              DefaultIcon(icon: Icons.search),
            ],
          ),
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.threed_rotation,
          color: blue,
        ),
        backgroundColor: white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Opacity(
              opacity: opacitis[0],
              child: CatalogScreen(
                opacity: opacity,
              ),
            ),
            Opacity(
              opacity: opacitis[1],
              child: PurchasesScreen(
                parentAction: onTap,
              ),
            ),
            Opacity(
              opacity: opacitis[2],
              child: FavoritesScreen(
                parentAction: onTap,
              ),
            ),
            Opacity(
              opacity: opacitis[3],
              child: AccountScreen(),
            ),
          ],
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: blue,
        shape: CustomNotchedRectangle(),
        child: Container(
          height: 56.0,
          color: Colors.transparent,
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: TabBar(
              unselectedLabelColor: const Color(0xffacb3bf),
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 1.0,
              isScrollable: false,
              controller: _tabController,
              onTap: onTap,
              labelPadding: EdgeInsets.all(0),
              tabs: [
                Container(
                  child: CustomAnimatedIcon(
                    key: customAnimatedIconKey0,
                    icon: icons[0],
                    color: _selectedIndex == 0 ? Colors.black : white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 45),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      CustomAnimatedIcon(
                        key: customAnimatedIconKey1,
                        icon: icons[1],
                        color: _selectedIndex == 1 ? Colors.black : white,
                      ),
                      Positioned(
                        right: -2,
                        top: -1,
                        child: AnimatedOpacity(
                          duration: Duration(microseconds: 300),
                          opacity: dotOpacitis[1],
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 45),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      CustomAnimatedIcon(
                        key: customAnimatedIconKey2,
                        icon: icons[2],
                        color: _selectedIndex == 2 ? Colors.black : white,
                      ),
                      Positioned(
                        right: -2,
                        top: -1,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: dotOpacitis[2],
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      CustomAnimatedIcon(
                        key: customAnimatedIconKey3,
                        icon: icons[3],
                        color: _selectedIndex == 3 ? Colors.black : white,
                      ),
                      Positioned(
                        right: -2,
                        top: -1,
                        child: Opacity(
                          opacity: dotOpacitis[3],
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
