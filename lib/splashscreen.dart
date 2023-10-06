import 'dart:async';
import 'package:flutter/material.dart';
import 'package:virtual_study_buddy/auth/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the redirection process after the widget has been inserted into the tree
    _redirectToLogin();
  }

  // Redirect to the login screen after a delay
  void _redirectToLogin() {
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/icons/splash.png'), // Replace 'assets/splash_image.png' with your image path
      ),
    );
  }
}
