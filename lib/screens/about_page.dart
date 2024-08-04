import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'classic_squash_page.dart';
import 'interactive_squash_page.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/about_bg.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 116.h),
              _buildCard(
                context,
                'assets/card1_bg.png',
                '#1',
                'Classic \nSquash',
                ClassicSquashPage(),
              ),
              SizedBox(height: 30.h),
              _buildCard(
                context,
                'assets/card2_bg.png',
                '#2',
                'Interactive \nSquash',
                InteractiveSquashPage(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String bgImage, String topText,
      String bottomText, Widget nextPage) {
    return Container(
      width: 335.w,
      height: 223.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        image: DecorationImage(
          image: AssetImage(bgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20.h,
            left: 20.w,
            child: Text(
              topText,
              style: TextStyle(
                fontFamily: 'Lineal',
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                height: 22 / 20,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 20.w,
            bottom: 20.h,
            child: Text(
              bottomText,
              style: TextStyle(
                fontFamily: 'Lineal',
                fontWeight: FontWeight.w400,
                fontSize: 24.sp,
                height: 26.4 / 24,
                color: Color.fromRGBO(255, 102, 56, 1),
              ),
            ),
          ),
          Positioned(
            right: 18.w,
            bottom: 18.h,
            child: Container(
              width: 128.w,
              height: 44.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  color: Color.fromRGBO(255, 102, 56, 1),
                  width: 2,
                ),
              ),
              child: Container(
                width: 124.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: Color.fromRGBO(255, 102, 56, 0.25),
                    width: 2,
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => nextPage,
                        ),
                      );
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
                          'Let\'s Read',
                          style: TextStyle(
                            fontFamily: 'Lineal',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            height: 17.6 / 16,
                            color: Color.fromRGBO(255, 102, 56, 1),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Icon(
                          Icons.navigate_next,
                          color: Color.fromRGBO(255, 102, 56, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
