import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HtmlCssQuizPage extends StatefulWidget {
  @override
  _HtmlCssQuizPageState createState() => _HtmlCssQuizPageState();
}

class _HtmlCssQuizPageState extends State<HtmlCssQuizPage> {
  int _currentQuestionIndex = 0;
  List<String> _selectedAnswers = [];
  int _score = 0;

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What does HTML stand for?',
      'options': ['a) Hyper Transfer Markup Language', 'b) Hyper Text Markup Language', 'c) Hyperlink and Text Markup Language', 'd) High-Level Text Markup Language'],
      'correctAnswer': 'b) Hyper Text Markup Language',
    },
    {
      'question': 'Which HTML tag is used to define an unordered list?',
      'options': ['a) <ul>', 'b) <ol>', 'c) <li>', 'd) <dl>'],
      'correctAnswer': 'a) <ul>',
    },
    {
      'question': 'What is the correct way to link an external CSS file to an HTML document?',
      'options': ['a) <link href="style.css" rel="stylesheet">', 'b) <style src="style.css">', 'c) <css href="style.css">', 'd) <stylesheet>style.css</stylesheet>'],
      'correctAnswer': 'a) <link href="style.css" rel="stylesheet">',
    },
    {
      'question': 'Which CSS property is used to change the text color of an element?',
      'options': ['a) text-color', 'b) font-color', 'c) color', 'd) text-style'],
      'correctAnswer': 'c) color',
    },
    {
      'question': 'How can you center-align an element horizontally in CSS?',
      'options': ['a) text-align: center;', 'b) align: center;', 'c) horizontal-align: center;', 'd) center-align: horizontal;'],
      'correctAnswer': 'a) text-align: center;',
    },
    {
      'question': 'Which HTML tag is used for creating a hyperlink?',
      'options': ['a) <link>', 'b) <href>', 'c) <a>', 'd) <hyperlink>'],
      'correctAnswer': 'c) <a>',
    },
    {
      'question': 'What does CSS stand for?',
      'options': ['a) Creative Style Sheets', 'b) Computer Style Sheets', 'c) Cascading Style Sheets', 'd) Colorful Style Sheets'],
      'correctAnswer': 'c) Cascading Style Sheets',
    },
    {
      'question': 'Which HTML element is used for creating a line break?',
      'options': ['a) <br>', 'b) <lb>', 'c) <newline>', 'd) <linebreak>'],
      'correctAnswer': 'a) <br>',
    },
    {
      'question': 'What is the correct way to comment out multiple lines of code in CSS?',
      'options': ['a) <!-- This is a comment -->', 'b) /* This is a comment */', 'c) // This is a comment //', 'd) <!-- This is a comment //'],
      'correctAnswer': 'b) /* This is a comment */',
    },
    {
      'question': 'Which CSS property is used to control the spacing between the border and the content of an element?',
      'options': ['a) margin', 'b) padding', 'c) border-spacing', 'd) spacing'],
      'correctAnswer': 'b) padding',
    },
  ];

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedAnswers.add('');
      } else {
        // User has completed the quiz
        // Calculate score
        _calculateScore();
        // Show the score in a dialog
        _showScoreDialog();
      }
    });
  }

  void _calculateScore() {
    _score = 0;
    for (int i = 0; i < _questions.length; i++) {
      String selectedOption = _selectedAnswers[i];
      String correctAnswer = _questions[i]['correctAnswer'];

      // Extract the prefix letter from the selected option
      String selectedPrefix = selectedOption.substring(0, 2);

      if (selectedPrefix == correctAnswer.substring(0, 2)) {
        _score++;
      }
    }
  }

  void _showScoreDialog() async {
    // Get the current user ID (assuming the user is logged in)
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the "Students" collection in Firestore
    CollectionReference students = FirebaseFirestore.instance.collection('Students');

    // Save HTML and CSS quiz score to Firestore
    await students.doc(userId).set({
      'htmlCss': _score,
    }, SetOptions(merge: true)); // Merge the data if the document already exists

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed'),
          content: Text('Your Score: $_score out of ${_questions.length}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _selectedAnswers = List.generate(_questions.length, (index) => '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _questions[_currentQuestionIndex]['question'] as String,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: (_questions[_currentQuestionIndex]['options'] as List<String>).map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _selectedAnswers[_currentQuestionIndex],
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAnswers[_currentQuestionIndex] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedAnswers[_currentQuestionIndex].isNotEmpty ? _nextQuestion : null,
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Html and CSS Quiz',
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

