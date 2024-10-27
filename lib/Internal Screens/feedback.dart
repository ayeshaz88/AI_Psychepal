import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedbackController = TextEditingController();
  bool _submitted = false;
  String _userEmail = '';


  @override
  void initState() {
    super.initState();
    // Fetch user details when the page loads
    _fetchUserData();
  }

  void _fetchUserData() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Set user email
      setState(() {
        _userEmail = user.email ?? ''; // Get user's email

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback', style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Regular'),),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(
            255, 19, 19, 73),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'We Value Your Feedback!',
                style: TextStyle(
                  fontFamily: 'Poppins-Regular',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter your feedback here...',
                  fillColor: Colors.grey.withOpacity(0.4),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _handleSubmitFeedback();
                },
                child: const Text('Submit Feedback', style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Regular',),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 19, 19, 73),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _submitted ? _buildFeedbackSubmittedMessage() : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitFeedback() async {
    String feedback = _feedbackController.text.trim();
    if (feedback.isNotEmpty) {

      // Save feedback to Firestore
      await FirebaseFirestore.instance.collection('feedback').add({

        'userEmail': _userEmail,
        'feedback': feedback,
        'timestamp': FieldValue.serverTimestamp(), // Optionally, include timestamp
      });

      setState(() {
        _submitted = true;
      });
      _showFeedbackSubmittedDialog(context);
    } else {
      _showNoFeedbackDialog(context);
    }
  }

  Widget _buildFeedbackSubmittedMessage() {
    return const Text(
      'Thank you for your feedback!',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
          fontFamily: 'Poppins-Regular'
      ),
    );
  }

  void _showFeedbackSubmittedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Feedback Submitted',
            selectionColor: Color.fromARGB(255, 19, 19, 73),
          ),
          content: const Text(
            'Thank you for your feedback!',
            selectionColor: Color.fromARGB(255, 19, 19, 73),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                selectionColor: Color.fromARGB(255, 19, 19, 73),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNoFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter your feedback before submitting.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                selectionColor: Color.fromARGB(255, 19, 19, 73),
              ),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FeedbackPage(),
  ));
}