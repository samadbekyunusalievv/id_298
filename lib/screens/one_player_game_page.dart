import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../widgets/leave_game_dialog.dart';
import '../widgets/premium_dialog.dart';
import '../widgets/solo_lose_dialog.dart';
import '../widgets/solo_win_dialog.dart';
import 'premium_screen.dart';

class OnePlayerGamePage extends StatefulWidget {
  @override
  _OnePlayerGamePageState createState() => _OnePlayerGamePageState();
}

class _OnePlayerGamePageState extends State<OnePlayerGamePage> with RouteAware {
  int score = 0;
  int mistakes = 0;
  static const int maxMistakes = 3;
  static const int timeLimit = 3;
  Timer? _timer;
  Timer? _premiumDialogTimer;
  int _timeLeft = timeLimit;
  Random random = Random();
  late int ballRow;
  late int ballColumn;
  late List<String> options;
  late String correctOption;
  bool _gameActive = true;
  bool _isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    _checkPremiumStatus();
    _generateNewBallPosition();
    _startTimer();
  }

  Future<void> _checkPremiumStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPremium = prefs.getBool('isPremiumUser') ?? false;
    setState(() {
      _isPremiumUser = isPremium;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _premiumDialogTimer?.cancel();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _resumeGame();
  }

  void _generateNewBallPosition() {
    ballRow = random.nextInt(3) + 1;
    ballColumn = random.nextInt(4) + 1;
    correctOption = '$ballRow/$ballColumn';
    options = List.generate(4, (index) {
      if (index == 0) {
        return correctOption;
      } else {
        int row;
        int column;
        do {
          row = random.nextInt(3) + 1;
          column = random.nextInt(4) + 1;
        } while (row == ballRow && column == ballColumn);
        return '$row/$column';
      }
    });
    options.shuffle();
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = timeLimit;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_gameActive) {
        setState(() {
          if (_timeLeft > 0) {
            _timeLeft--;
          } else {
            _timer?.cancel();
            _incrementMistakes();
          }
        });
      }
    });
  }

  void _checkAnswer(String answer) {
    if (answer == correctOption) {
      setState(() {
        score++;
        _generateNewBallPosition();
        _startTimer();
      });
    } else {
      _incrementMistakes();
    }
  }

  void _incrementMistakes() {
    setState(() {
      mistakes++;
      if (mistakes >= maxMistakes) {
        if (score > 0) {
          _showWinDialog();
        } else {
          _showLoseDialog();
        }
      } else {
        _generateNewBallPosition();
        _startTimer();
      }
    });
  }

  void _showWinDialog() {
    _pauseGame();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SoloWinDialog(
          score: score,
          onPlayAgain: () {
            Navigator.of(context).pop();
            setState(() {
              score = 0;
              mistakes = 0;
            });
            _startTimer();
            if (!_isPremiumUser) {
              _showPremiumDialog();
            } else {
              _resumeGame();
            }
          },
        );
      },
    );
  }

  void _showLoseDialog() {
    _pauseGame();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SoloLoseDialog(
          score: score,
          onPlayAgain: () {
            Navigator.of(context).pop();
            setState(() {
              score = 0;
              mistakes = 0;
            });
            _startTimer();
            if (!_isPremiumUser) {
              _showPremiumDialog();
            } else {
              _resumeGame();
            }
          },
        );
      },
    );
  }

  void _showLeaveGameDialog() {
    _pauseGame();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return LeaveGameDialog(
          onLeave: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
            _resumeGame();
          },
        );
      },
    );
  }

  void _showPremiumDialog() {
    _premiumDialogTimer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PremiumDialog(
          onDetails: () {
            _premiumDialogTimer?.cancel();
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => PremiumScreen(
                  onStatusChanged: () async {
                    await _checkPremiumStatus();
                  },
                ),
              ),
            )
                .then((_) {
              _resumeGame();
            });
          },
          onRestore: () {
            _premiumDialogTimer?.cancel();
            Navigator.of(context).pop();
            _resumeGame();
          },
        );
      },
    );

    _premiumDialogTimer = Timer(Duration(seconds: 5), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
        _resumeGame();
      }
    });
  }

  void _pauseGame() {
    setState(() {
      _gameActive = false;
    });
    _timer?.cancel();
  }

  void _resumeGame() {
    setState(() {
      _gameActive = true;
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));
    double cellWidth = 59.w;
    double cellHeight = 61.w;

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
          'One Player',
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
        toolbarHeight: 45.h,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              size: 16.r, color: Color.fromRGBO(255, 102, 56, 1)),
          onPressed: () {
            _showLeaveGameDialog();
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double gridSidePadding = 72.5.w;
          double gridTopBottomPadding = 57.5.w;
          double vectorImageHeight =
              3 * cellHeight + 2 * 0.5 + 2 * gridTopBottomPadding;
          double gridTopPadding = 240.h + gridTopBottomPadding;

          double availableHeight = constraints.maxHeight -
              (gridTopPadding +
                  3 * cellHeight +
                  2 * 0.5 +
                  kToolbarHeight.h +
                  50.h);
          double racketHeight = min(availableHeight / maxMistakes, 71.r);
          double racketWidth = racketHeight / 2.63;

          return Stack(
            children: [
              Container(
                color: Color(0xFF171717),
              ),
              Positioned(
                top: 236.h,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/vector.png',
                  width: constraints.maxWidth,
                  height: vectorImageHeight,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: gridTopPadding,
                left: gridSidePadding,
                right: gridSidePadding,
                child: Container(
                  width: constraints.maxWidth - 2 * gridSidePadding,
                  height: 3 * cellHeight + 2 * 0.5,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: cellWidth / cellHeight,
                    ),
                    itemBuilder: (context, index) {
                      int row = index ~/ 4 + 1;
                      int column = index % 4 + 1;
                      return Container(
                        width: cellWidth,
                        height: cellHeight,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(206, 231, 242, 1),
                          border: Border.all(color: Colors.black, width: 0.5),
                        ),
                        child: Center(
                          child: row == ballRow && column == ballColumn
                              ? Image.asset(
                                  'assets/ball.png',
                                  width: 37.r,
                                  height: 37.r,
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: gridTopPadding +
                    3 * cellHeight +
                    2 * 0.5 +
                    kToolbarHeight.h +
                    20.h,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 70.w, left: 65.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Score',
                            style: TextStyle(
                              fontFamily: 'Lineal',
                              fontWeight: FontWeight.w400,
                              fontSize: 20.r,
                              color: Color.fromRGBO(255, 102, 56, 1),
                            ),
                          ),
                          Text(
                            'Time',
                            style: TextStyle(
                              fontFamily: 'Lineal',
                              fontWeight: FontWeight.w400,
                              fontSize: 20.r,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 124.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.r),
                              border: Border.all(
                                color: Color.fromRGBO(255, 102, 56, 1),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$score',
                                style: TextStyle(
                                  fontFamily: 'Lineal',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 32.r,
                                  height: 0.03.h,
                                  color: Color.fromRGBO(255, 102, 56, 1),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 124.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35.r),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${_timeLeft} sec',
                                style: TextStyle(
                                  fontFamily: 'Lineal',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 32.r,
                                  height: 0.03.h,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(maxMistakes - mistakes, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Image.asset(
                            'assets/racket.png',
                            width: racketWidth,
                            height: racketHeight,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 45.h + kToolbarHeight.h + 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: options.sublist(0, 2).map((option) {
                                return Container(
                                  width: 135.w,
                                  height: 50.h,
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () => _checkAnswer(option),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        fontFamily: 'Lineal',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.sp,
                                        height: 22 / 20,
                                        color: Color.fromRGBO(255, 102, 56, 1),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: options.sublist(2, 4).map((option) {
                                return Container(
                                  width: 135.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () => _checkAnswer(option),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        fontFamily: 'Lineal',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.sp,
                                        height: 22 / 20,
                                        color: Color.fromRGBO(255, 102, 56, 1),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 336.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
