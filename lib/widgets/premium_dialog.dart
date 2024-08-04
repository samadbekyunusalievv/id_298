import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumDialog extends StatelessWidget {
  final VoidCallback onDetails;
  final VoidCallback onRestore;

  const PremiumDialog({
    required this.onDetails,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 335.w,
        height: 296.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          image: DecorationImage(
            image: AssetImage('assets/premium_dialog_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20.64.h),
              Text(
                'Ads Free',
                style: TextStyle(
                  fontFamily: 'Lineal',
                  fontWeight: FontWeight.w600,
                  fontSize: 32.r,
                  height: 35.2 / 32,
                  color: const Color.fromRGBO(255, 102, 56, 1),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Text(
                'For',
                style: TextStyle(
                  fontFamily: 'Lineal',
                  fontWeight: FontWeight.w400,
                  fontSize: 20.r,
                  height: 22 / 20,
                  color: const Color.fromRGBO(255, 102, 56, 1),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                '\$0.49',
                style: TextStyle(
                  fontFamily: 'Lineal',
                  fontWeight: FontWeight.w400,
                  fontSize: 36.r,
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
              SizedBox(height: 22.h),
              Container(
                width: 128.w,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: const Color.fromRGBO(255, 102, 56, 1),
                    width: 2,
                  ),
                ),
                child: Container(
                  width: 124.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(
                      color: const Color.fromRGBO(255, 102, 56, 0.25),
                      width: 2,
                    ),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: onDetails,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(124.w, 40.h),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'See Details',
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
              SizedBox(height: 10.h),
              TextButton(
                onPressed: onRestore,
                child: Text(
                  'Restore',
                  style: TextStyle(
                    fontFamily: 'Lineal',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.r,
                    height: 17.6 / 16,
                    color: const Color.fromRGBO(255, 102, 56, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
