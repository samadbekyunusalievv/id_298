import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'about_page.dart';
import 'settings_page.dart';
import 'squash_info_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    AboutPage(),
    SquashInfoPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 45.h,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.25),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: Color.fromRGBO(255, 102, 56, 0.25),
            height: 1.h,
          ),
        ),
        title: Text(
          _currentIndex == 0
              ? 'About'
              : _currentIndex == 1
                  ? 'Squash info'
                  : 'Settings',
          style: TextStyle(
            fontFamily: 'Lineal',
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
            height: 22 / 20,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            border: Border(
              top: BorderSide(
                color: Color.fromRGBO(255, 102, 56, 0.25),
                width: 1.h,
              ),
            ),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon('assets/icons/about_icon.png', 0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/icons/squash_info_icon.png', 1),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/icons/settings_icon.png', 2),
                label: '',
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.transparent,
            unselectedItemColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String assetName, int index) {
    return Image.asset(
      assetName,
      width: 25.w,
      height: 25.h,
      color:
          _currentIndex == index ? Colors.white : Colors.white.withOpacity(0.4),
    );
  }
}
