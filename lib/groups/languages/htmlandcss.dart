import 'package:flutter/material.dart';

class HtmlCssQuizPage extends StatefulWidget {
  @override
  _HtmlCssQuizPageState createState() => _HtmlCssQuizPageState();
}

class _HtmlCssQuizPageState extends State<HtmlCssQuizPage> {
  int _currentQuestionIndex = 0;
  List<String> _selectedAnswers = [];

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
        title: Text('HTML and CSS Quiz'),
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
