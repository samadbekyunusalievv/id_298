import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveGameDialog extends StatelessWidget {
  final VoidCallback onLeave;
  final VoidCallback onCancel;

  LeaveGameDialog({required this.onLeave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
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
          height: 150.h,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 16.h),
                  Text(
                    "Are you really want to\nleave?",
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
                    'All progress will be lost.',
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
                  SizedBox(height: 15.r),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 35.w),
                        TextButton(
                          onPressed: onLeave,
                          child: Text(
                            "Leave",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 17.r,
                              height: 22.h / 17.r,
                            ),
                          ),
                        ),
                        SizedBox(width: 68.w),
                        TextButton(
                          onPressed: onCancel,
                          child: Text(
                            "No",
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
                top: 108.h,
                left: 0,
                right: 0,
                child: Container(
                  height: 1.h,
                  color: const Color.fromRGBO(255, 255, 255, 0.2),
                ),
              ),
              Positioned(
                top: 108.h,
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
  }
}
