import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';


class JavaScriptQuizPage extends StatefulWidget {
  @override
  _JavaScriptQuizPageState createState() => _JavaScriptQuizPageState();
}

class _JavaScriptQuizPageState extends State<JavaScriptQuizPage> {
  int _currentQuestionIndex = 0;
  List<String> _selectedOptions = [];
  int _score = 0;


  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What does the `var` keyword do in JavaScript?',
      'options': ['a) Declares a constant variable', 'b) Declares a global variable', 'c) Declares a block-scoped variable', 'd) Declares a local variable'],
      'correctAnswer': 'b',
    },
    {
      'question': 'Which of the following is a valid way to comment out a single line of code in JavaScript?',
      'options': ['a) // This is a comment', 'b) /* This is a comment */', 'c) <!-- This is a comment -->', 'd) # This is a comment'],
      'correctAnswer': 'a',
    },
    {
      'question': 'What method is used to add an element to the end of an array in JavaScript?',
      'options': ['a) push()', 'b) unshift()', 'c) append()', 'd) insert()'],
      'correctAnswer': 'a',
    },
    {
      'question': 'What is the purpose of the `bind()` method in JavaScript?',
      'options': ['a) To create a new function with a specified context and initial arguments', 'b) To merge two arrays into a single array', 'c) To add a new property to an object', 'd) To remove an element from an array'],
      'correctAnswer': 'a',
    },
    {
      'question': 'How can you declare a constant variable in JavaScript?',
      'options': ['a) Using the `let` keyword', 'b) Using the `var` keyword', 'c) Using the `const` keyword', 'd) Constants are automatically created'],
      'correctAnswer': 'c',
    },


    {
      'question': 'What is the purpose of the `JSON.parse()` method in JavaScript?',
      'options': ['a) To stringify a JavaScript object', 'b) To parse a JSON string into a JavaScript object', 'c) To format a JavaScript object as JSON', 'd) To encode a JavaScript object as a URL parameter'],
      'correctAnswer': 'b',
    },
    {
      'question': 'What is a closure in JavaScript?',
      'options': ['a) A way to securely store sensitive data', 'b) A function that has access to variables from its containing function', 'c) A way to create private variables in JavaScript', 'd) A built-in JavaScript module for handling async operations'],
      'correctAnswer': 'b',
    },
    {
      'question': 'Which operator is used for strict equality comparison in JavaScript?',
      'options': ['a) ==', 'b) ===', 'c) =', 'd) !='],
      'correctAnswer': 'b',
    },
    {
      'question': 'What is the purpose of the JavaScript Array.isArray() method?',
      'options': ['a) To check if an object is an instance of the Array class', 'b) To check if a variable is declared as an array', 'c) To determine if an array contains only numbers', 'd) To check if an object is empty'],
      'correctAnswer': 'a',
    },
    {
      'question': 'Which statement is used to exit a loop prematurely in JavaScript?',
      'options': ['a) break;', 'b) exit;', 'c) continue;', 'd) return;'],
      'correctAnswer': 'a',
    },

  ];

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOptions.add('');
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
      String selectedOption = _selectedOptions[i];
      String correctAnswer = _questions[i]['correctAnswer'];

      // Extract the prefix letter from the selected option
      String selectedPrefix = selectedOption.substring(0, 1);

      if (selectedPrefix == correctAnswer) {
        _score++;
      }
    }
  }


  void _showScoreDialog() async {
    // Get the current user ID (assuming the user is logged in)
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the "Students" collection in Firestore
    CollectionReference students = FirebaseFirestore.instance.collection('Students');

    // Save Python quiz score to Firestore
    await students.doc(userId).set({
      'javascript': _score,
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
    _selectedOptions = List.generate(_questions.length, (index) => '');
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
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: (_questions[_currentQuestionIndex]['options'] as List<String>).map<Widget>((option) {
                int index = (_questions[_currentQuestionIndex]['options'] as List<String>).indexOf(option);
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _selectedOptions[_currentQuestionIndex],
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOptions[_currentQuestionIndex] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedOptions[_currentQuestionIndex].isNotEmpty ? _nextQuestion : null,
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
        'Python Quiz',
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
