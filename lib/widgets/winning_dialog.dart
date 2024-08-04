import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WinningDialog extends StatelessWidget {
  final String winner;
  final int scoreP1;
  final int scoreP2;
  final VoidCallback onPlayAgain;

  WinningDialog({
    required this.winner,
    required this.scoreP1,
    required this.scoreP2,
    required this.onPlayAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          width: 335.w,
          height: 252.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/win_dialog_bg.png',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Congratulations $winner!',
                    style: TextStyle(
                      fontFamily: 'Lineal',
                      fontWeight: FontWeight.w600,
                      fontSize: 24.r,
                      height: 26.4 / 24,
                      color: Color(0xFFFF6638),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Score P${winner == 'Player 1' ? '1' : '2'}',
                              style: TextStyle(
                                fontFamily: 'Lineal',
                                fontWeight: FontWeight.w400,
                                fontSize: 20.r,
                                height: 22 / 20,
                                color: Color(0xFFFF6638),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              winner == 'Player 1' ? '$scoreP1' : '$scoreP2',
                              style: TextStyle(
                                fontFamily: 'Lineal',
                                fontWeight: FontWeight.w400,
                                fontSize: 32.r,
                                height: 35.2 / 32,
                                color: Color(0xFFFF6638),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              width: 100.w,
                              height: 2.h,
                              color: Color(0xFFFF6638),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Score P${winner == 'Player 1' ? '2' : '1'}',
                              style: TextStyle(
                                fontFamily: 'Lineal',
                                fontWeight: FontWeight.w400,
                                fontSize: 20.r,
                                height: 22 / 20,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              winner == 'Player 1' ? '$scoreP2' : '$scoreP1',
                              style: TextStyle(
                                fontFamily: 'Lineal',
                                fontWeight: FontWeight.w400,
                                fontSize: 32.r,
                                height: 35.2 / 32,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              width: 100.w,
                              height: 2.h,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                    child: Container(
                      width: 124.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(
                          color: Color(0xFFFF6638).withOpacity(0.25),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
