import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetReadyDialog extends StatelessWidget {
  final String currentPlayer;
  final int seconds;

  GetReadyDialog({required this.currentPlayer, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          Positioned(
            top: 131.h,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: 335.w,
                    height: 147.h,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(
                        color: Color.fromRGBO(255, 102, 56, 1),
                        width: 1,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Player $currentPlayer, get ready!',
                          style: TextStyle(
                            fontFamily: 'Lineal',
                            fontWeight: FontWeight.w400,
                            fontSize: 20.r,
                            height: 22 / 20,
                            color: Color.fromRGBO(255, 102, 56, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 25.h),
                        Text(
                          '$seconds sec',
                          style: TextStyle(
                            fontFamily: 'Lineal',
                            fontWeight: FontWeight.w400,
                            fontSize: 32.r,
                            height: 35.2 / 32,
                            color: Color.fromRGBO(255, 102, 56, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: 289.w,
                          height: 2.h,
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
