import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_shop_app/screens/activity.dart';
import 'package:social_shop_app/screens/add_product/add_product.dart';
import 'package:social_shop_app/screens/discover.dart';
import 'package:social_shop_app/screens/home/home.dart';
import 'package:social_shop_app/screens/profile.dart';

import '../config/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            allowImplicitScrolling: false,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: <Widget>[
              Home(),
              Activity(),
              Discover(),
              AddProduct(),
              Profile()
            ],
          ),
        ),
      bottomNavigationBar: BottomNavyBar(

        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() => currentIndex = index);
          _pageController.jumpToPage(index);
        },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: SvgPicture.asset("assets/icons/Home.svg"),
              title: Text("Home", style: TextStyle(color: Colors.black)),
              activeColor: kAccentColor,
              inactiveColor: Colors.black,
            ),
            BottomNavyBarItem(
              icon: SvgPicture.asset("assets/icons/notifications.svg"),
              title: Text("Activity", style: TextStyle(color: Colors.black)),
              activeColor: kAccentColor,
              inactiveColor: Colors.black,
            ),
            BottomNavyBarItem(
              icon: SvgPicture.asset("assets/icons/bolt.svg"),
              title: Text("Discover", style: TextStyle(color: Colors.black)),
              activeColor: kAccentColor,
              inactiveColor: Colors.black,
            ),
            BottomNavyBarItem(
              icon: SvgPicture.asset("assets/icons/shutter.svg"),
              title: Text("Sell", style: TextStyle(color: Colors.black)),
              activeColor: kAccentColor,
              inactiveColor: Colors.black,
            ),
            BottomNavyBarItem(
              icon: SvgPicture.asset("assets/icons/Profile.svg"),
              title: Text("Profile", style: TextStyle(color: Colors.black)),
              activeColor: kAccentColor,
              inactiveColor: Colors.black,
            ),

          ],
        ),

    );
    /*floatingActionButton: FloatingActionButton(onPressed: () {
        print("Increment Counter");
        setState(() {
          counter++;
        });
      }, child: Icon(Icons.add),),*/
  }
}
