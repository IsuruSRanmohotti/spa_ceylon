import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:spa_ceylon/controllers/database/user_controller.dart';
import 'package:spa_ceylon/screens/auth/auth_screen.dart';
import 'package:spa_ceylon/screens/home/homepage.dart';
import 'package:spa_ceylon/utils/navigation_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Logger().e(FirebaseAuth.instance.currentUser);
    Timer(Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser == null) {
        NavigationManager.goWithReplace(context, SigninScreen());
      } else {
        UserController().getUserData(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: SvgPicture.asset(
                    'assets/svg/logo.svg',
                    width: size.width * 0.8,
                    colorFilter: ColorFilter.mode(
                      Colors.amber,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                CupertinoActivityIndicator(color: Colors.white, radius: 10),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Powered By Ceylon Edge',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
