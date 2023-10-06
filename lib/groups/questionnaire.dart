import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_study_buddy/groups/groups.dart';
import 'package:virtual_study_buddy/home.dart';

import '../colors.dart';


class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _currentQuestionIndex = 0;
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'Are you open to exploring new resources recommended by your study group?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Have you taken any advanced courses or have specialized knowledge in any particular aspect of Python ?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Do you enjoy studying in a group or individually?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Is there a specific area within your chosen field that you are interested about?',
      'options': ['Computer Vision' , 'NLP', 'Deep Learning' , 'Data Analysis'],
    },
    {
    'question': 'How do you feel about collaborative group projects?',
    'options': ['Highly Collaborative,' , 'Neutral', 'Independent'],
    },
    {
      'question': 'How many years have you been studying the subject?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },
    {
      'question': 'How would you rate your ability to help others who are struggling with this subject?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },
    {
    'question': 'What types of study resources do you find most helpful?',
    'options': ['TextBook' , 'Study Group', 'Peer Discussion', 'Online'],
    },
    {
      'question': 'How interested are you on a scale of 1-10 in participating in any academic or extracurricular activities related to your field of study?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },
    {
      'question': 'How confident are you in your knowledge of Python?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },
    {
      'question': 'How do you prefer to give and receive feedback within a study group?',
      'options': ['Verbal' , 'Written'],
    },
    {
      'question': 'Do you prefer to communicate with your study group',
      'options': ['Neutral' , 'Dislike', 'Enjoy Communicating', '4', '5','6','7','8','9','10'],
    },
    {
      'question': 'How many hours per day are you comfortable dedicating to focused study?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },







  ];
  String? _selectedAnswer;

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      } else {
        // User has completed the questionnaire
        // You can navigate to another screen or show a completion message
        print('Questionnaire completed!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
              children: _questions[_currentQuestionIndex]['options']
                  .map<Widget>((option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedAnswer,
                onChanged: (String? value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedAnswer != null ? _nextQuestion : null,
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                primary: AppColors.secondary, // Change this color to the color you desire
              ),
            ),
          ],
        ),
      ),
    );
  }
  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 25,
            width: 25,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      title: const Text(
        'Notes!',
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
