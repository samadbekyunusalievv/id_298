import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 117.h),
                Text(
                  'SQUASH',
                  style: TextStyle(
                    color: const Color(0xFFFF6638),
                    fontSize: 69.sp,
                    fontFamily: 'Lineal',
                    fontWeight: FontWeight.w400,
                    height: 1.h,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Entertainment',
                  style: TextStyle(
                    color: const Color(0xFFFF6638),
                    fontSize: 36.sp,
                    fontFamily: 'Lineal',
                    fontWeight: FontWeight.w400,
                    height: 1.h,
                  ),
                ),
                SizedBox(height: 35.h),
                Text(
                  'A sports revolution',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: 'Lineal',
                    fontWeight: FontWeight.w300,
                    height: 1.h,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 252.h,
            right: 20.w,
            child: Container(
              width: 104.w,
              height: 54.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34.r),
                border: Border.all(
                  color: const Color.fromRGBO(255, 102, 56, 1),
                  width: 2,
                ),
              ),
              child: Container(
                width: 100.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  border: Border.all(
                    color: const Color.fromRGBO(255, 102, 56, 0.25),
                    width: 2,
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      _showNotificationDialog(context);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(124.w, 40.h),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Go',
                          style: TextStyle(
                            fontFamily: 'Lineal',
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                            height: 17.6 / 16,
                            color: const Color.fromRGBO(255, 102, 56, 1),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.navigate_next,
                          color: const Color.fromRGBO(255, 102, 56, 1),
                          size: 26.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 333.h,
            child: Container(
              width: 375.w,
              height: 375.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/onb_element.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Terms of Use',
                    style: TextStyle(
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      height: 20 / 14,
                      letterSpacing: -0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 50.w),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      height: 20 / 14,
                      letterSpacing: -0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showNotificationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
            child: Container(
              padding: EdgeInsets.zero,
              width: 270.w,
              height: 198.h,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 16.h),
                      Text(
                        "“SQUASH Entertainment”\nWould Like to Send You\nNotifications",
                        style: TextStyle(
                          fontSize: 17.r,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.41,
                          height: 22.h / 17.r,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Notifications can include alerts,\n sounds, and icons. You can customize\n them in Settings.",
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 13.r,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.08,
                          color: Colors.white,
                          height: 16.h / 13.r,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.r),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20.w),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/main');
                              },
                              child: Text(
                                "Don't allow",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17.r,
                                  height: 22.h / 17.r,
                                ),
                              ),
                            ),
                            SizedBox(width: 54.w),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/main');
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 17.r,
                                  height: 22.h / 17.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 154.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 1.h,
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                  ),
                  Positioned(
                    top: 154.h,
                    left: 135.w,
                    bottom: 0,
                    child: Container(
                      width: 1.w,
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
