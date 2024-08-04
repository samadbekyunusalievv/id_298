import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'one_player_game_page.dart';
import 'two_player_game_page.dart';

class SquashInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/squash_info_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 116.h),
                _buildCard(
                  context,
                  'assets/card1_info_bg.png',
                  'One player \ngame',
                  OnePlayerGamePage(),
                ),
                SizedBox(height: 30.h),
                _buildCard(
                  context,
                  'assets/card2_info_bg.png',
                  'Two player \ngame',
                  null,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String bgImage, String bottomText,
      Widget? nextPage) {
    return Container(
      width: 335.w,
      height: 223.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: Container(
              width: 335.w,
              height: 223.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgImage),
                  fit: BoxFit.cover,
                ),
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
                color: const Color.fromRGBO(255, 102, 56, 1),
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
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      if (nextPage != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => nextPage,
                          ),
                        );
                      } else {
                        _showWinningPointsDialog(context);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(124.w, 40.h),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10.w),
                        Text(
                          'Play',
                          style: TextStyle(
                            fontFamily: 'Lineal',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            height: 17.6 / 16,
                            color: const Color.fromRGBO(255, 102, 56, 1),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        const Icon(
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

  void _showWinningPointsDialog(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Container(
                    width: 335.w,
                    height: 242.h,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 0.7),
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                        color: const Color.fromRGBO(255, 102, 56, 1),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 23.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'How many points do you\nneed to win?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lineal',
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                            height: 22 / 20,
                            color: const Color.fromRGBO(255, 102, 56, 1),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextField(
                          controller: _textController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          cursorColor: const Color.fromRGBO(255, 102, 56, 1),
                          style: TextStyle(
                            fontFamily: 'Lineal',
                            fontWeight: FontWeight.w400,
                            fontSize: 32.sp,
                            height: 35.2 / 32,
                            color: const Color.fromRGBO(255, 102, 56, 1),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(255, 102, 56, 1),
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(255, 102, 56, 1),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
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
                              onPressed: () {
                                final int winningPoints =
                                    int.tryParse(_textController.text) ?? 0;
                                if (winningPoints > 0) {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TwoPlayerGamePage(
                                          winningPoints: winningPoints),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please enter a valid number of points'),
                                    ),
                                  );
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(124.w, 40.h),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Play',
                                    style: TextStyle(
                                      fontFamily: 'Lineal',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      height: 17.6 / 16,
                                      color:
                                          const Color.fromRGBO(255, 102, 56, 1),
                                    ),
                                  ),
                                  SizedBox(width: 7.w),
                                  Icon(
                                    Icons.navigate_next,
                                    color:
                                        const Color.fromRGBO(255, 102, 56, 1),
                                    size: 16.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
