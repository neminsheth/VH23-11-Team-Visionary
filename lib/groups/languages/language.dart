import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'cloud.dart';
import 'dbms.dart';
import 'htmlandcss.dart';
import 'javascript.dart';
import 'python.dart'; // Import the PythonPage widget

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButtonWidget('Python', Colors.blue, () {
              // Navigate to PythonPage when Python button is pressed
              Navigator.push(context, MaterialPageRoute(builder: (context) => PythonQuizPage()));
            }),
            SizedBox(height: 10),
            ElevatedButtonWidget('Javascript', Colors.green, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => JavaScriptQuizPage()));
              print('Selected Language: Java');
            }),
            SizedBox(height: 10),
            ElevatedButtonWidget('HTML and CSS', Colors.orange, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HtmlCssQuizPage()));
              print('Selected Language: C');
            }),
            SizedBox(height: 10),
            ElevatedButtonWidget('DBMS', Colors.yellow, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DbmsQuizPage()));
              print('Selected Language: JavaScript');
            }),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Tech Stacks',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  ElevatedButtonWidget(this.text, this.color, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
