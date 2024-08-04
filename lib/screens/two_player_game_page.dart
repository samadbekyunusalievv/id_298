import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../widgets/getready_dialog.dart';
import '../widgets/leave_game_dialog.dart';
import '../widgets/premium_dialog.dart';
import '../widgets/winning_dialog.dart';
import 'premium_screen.dart';

class TwoPlayerGamePage extends StatefulWidget {
  final int winningPoints;

  TwoPlayerGamePage({required this.winningPoints});

  @override
  _TwoPlayerGamePageState createState() => _TwoPlayerGamePageState();
}

class _TwoPlayerGamePageState extends State<TwoPlayerGamePage> with RouteAware {
  int player1Score = 0;
  int player2Score = 0;
  int currentPlayer = 1;
  int _timeLeft = 3;
  Timer? _timer;
  Timer? _premiumDialogTimer;
  Random random = Random();
  late int ballRow;
  late int ballColumn;
  List<String> options = [];
  late String correctOption;
  bool _gameActive = true;
  bool isPaused = false;
  bool _isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    _checkPremiumStatus();
    _generateNewBallPosition();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPlayerReadyDialog();
    });
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
    _timeLeft = 3;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_gameActive && !isPaused) {
        setState(() {
          if (_timeLeft > 0) {
            _timeLeft--;
          } else {
            _timer?.cancel();
            _checkAnswer(null);
          }
        });
      }
    });
  }

  void _checkAnswer(String? answer) {
    _timer?.cancel();
    setState(() {
      _timeLeft = 3;
    });

    if (answer == correctOption) {
      setState(() {
        if (currentPlayer == 1) {
          player1Score++;
        } else {
          player2Score++;
        }
      });
    } else {
      setState(() {
        if (currentPlayer == 1) {
          player1Score = max(0, player1Score - 1);
        } else {
          player2Score = max(0, player2Score - 1);
        }
      });
    }

    if (player1Score >= widget.winningPoints ||
        player2Score >= widget.winningPoints) {
      _showWinnerDialog();
    } else {
      setState(() {
        currentPlayer = currentPlayer == 1 ? 2 : 1;
        _showPlayerReadyDialog();
      });
    }
  }

  void _showWinnerDialog() {
    _pauseGame();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WinningDialog(
          winner:
              player1Score >= widget.winningPoints ? 'Player 1' : 'Player 2',
          scoreP1: player1Score,
          scoreP2: player2Score,
          onPlayAgain: () {
            Navigator.of(context).pop();
            setState(() {
              player1Score = 0;
              player2Score = 0;
              currentPlayer = 1;
              _gameActive = true;
            });
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

  void _showPlayerReadyDialog() {
    int preparationTimeLeft = 3;
    Timer? timer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            timer?.cancel();
            timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
              if (preparationTimeLeft > 0) {
                if (mounted) {
                  setState(() => preparationTimeLeft--);
                }
              } else {
                timer.cancel();
                if (Navigator.of(dialogContext).canPop()) {
                  Navigator.of(dialogContext).pop();
                }
              }
            });

            return WillPopScope(
              onWillPop: () async {
                timer?.cancel();
                return true;
              },
              child: GetReadyDialog(
                currentPlayer: currentPlayer.toString(),
                seconds: preparationTimeLeft,
              ),
            );
          },
        );
      },
    ).then((_) {
      timer?.cancel();
      _generateNewBallPosition();
      _startTimer();
    });
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
      isPaused = true;
    });
    _timer?.cancel();
  }

  void _resumeGame() {
    setState(() {
      _gameActive = true;
      isPaused = false;
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _showPlayerReadyDialog();
    });
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
          'Two Player',
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
                  80.h);
          double scoreContainerHeight = max(min(60.h, availableHeight / 3), 0);

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
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
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Score P1',
                                      style: TextStyle(
                                        fontFamily: 'Lineal',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.r,
                                        color: currentPlayer == 1
                                            ? Color.fromRGBO(255, 102, 56, 1)
                                            : Colors.white,
                                      ),
                                    ),
                                    Container(
                                      width: 124.w,
                                      height: scoreContainerHeight,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(35.r),
                                        border: Border.all(
                                          color: currentPlayer == 1
                                              ? Color.fromRGBO(255, 102, 56, 1)
                                              : Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$player1Score',
                                          style: TextStyle(
                                            fontFamily: 'Lineal',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 32.r,
                                            height: 0.03.h,
                                            color: currentPlayer == 1
                                                ? Color.fromRGBO(
                                                    255, 102, 56, 1)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                        fontFamily: 'Lineal',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.r,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      width: 124.w,
                                      height: scoreContainerHeight,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(35.r),
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
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Score P2',
                                      style: TextStyle(
                                        fontFamily: 'Lineal',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.r,
                                        color: currentPlayer == 2
                                            ? Color.fromRGBO(255, 102, 56, 1)
                                            : Colors.white,
                                      ),
                                    ),
                                    Container(
                                      width: 124.w,
                                      height: scoreContainerHeight,
                                      margin: EdgeInsets.only(top: 5.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(35.r),
                                        border: Border.all(
                                          color: currentPlayer == 2
                                              ? Color.fromRGBO(255, 102, 56, 1)
                                              : Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$player2Score',
                                          style: TextStyle(
                                            fontFamily: 'Lineal',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 32.r,
                                            height: 0.03.h,
                                            color: currentPlayer == 2
                                                ? Color.fromRGBO(
                                                    255, 102, 56, 1)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        children: [
                          SizedBox(height: 45.h + kToolbarHeight.h + 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: options.sublist(0, 2).map((option) {
                                    return Container(
                                      width: 135.w,
                                      height: 50.h,
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.r),
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
                                            color:
                                                Color.fromRGBO(255, 102, 56, 1),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: options.sublist(2, 4).map((option) {
                                    return Container(
                                      width: 135.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.r),
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
                                            color:
                                                Color.fromRGBO(255, 102, 56, 1),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  height: 336.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
