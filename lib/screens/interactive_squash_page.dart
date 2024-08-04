import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InteractiveSquashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = 45.h;
    double topPadding =
        MediaQuery.of(context).padding.top + appBarHeight + 20.h;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.25),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: Color.fromRGBO(255, 102, 56, 0.25),
            height: 1.h,
          ),
        ),
        title: Text(
          'Interactive Squash',
          style: TextStyle(
            fontFamily: 'Lineal',
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
            height: 22 / 20,
            color: Color.fromRGBO(255, 102, 56, 1),
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        toolbarHeight: appBarHeight,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              size: 16.r, color: Color.fromRGBO(255, 102, 56, 1)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/about_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/interactive_squash_1.png',
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'A system – which on the squash court – creates a mixed reality. It is a fusion of the real and virtual worlds to create a new interactive environment and visualisation in which physical and digital objects coexist and interact in real time.',
                      style: TextStyle(
                        fontFamily: 'Lineal',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: 20.32 / 16,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Image.asset(
                      'assets/interactive_squash_2.png',
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Every court can be turned into a smart court in an instant. The technology tracks the movements and shots of the players. This means you can play in a massive virtual reality with the real racket and the selected training module.',
                      style: TextStyle(
                        fontFamily: 'Lineal',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: 20.32 / 16,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Image.asset(
                      'assets/interactive_squash_3.png',
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
