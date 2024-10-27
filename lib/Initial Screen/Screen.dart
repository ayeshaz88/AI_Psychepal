import 'package:flutter/material.dart';


class FullScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: UpperCurveClipper(),
                    child: Container(
                      color: Colors.white, // Adjust the color as needed
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55, // Adjust the height as needed
                      child: Transform.scale(
                        scale: 0.8, // Adjust the scale factor as needed (0.0 to 1.0 for zooming out)
                        child: Image.asset(
                          'assets/images/login.gif',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  ),

                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 19, 19, 73),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                         Container(
                        decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.deepPurple.withOpacity(0.8),
                            Colors.purple.withOpacity(0.6)
                          ],
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _buildAnimatedParagraph(
                              'AI Psychiatrist is dedicated to providing accessible and personalized mental health support to individuals worldwide. Our platform leverages the power of artificial intelligence and mindfulness techniques to promote emotional well-being and enhance mental resilience.',
                            ),
                            _buildAnimatedParagraph(
                              "Our mission at AI Psychiatrist is to empower individuals to proactively manage their mental health and live fulfilling lives. Through innovative technologies and compassionate care, we aim to create a supportive community where individuals can seek guidance, find solace, and embark on a journey of self-discovery.",
                            ),
                            _buildAnimatedParagraph(
                              'Take the first step towards improving your mental well-being by joining AI Psychiatrist today. Together, we can embark on a transformative journey towards a happier, healthier you.',
                            ),
                          ],
                        ),
                      ),
                                        ),
                                ]
                                )
                        ),
                    )
        ]


                      ),
                    ),
                  );

  }),
            );

        }


  }


Widget _buildAnimatedParagraph(String text) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}



class UpperCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.55);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.55);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.5, size.width, size.height * 0.55);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
