import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  Icon item1 = const Icon(Icons.home_outlined);
  Icon item2 = const Icon(Icons.person_outline_outlined);
  Icon item3 = const Icon(Icons.home_outlined);

  BottomNavigationBarItem bottomBarItem(Icon icon, int index) {
    return BottomNavigationBarItem(
        icon: Container(
          width: bottomBarWidth,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: _page == index
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth),
            ),
          ),
          child: icon,
        ),
        label: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          bottomBarItem(item1, 0),
          bottomBarItem(item2, 1),
          bottomBarItem(item3, 2),
        ],
      ),
    );
  }
}
