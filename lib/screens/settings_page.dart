import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'premium_screen.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({required this.value, required this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 42.w,
            height: 28.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: Colors.white,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 2.w + (widget.value ? 14.w : 0.w),
                  child: Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.value
                          ? const Color.fromRGBO(255, 102, 56, 1)
                          : Colors.white,
                      border: Border.all(
                        color: widget.value ? Colors.transparent : Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;
  bool _isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    _checkPremiumStatus();
  }

  Future<void> _checkPremiumStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPremium = prefs.getBool('isPremiumUser') ?? false;
    setState(() {
      _isPremiumUser = isPremium;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/settings_bg.png', // Use the provided background image asset path
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight + 45.h),
                Container(
                  width: 335.w,
                  height: 52.h,
                  padding: EdgeInsets.symmetric(horizontal: 31.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontFamily: 'Lineal',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          height: 17.6 / 16,
                          color: Colors.white,
                        ),
                      ),
                      CustomSwitch(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (!_isPremiumUser) SizedBox(height: 38.h),
                if (!_isPremiumUser)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PremiumScreen(
                                onStatusChanged: _checkPremiumStatus,
                              ),
                            ),
                          );
                          _checkPremiumStatus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(255, 102, 56, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 15.h),
                          fixedSize: Size(158.w, 52.h),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'See details',
                              style: TextStyle(
                                fontFamily: 'Lineal',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.r,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                              size: 20.r,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.w),
                        child: Column(
                          children: [
                            Text(
                              'Ads free for',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Lineal',
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                                color: const Color.fromRGBO(255, 102, 56, 1),
                              ),
                            ),
                            Container(
                              width: 124.w,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(255, 102, 56, 1),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                '\$0.49',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Lineal',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24.sp,
                                  color: const Color.fromRGBO(255, 102, 56, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 38.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        fixedSize: Size(158.w, 52.h),
                      ),
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'Lineal',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PremiumScreen(
                              onStatusChanged: _checkPremiumStatus,
                            ),
                          ),
                        );
                        _checkPremiumStatus();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        fixedSize: Size(158.w, 52.h),
                      ),
                      child: Text(
                        'Terms of Use',
                        style: TextStyle(
                          fontFamily: 'Lineal',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
