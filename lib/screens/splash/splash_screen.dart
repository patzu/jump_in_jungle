import 'dart:async';

import 'package:bitcoin_girl/main.dart';
import 'package:bitcoin_girl/screens/game_launcher.dart';
import 'package:bitcoin_girl/widgets/play_overlay.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GameLauncher()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(height: 200),
              // Image.asset(
              //   'assets/images/icon.png',
              //   scale: 1.8,
              // ),
              Text(
                'Crazy Dino Game',
                style: TextStyle(fontSize: 20, color: Colors.red,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
