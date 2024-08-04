import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassicSquashPage extends StatelessWidget {
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
          'Classic Squash',
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
                      'assets/classic_squash_1.png',
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Squash is a game played on a walled indoor court with a racket and ball. The racket is less than 27 inches long, and the ball is 1.75 inches in diameter. It is played by two or four players (singles or doubles). The most commonly played version of the game is known as English squash, or softball. American squash is played with a harder ball, although English squash is still more popular in the United States. Strategies differ in these two versions, as the harder ball necessitates faster play.',
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
                      'assets/classic_squash_2.png',
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'A singles softball court is 32 feet long and 21 feet wide, with a service-court line down the middle. Serves must land behind this line. Another line divides the court in half lengthwise. The service court is a square box measuring 5 feet 3 inches on each side. The server must keep at least one foot in this box while completing the serve. Serves are required to hit the front wall above a service line painted 6 feet from the floor. The telltale is a metal box 19 inches in height from the floor on the front wall. Any shot hitting the telltale is out of play. Hardball courts are 18.5 feet wide, with a higher front wall and shorter telltale. Larger courts are used for doubles games.',
                      style: TextStyle(
                        fontFamily: 'Lineal',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: 20.32 / 16,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Play is started when the ball is served off the front wall so that it bounces in the service area of the opponent. If the ball bounces twice before being hit, a point is scored by the serving player. A point is also scored when the opponent fails to hit the serve into the front wall above the telltale, or the opponent\'s hit strikes the ceiling or above the boundary lines marked on the walls.',
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
                      'assets/classic_squash_3.png',
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'In the widely played softball version, a game is 9 points and the point winner is the next to serve. Points can only be scored by the server. The best two out of three or three out of five games comprise a squash match. In the hardball version the winner of the rally scores a point, and a game is 15 points.',
                      style: TextStyle(
                        fontFamily: 'Lineal',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: 20.32 / 16,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'The game of squash was first played in the mid 1700s at the Harrow School in England, and in the late 1700s the game traveled to the United States. The United States Squash Racquets Association was formed in 1920 as a governing body.',
                      style: TextStyle(
                        fontFamily: 'Lineal',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: 20.32 / 16,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
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
