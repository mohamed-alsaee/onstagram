import 'package:flutter/material.dart';
import 'package:onstagram/helpers/functions.dart';
import 'package:onstagram/screens/main_screens/tabs_content/add_post_screen.dart';
import 'package:onstagram/screens/main_screens/tabs_content/home_screen.dart';
import 'package:onstagram/screens/main_screens/tabs_content/notifications_screen.dart';
import 'package:onstagram/screens/main_screens/tabs_content/profile_screen.dart';
import 'package:onstagram/screens/main_screens/tabs_content/search_screen.dart';

class TabsScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedIndex == 0
          ? ProfileScreen()
          : selectedIndex == 1
          ? NotificationsScreen()
          : selectedIndex == 2
          ? AddPostScreen()
          : selectedIndex == 3
          ? SearchScreen()
          : HomeScreen(),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "",

            icon: Container(
              width: getSize(context).width * 0.1,
              height: getSize(context).width * 0.1,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",

            icon: Image.asset(
              "assets/icons/heartIcon.png",
              width: getSize(context).width * 0.1,
              height: getSize(context).width * 0.1,
            ),
          ),

          BottomNavigationBarItem(
            label: "",

            icon: Image.asset(
              "assets/icons/plusSquareIcon.png",
              width: getSize(context).width * 0.1,
              height: getSize(context).width * 0.1,
            ),
          ),
          BottomNavigationBarItem(
            label: "",

            icon: Image.asset(
              "assets/icons/searchIcon.png",
              width: getSize(context).width * 0.1,
              height: getSize(context).width * 0.1,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              "assets/icons/homeIcon.png",
              width: getSize(context).width * 0.1,
              height: getSize(context).width * 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
