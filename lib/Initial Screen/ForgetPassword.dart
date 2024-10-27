import 'package:ai_psychepal/Internal%20Screens/FadeAnimation.dart';
import 'package:ai_psychepal/Initial%20Screen/Signup.dart';
import 'package:ai_psychepal/Initial%20Screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  _ForgetState createState() => _ForgetState();
}
class _ForgetState extends State<Forget> {

  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendPasswordResetEmail() async {
    try {
      // Attempt to send the password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      // If no exception is thrown, the password reset email has been sent successfully.
      // Show a snackbar to inform the user that the email has been sent.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email has been sent.'),
        ),
      );

      // Navigate to the login page
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    } on FirebaseAuthException catch (error) {
      // Handle FirebaseAuthException errors
      print('FirebaseAuthException occurred: $error');
      String errorMessage = 'Error sending password reset email.';
      if (error.code == 'user-not-found') {
        errorMessage = 'Email is not registered.';
      } else {
        errorMessage = 'Error occurred: ${error.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    } catch (error) {
      // Handle other errors
      print('Error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending password reset email.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),

              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return const Column(
      children: <Widget>[
        SizedBox(height: 60.0),
        Text(
          "Forget Password?",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
                fontFamily:
                'Poppins-Regular', // Specify your desired font family here
              color: Color.fromARGB(
                  255, 19, 19, 73)
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Enter Email linked with your account",
          style: TextStyle(fontSize: 15,
              fontFamily:
              'Poppins-Regular',
              color: Color.fromARGB(
              255, 19, 19, 73,
              // Specify your desired font family here

          )),
        )
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        FadeInAnimation(
          delay: 1.8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(
                Icons.email,
                color: Color.fromARGB(255, 19, 19, 73),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email address.";
              } else if (!RegExp(
                r'^([a-zA-Z0-9.!#$%&+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$)',
              ).hasMatch(value)) {
                return "Invalid email format.";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),

        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            _sendPasswordResetEmail();
          },
          // Call the login method here
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 19, 19, 73),
          ),
          child: const Text(
            "Send Link",
            style: TextStyle(fontSize: 20,
                color: Colors.white,
            fontFamily: 'Poppins-Regular'),
          ),
        )
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(fontFamily: 'Poppins-Regular',color: Color.fromARGB(
        255, 19, 19, 73))),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignupPage()));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontFamily: 'Poppins-Regular',
                color: Color.fromARGB(255, 19, 19, 73),
              ),
            ))
      ],
    );
  }
}
