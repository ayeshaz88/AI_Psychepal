import 'package:ai_psychepal/Internal%20Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _previousPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  Future<void> _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No user logged in.'),
        ),
      );
      return;
    }

    try {
      // Re-authenticate the user with the previous password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _previousPasswordController.text.trim(),
      );

      await user.reauthenticateWithCredential(credential);

      // Update email if changed
      if (_emailController.text.trim().isNotEmpty && _emailController.text.trim() != user.email) {
        await user.updateEmail(_emailController.text.trim());
      }

      // Update password if changed and confirmed
      if (_newPasswordController.text.trim().isNotEmpty &&
          _newPasswordController.text.trim() == _confirmNewPasswordController.text.trim()) {
        await user.updatePassword(_newPasswordController.text.trim());
      }

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully.'),
        ),
      );
    } catch (error) {
      print('Error updating profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                          "Update Profile",
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 19, 19, 73),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Change Credentials",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins-Regular',
                            color: Color.fromARGB(255, 19, 19, 73),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        TextField(
                          controller: _emailController,
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
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _previousPasswordController,
                          decoration: InputDecoration(
                            hintText: "Previous Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Color.fromARGB(255, 19, 19, 73),
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _newPasswordController,
                          decoration: InputDecoration(
                            hintText: "New Password",
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
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _confirmNewPasswordController,
                          decoration: InputDecoration(
                            hintText: "Confirm New Password",
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
                          obscureText: true,
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 3, left: 3),
                        child: ElevatedButton(
                          onPressed: _updateProfile,
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins-Regular',
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Color.fromARGB(255, 19, 19, 73),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
