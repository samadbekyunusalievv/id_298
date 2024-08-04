import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/main_screen.dart';
import 'screens/onboarding_screen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeStatus();
  }

  Future<void> _checkFirstTimeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    setState(() {
      _isFirstTime = isFirstTime;
    });

    if (isFirstTime) {
      prefs.setBool('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [routeObserver],
          home: _isFirstTime ? OnboardingScreen() : MainScreen(),
          routes: {
            '/main': (context) => MainScreen(),
          },
        );
      },
    );
  }
}
