import 'package:ai_psychepal/Internal%20Screens/FadeAnimation.dart';
import 'package:ai_psychepal/Initial%20Screen/Signup.dart';
import 'package:ai_psychepal/Internal%20Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ForgetPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    try {
      // Sign in the user with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Show a snackbar to inform the user that login was successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
        ),
      );

      // Navigate to the home screen after successful login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      // Handle login errors
      print('Login error: $error');
      // Check if the error is due to email not registered
      if (error is FirebaseAuthException && error.code == 'user-not-found') {
        // Show a snackbar to inform the user that the email is not registered
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email is not registered. Please sign up.'),
          ),
        );
      } if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please fill in all fields."),
            duration: Duration(seconds: 3),
          ),
        );
      }
      else {
        // Show a generic error message for other login errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please try again.'),
          ),
        );
      }
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
              SizedBox(height: 60,),
              Expanded(
                child: SingleChildScrollView(
                child: _inputField(context),
              ),
              ),
              _forgotPassword(context),
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
        SizedBox(height: 40.0),
        Text(
          "Welcome Back",
          style: TextStyle(
              fontFamily: 'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(
                255, 19, 19, 73)),
          ),

        SizedBox(height: 20),
        Text(
          "login to start your session",
          style: TextStyle(fontSize: 15, fontFamily: 'Poppins', color: Color.fromARGB(
              255, 19, 19, 73)
          ),
        )
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        FadeInAnimation(
          delay: 1.8,
          child: TextFormField(
            controller: _emailController,
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
                  r'^([a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$)')
                  .hasMatch(value)) {
                return "Invalid email format.";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        const SizedBox(height: 20),
        FadeInAnimation(
          delay: 1.8,
          child: TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(
                Icons.lock,
                color: Color.fromARGB(255, 19, 19, 73),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a password.";
              } else if (value.length < 8 &&
                  value.toString() != 'admin') {
                return "Password must be at least 8 characters long.";
              } else if (!RegExp(
                  r'^((?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).*$)')
                  .hasMatch(value)) {
                return "Password must contain uppercase, lowercase, and digits.";
              }
              return null;
            },
            autovalidateMode:
            AutovalidateMode.onUserInteraction,
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            // Call the login method here
            login();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 19, 19, 73),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),

      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Forget())
        );

      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(
          fontFamily: 'Poppins-Regular',
          color: Color.fromARGB(255, 19, 19, 73),
        ),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? ",style: TextStyle(
          color: Color.fromARGB(255, 19, 19, 73),
      fontFamily: 'Poppins-Regular',) ),
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
              ),
            )
      ],
    );
  }
}
