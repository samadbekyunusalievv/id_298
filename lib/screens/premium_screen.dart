import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumScreen extends StatelessWidget {
  final Function() onStatusChanged;

  PremiumScreen({required this.onStatusChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: const Color.fromRGBO(255, 102, 56, 1), size: 16.r),
          onPressed: () {
            Navigator.pop(context);
            onStatusChanged();
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/prem_bg.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 483.h),
                  Text(
                    'Ads Free',
                    style: TextStyle(
                      fontFamily: 'Lineal',
                      fontWeight: FontWeight.w600,
                      fontSize: 32.r,
                      height: 35.2 / 32,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'For',
                    style: TextStyle(
                      fontFamily: 'Lineal',
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                      height: 22 / 20,
                      color: const Color.fromRGBO(255, 102, 56, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    children: [
                      Text(
                        '\$0.49',
                        style: TextStyle(
                          fontFamily: 'Lineal',
                          fontWeight: FontWeight.w400,
                          fontSize: 36.sp,
                          height: 39.6 / 36,
                          color: const Color.fromRGBO(255, 102, 56, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 124.w,
                        height: 2.h,
                        color: const Color.fromRGBO(255, 102, 56, 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Container(
                    width: 158.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(
                        color: const Color.fromRGBO(255, 102, 56, 1),
                        width: 2,
                      ),
                    ),
                    child: Container(
                      width: 154.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(
                          color: const Color.fromRGBO(255, 102, 56, 0.25),
                          width: 2,
                        ),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isPremiumUser', true);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Congratulations!'),
                                content: Text('You are now a premium user.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      onStatusChanged();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(154.w, 42.h),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Get Premium',
                          style: TextStyle(
                            fontFamily: 'Lineal',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: const Color.fromRGBO(255, 102, 56, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Terms of Use',
                    style: TextStyle(
                      fontFamily: 'Lineal',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isPremiumUser', false);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Info'),
                          content: Text('You are no longer a premium user.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                onStatusChanged();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Restore',
                    style: TextStyle(
                      fontFamily: 'Lineal',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'Lineal',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
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
}
