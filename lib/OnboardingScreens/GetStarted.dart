import 'package:ai_psychepal/Initial%20Screen/Signup.dart';
import 'package:flutter/material.dart';
import '../Initial Screen/Screen.dart';
import '../Initial Screen/login.dart'; // Import the login.dart file where the login page is defined

class GetStarted extends StatelessWidget {
  const GetStarted({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width, // Set width to screen width
          height: MediaQuery.of(context).size.height, // Set height to screen heigh
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ Color.fromARGB(
                  255, 19, 19, 73), Color(0xFF1F1F5F)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset(
                  "assets/images/robot.png",
                  width: 450,
                  height: 450,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Need someone to talk to? \n Start chatting with Psychepal!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Regular',
                  // Use the default font family
                  // Specify your desired font family here
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500), // Adjust the duration as needed
                  pageBuilder: (_, __, ___) => SignupPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOutBack, // Adjust the curve as needed
                        ),
                      ),
                      child: child,
                    );
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                color: Colors.white,
                  fontFamily: 'Poppins-Regular'
              ),
            ),
          ),


                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          // Use the default font family
                          fontFamily:
                          'Poppins-Regular', // Specify your desired font family here
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(),));
                        },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white, fontSize: 14,
                              fontWeight: FontWeight.bold,
                              // Use the default font family
                              fontFamily:
                              'Poppins-Regular', // Specify your desired font family here
                            ),
                          ),
                        ),

                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
