import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_study_buddy/colors.dart';
import 'package:virtual_study_buddy/home.dart';
import 'package:virtual_study_buddy/auth/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to the next screen upon successful login
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/background.png'), // Replace with your background image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Center(

          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 350,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true, // Hide password
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          final String email = _emailController.text.trim();
                          final String password = _passwordController.text.trim();
                          _signInWithEmailAndPassword(email, password);
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0), // Add spacing
                TextButton(
                  onPressed: () {
                    // Navigate to the registration screen when the button is pressed
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    'Click here to sign up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
