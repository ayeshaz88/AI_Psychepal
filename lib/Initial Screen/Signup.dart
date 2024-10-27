import 'package:ai_psychepal/Internal%20Screens/FadeAnimation.dart';
import 'package:ai_psychepal/Initial%20Screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Internal Screens/home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  late String email, password, name;
  bool isLoader = false;

  String gender = '';
  DateTime? selectedDate;
  bool isFeelingSad = false;
  bool isFeelingLonely = false;
  bool isFeelingAnxious = false;
  bool isFeelingStressed = false;
  bool isFeelingAngry = false;


  Future registerUser(String email, String pass) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passController.text.toString());
    await saveData(
      nameController.text.toString(),
      emailController.text.toString(),
      passController.text.toString(),

    ); // Pass the correct values here

    return user;
  }


  final formKey = GlobalKey<FormState>();

  Future<void> saveData(String userName, String userEmail, String userPassword) async {
    await FirebaseFirestore.instance.collection('users').add(
        {
          'userID': FirebaseAuth.instance.currentUser!.uid,
          'userEmail': userEmail, // Use the userEmail parameter here
          'userName': userName,
          'password': userPassword, // Use the userName parameter here
          'isApproved': false,
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Regular',
                          color: Color.fromARGB(
                              255, 19, 19, 73)
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style:
                      TextStyle(fontSize: 15, fontFamily: 'Poppins-Regular',color: Color.fromARGB(
                          255, 19, 19, 73)),
                    )
                  ],
                ),

                Column(
                  children: <Widget>[
                    FadeInAnimation(
                      delay: 0.2,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'UserName',
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 19, 19, 73),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a username.";
                          } else if (!RegExp(r'^[A-Z][a-z]*$').hasMatch(value)) {
                            return "Username should start with a capital letter and only contain alphabets.";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInAnimation(
                      delay: 0.2,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 19, 19, 73),
                            )),
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
                      delay: 0.2,
                      child: TextFormField(
                        obscureText: true,
                        controller: passController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInAnimation(
                      delay: 0.2,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 19, 19, 73),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password.";
                          } else if (value != passController.text) {
                            return "Passwords do not match.";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Get email and password from controllers
                      try {

                        await registerUser(
                        emailController.text.toString(),
                        passController.text.toString(),
                        );
                        // Create a new user with email and password

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Account created successfully!'),
                            duration: Duration(seconds: 3),
                          ),
                        );

                        // If registration is successful, navigate to HomeScreen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } catch (error) {
                        // Handle registration errors
                        if (error is FirebaseAuthException &&
                            error.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Email is already registered. Please log in.",
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );

                          // Navigate to the login page
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        } }

                        if (emailController.text.isEmpty || passController.text.isEmpty || nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill in all fields."),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          // Handle other registration errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Registration failed. Please try again.",
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },

                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Poppins-Regular'),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromARGB(255, 19, 19, 73),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?", style: TextStyle(fontFamily: 'Poppins-Regular',),),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          color: Color.fromARGB(255, 19, 19, 73),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
