import 'package:flutter/material.dart';

class DbmsQuizPage extends StatefulWidget {
  @override
  _DbmsQuizPageState createState() => _DbmsQuizPageState();
}

class _DbmsQuizPageState extends State<DbmsQuizPage> {
  int _currentQuestionIndex = 0;
  List<String> _selectedAnswers = [];

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
        // Calculate score or navigate to the next page
        print('Selected Answers: $_selectedAnswers');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List.generate(_questions.length, (index) => '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DBMS Quiz'),
      ),
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
                int index = (_questions[_currentQuestionIndex]['options'] as List<String>).indexOf(option);
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
}
