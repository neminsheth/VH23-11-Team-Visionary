import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DbmsQuizPage extends StatefulWidget {
  @override
  _DbmsQuizPageState createState() => _DbmsQuizPageState();
}

class _DbmsQuizPageState extends State<DbmsQuizPage> {
  int _currentQuestionIndex = 0;
  List<String> _selectedAnswers = [];
  int _score = 0;

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What does DBMS stand for?',
      'options': ['a) Database Management System', 'b) Data Backup and Management System', 'c) Digital Business Management System', 'd) Dynamic Database System'],
      'correctAnswer': 'a) Database Management System',
    },
    {
      'question': 'Which DBMS model represents data as tables with rows and columns?',
      'options': ['a) Hierarchical', 'b) Network', 'c) Relational', 'd) Object-Oriented'],
      'correctAnswer': 'c) Relational',
    },
    {
      'question': 'Which SQL command is used to retrieve data from a database table?',
      'options': ['a) UPDATE', 'b) DELETE', 'c) INSERT', 'd) SELECT'],
      'correctAnswer': 'd) SELECT',
    },
    {
      'question': 'Which type of key uniquely identifies a row within a relational database table?',
      'options': ['a) Primary Key', 'b) Foreign Key', 'c) Composite Key', 'd) Candidate Key'],
      'correctAnswer': 'a) Primary Key',
    },
    {
      'question': 'In a relational database, what is the purpose of normalization?',
      'options': ['a) Reducing data redundancy', 'b) Increasing data redundancy', 'c) Speeding up query performance', 'd) Simplifying data retrieval'],
      'correctAnswer': 'a) Reducing data redundancy',
    },
    {
      'question': 'Which SQL clause is used to filter rows returned by a SELECT statement?',
      'options': ['a) FROM', 'b) WHERE', 'c) GROUP BY', 'd) HAVING'],
      'correctAnswer': 'b) WHERE',
    },
    {
      'question': 'What does ACID stand for in the context of database transactions?',
      'options': ['a) Atomicity, Consistency, Isolation, Durability', 'b) Authentication, Control, Isolation, Data', 'c) Availability, Consistency, Isolation, Durability', 'd) Atomicity, Control, Isolation, Data'],
      'correctAnswer': 'a) Atomicity, Consistency, Isolation, Durability',
    },
    {
      'question': 'Which type of join returns only the rows that have matching values in both tables?',
      'options': ['a) INNER JOIN', 'b) LEFT JOIN', 'c) RIGHT JOIN', 'd) FULL OUTER JOIN'],
      'correctAnswer': 'a) INNER JOIN',
    },
    {
      'question': 'What is the purpose of the SQL statement DELETE in a DBMS?',
      'options': ['a) Insert new records into a table', 'b) Update existing records in a table', 'c) Remove rows from a table', 'd) Retrieve data from a table'],
      'correctAnswer': 'c) Remove rows from a table',
    },
    {
      'question': 'Which type of index is typically used to speed up the retrieval of rows based on a specific column value?',
      'options': ['a) Primary Index', 'b) Clustered Index', 'c) Non-clustered Index', 'd) Composite Index'],
      'correctAnswer': 'c) Non-clustered Index',
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
      'dbms': _score,
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
        'DBMS Quiz',
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



