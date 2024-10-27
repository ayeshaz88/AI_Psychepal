import 'dart:async';

import 'package:ai_psychepal/Internal%20Screens/FadeAnimation.dart';
import 'package:ai_psychepal/OnboardingScreens/GetStarted.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    // Simulating a delay for 3 seconds before navigating to the next screen
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GetStarted(
            key: UniqueKey(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(

            decoration: BoxDecoration(
              image: DecorationImage(

                image: AssetImage("assets/images/ai.gif",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          // Loading indicator
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Text(
                '',    // add text if you want
                style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily:
                'Poppins-Regular', // Specify your desired font family here
              ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
