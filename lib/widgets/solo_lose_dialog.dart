import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SoloLoseDialog extends StatelessWidget {
  final int score;
  final VoidCallback onPlayAgain;

  SoloLoseDialog({required this.score, required this.onPlayAgain});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: Container(
            width: 335.w,
            height: 252.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25.r),
              image: DecorationImage(
                image: AssetImage('assets/win_dialog_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Lose...',
                  style: TextStyle(
                    fontFamily: 'Lineal',
                    fontWeight: FontWeight.w600,
                    fontSize: 24.r,
                    height: 26.4 / 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Text(
                  'Score',
                  style: TextStyle(
                    fontFamily: 'Lineal',
                    fontWeight: FontWeight.w400,
                    fontSize: 20.r,
                    height: 22 / 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  '$score',
                  style: TextStyle(
                    fontFamily: 'Lineal',
                    fontWeight: FontWeight.w400,
                    fontSize: 32.r,
                    height: 35.2 / 32,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Container(
                  width: 200.w,
                  height: 2.h,
                  color: Colors.black,
                ),
                SizedBox(height: 20.h),
                Container(
                  width: 128.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(
                      color: Color(0xFFFF6638),
                      width: 2,
                    ),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: onPlayAgain,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(124.w, 40.h),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        fontFamily: 'Lineal',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Color(0xFFFF6638),
                      ),
                    ),
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
