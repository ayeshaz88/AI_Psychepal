import 'package:ai_psychepal/Internal%20Screens/AboutPage.dart';
import 'package:ai_psychepal/Internal%20Screens/ClearConversation.dart';
import 'package:ai_psychepal/OnboardingScreens/GetStarted.dart';
import 'package:ai_psychepal/Internal%20Screens/UpdateProfile.dart';
import 'package:ai_psychepal/Internal%20Screens/ViewHistory.dart';
import 'package:ai_psychepal/Internal%20Screens/feedback.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  get animation => animation;

  final List<String> screenNames = [

    'Feedback',
    'About',
    'Change Credentials',
    'View History',
    'Clear Conversation',
    'Logout'
  ];

  final List<IconData> screenIcons = [
    Icons.feedback,
    Icons.info,
    Icons.lock,
    Icons.history,
    Icons.clear,
    Icons.logout
  ];

  final List<Widget> screens = [
    FeedbackPage(),
    AboutPage(),
    const UpdateProfile(),
    ViewHistory(),
    ClearConversation(),

    GetStarted(
      key: UniqueKey(),
    ),

    // Add other screens here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Regular',),),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(
            255, 19, 19, 73),
        ),
      backgroundColor: Colors.white,
      // Light purple background color
      body: ListView.builder(
        itemCount: screenNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(screenIcons[index]),
            title: Text(screenNames[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screens[index]),
              );
            },
          );
        },
      ),
    );
  }
}
