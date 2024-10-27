import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Regular',),),
        backgroundColor: Color.fromARGB(
            255, 19, 19, 73),        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSectionTitle('Welcome to AI Psychiatrist'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'AI Psychiatrist is committed to delivering personalized and easily accessible mental health assistance to people globally. Through the integration of artificial intelligence and mindfulness practices, our platform aims to foster emotional stability and fortify mental strength.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ),
            _buildSectionTitle('Our Mission'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "At AI Psychiatrist, our goal is to empower individuals to take control of their mental well-being and lead fulfilling lives. By harnessing cutting-edge technologies and providing compassionate support, we strive to foster a nurturing environment where individuals can seek guidance, discover inner strength, and embark on a journey of self-discovery.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ),
            _buildSectionTitle('Get Started Today'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Hello! I'm here to assist you on your journey towards better mental health. Let's work together to achieve emotional well-being and resilience.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins-Regular',
          color: Color.fromARGB(
              255, 19, 19, 73),        ),
      ),
    );
  }
}
