import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';


class PythonQuizPage extends StatefulWidget {
  @override
  _PythonQuizPageState createState() => _PythonQuizPageState();
}

class _PythonQuizPageState extends State<PythonQuizPage> {
  int _currentQuestionIndex = 0;
  List<String> _selectedOptions = [];
  int _score = 0;


  List<Map<String, dynamic>> _questions = [
    {
      'question': 'Which of the following is not a valid way to open a file in Python?',
      'options': ['A. file = open("myfile.txt", "w)', 'B. file = open("myfile.txt", "rb")', 'C. file = open("myfile.txt", "x")', 'D. file = open("myfile.txt", "rt")'],
      'correctAnswer': 'C',
    },
    {
      'question': 'What is the purpose of the __init__ method in a Python class?',
      'options': ['A. To create an instance of the class.', 'B. To initialize class variables.', 'C. To define instance variables.', 'D. To destroy an instance of the class.'],
      'correctAnswer': 'B',
    },
    {
      'question': 'In Python, which data structure is commonly used to implement a stack?',
      'options': ['A. List', 'B. Tuple', 'C. Set', 'D. Dictionary'],
      'correctAnswer': 'A',
    },
    {
      'question': 'What is the purpose of the if statement in Python?',
      'options': ['A. To define a function', 'B. To create a loop', 'C. To make decisions based on conditions', 'D. To print text to the console'],
      'correctAnswer': 'C',
    },
    {
      'question': 'What does the len() function in Python do?',
      'options': ['A. Returns the largest number in a list', 'B. Returns the length of a string or list', 'C. Checks if a variable is empty', 'D. Converts a string to lowercase'],
      'correctAnswer': 'B',
    },
    {
      'question': 'What is the correct way to check if two variables, a and b, are equal in Python?',
      'options': ['A. a == b', 'B. a = b', 'C. a != b', 'D. a is b'],
      'correctAnswer': 'A',
    },
    {
      'question': 'Which of the following is NOT a valid Python data type?',
      'options': ['A. List', 'B. Tuple', 'C. Dictionary', 'D. Integer'],
      'correctAnswer': 'D',
    },
    {
      'question': 'Which of the following statements is used to exit a loop prematurely in Python?',
      'options': ['A. stop', 'B. exit', 'C. break', 'D. continue'],
      'correctAnswer': 'C',
    },
    {
      'question': 'What does the int() function in Python do?',
      'options': ['A. It converts a string to an integer.', 'B. It finds the maximum value in a list.', 'C. It calculates the square root of a number.', 'D. It rounds a floating-point number to the nearest integer.'],
      'correctAnswer': 'A',
    },
    {
      'question': 'In Python, how do you define a list containing integers from 1 to 5 (inclusive)?',
      'options': ['A. list = [1, 2, 3, 4, 5]', 'B. list(1, 5)', 'C. list = range(1, 6)', 'D. list = (1, 2, 3, 4, 5)'],
      'correctAnswer': 'A',
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
      'python': _score,
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
