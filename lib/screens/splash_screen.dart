import 'dart:async';

import 'package:ai_bot/wigtes/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2), () {
      setState(() {
        isVisible = true;
      });
  });
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    return Scaffold(
      body:  SafeArea(
          child: Center(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
            Icon(Icons.emoji_emotions_rounded,size: mqData.size.height * 0.2, weight: 20, color: Colors.blue,),
            SizedBox(height: mqData.size.height * 0.2,),
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: isVisible ? 1.0 : 0.0,
              child: Text("Chat Bot",
              style: mTextStyle25(
                fontColor: Colors.blue,
                fontWeight: FontWeight.bold,
              ),),
            )
                    ],
                  ),
          )),
    );
  }
}