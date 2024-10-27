import 'package:ai_psychepal/OnboardingScreens/SplashScreen.dart';
import 'package:ai_psychepal/Internal%20Screens/feedback.dart';
import 'package:ai_psychepal/Internal%20Screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Initial Screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Psychologist',
      theme: ThemeData(
        primaryColor: Color(002664),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define routes for navigation
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/feedback': (context) => FeedbackPage()
      },
    );
  }
}
