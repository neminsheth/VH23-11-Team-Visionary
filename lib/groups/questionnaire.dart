import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_study_buddy/groups/groups.dart';
import 'package:virtual_study_buddy/home.dart';
import 'package:virtual_study_buddy/level/group_a.dart';

import '../colors.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _currentQuestionIndex = 0;
  String userEmail = "";
  Future<void> loadUserGroups() async {
    try {
      userGroups = await getGroupsForUser(userEmail);
      setState(() {});
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Do you enjoy studying in a group or individually?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Is there a specific area within your chosen field that you are interested about?',
      'options': ['Computer Vision' , 'NLP', 'Deep Learning' , 'Data Analysis'],
    },
    {
      'question': 'Are you open to exploring new resources recommended by your study group?',
      'options': ['Yes', 'No'],
    },
    {
      'question': 'Do you prefer to communicate with your study group',
      'options': ['Neutral' , 'Dislike', 'Enjoy Communicating'],
    },
    {
      'question': 'How do you prefer to give and receive feedback within a study group?',
      'options': ['Verbal' , 'Written'],
    },
    {
      'question': 'How interested are you on a scale of 1-10 in participating in any academic or extracurricular activities related to your field of study?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },
    {
      'question': 'How would you rate your ability to help others who are struggling with this subject?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },
    {
      'question': 'How confident are you in your knowledge of Python?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },
    {
      'question': 'Have you taken any advanced courses or have specialized knowledge in any particular aspect of Python ?',
      'options': ['Yes', 'No'],
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
    'question': 'What types of study resources do you find most helpful?',
    'options': ['TextBook' , 'Study Group', 'Peer Discussion', 'Online'],
    },
    {
      'question': 'How many hours per day are you comfortable dedicating to focused study?',
      'options': ['1' , '2', '3', '4', '5','6','7','8','9','10'],
    },
  ];
  String? _selectedAnswer;

  List<String?> selectedAnswers = [];
  List<String> userGroups = [];
  Map<String, dynamic> responseData = {
    "predictions": [
      {
        "classes": ["Advanced", "Beginner", "Intermediate"],
        "scores": [
          0.001683753449469805,
          0.9919021129608154,
          0.00641406886279583
        ]
      }
    ]
  };

  // String highestLabel = getHighestLabel(responseData);


  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        selectedAnswers.add(_selectedAnswer);
        _selectedAnswer = null;
      } else {
        // User has completed the questionnaire
        selectedAnswers.add(_selectedAnswer);
        print('Selected Answers: $selectedAnswers'); // Print selected answers

        // Call the predict function with the selected answers
        predict();

        printPredictionResponse(responseData);
        // Get the highest label as a string

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          setState(() {
            userEmail = user.email!;
            print(userEmail);
          });
        }

        String highestLabel = printHighestLabel(responseData);
        addUserToGroupChat(highestLabel, 'Welcome to the chat!', userEmail);
        // Use the returned label as needed
        print(
            'Highest Label: $highestLabel'); // Output: Highest Label: Advanced

        // Use the returned label as needed
        //print('Highest Label: $highestLabel');

        // Navigate to Groups.dart
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GroupPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                        primary: AppColors
                            .secondary, // Change this color to the color you desire
                      ),
                    ),
                  ],
                ),
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

  Future<void> predict() async {
    final Dio dio = Dio(BaseOptions(headers: {
      'Authorization':
          'Bearer ya29.a0AfB_byBr-B-SoGIGl36OhrRH4gFmWQdXwxOCI4wGPKOx_1nOx4x7Qc8p2GrOoQj4awmI0TkGcAWS6C-cTWbLG-MxZf5PHj1CI-zTcFhIr6ZkW7MVz9O-cJQsCuAySKq9IMaruYtbaXR2k07MTB3vgSEl-wLhnZruxrmpFoQKomYF5VKvwukdDnVn-3_8tbb2hq5xOX0c02f12WhurKckb15Kh3F2w9yjInKxEYDHHMpJlOC5eRdoEBi4U7-LbzWVysT00V1ltT2NBlxbLTX_outyfGyXQ85HXrPbAh9h4O-pNdZ96OKvev9jzIep-d4cdH347-Cp_UqRBMohBYjojH6qQzQvx-5pKYTN3JtgOvKwNXnoImUcrIP5RljcXV6GfKgUJ03nzCWST-eC0sQtEXWWfazZNKtZaCgYKAQcSARESFQGOcNnCt3MEcu6BFZYTWIuo4VYD3A0423',
    }));

    // Create a map to store the question keys and their corresponding user answers
    Map<String, dynamic> answersMap = {
      'Group': selectedAnswers[0],
      'Area': selectedAnswers[1],
      'exploration': selectedAnswers[2],
      'communication': selectedAnswers[3],
      'feedback': selectedAnswers[4],
      'extracurriculars': selectedAnswers[5],
      'help_others': selectedAnswers[6],
      'confidence': selectedAnswers[7],
      'adv_courses': selectedAnswers[8],
      'Colab': selectedAnswers[9],
      'Exp': selectedAnswers[10],
      'Resouce': selectedAnswers[11],
      'hours': selectedAnswers[12],
    };

    var instances = [answersMap];

    var requestData = jsonEncode({
      'instances': instances,
    });

    try {
      final response = await dio.post(
        'https://us-central1-aiplatform.googleapis.com/v1/projects/218438994727/locations/us-central1/endpoints/6617215018700111872:predict',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
        data: requestData,
      );
      print(response);

    } on DioError catch (e) {
      print(e.response?.toString() ?? 'Error occurred');
    }
  }
  void printPredictionResponse(Map<String, dynamic> responseData) {
    List<String> classes = responseData['predictions'][0]['classes'];
    List<double> scores = responseData['predictions'][0]['scores'];

    for (int i = 0; i < classes.length; i++) {
      print('${classes[i]}: ${scores[i]}');
    }
  }

  String printHighestLabel(Map<String, dynamic> responseData) {
    List<double> scores = responseData['predictions'][0]['scores'];

    double maxScore =
        scores.reduce((value, element) => value > element ? value : element);
    int maxIndex = scores.indexOf(maxScore);
    print(maxIndex);

    if (maxIndex == 0) {
      return 'Advanced';
      print('Advanced');
    } else if (maxIndex == 1) {
      return 'Beginner';
      print('Beginner');
    } else if (maxIndex == 2) {
      return 'Intermediate';
      print('Intermediate');
    } else {
      return 'Unknown'; // Handle other cases if necessary
    }
  }


  List<double> extractScores(String jsonStr) {
    // Parse the JSON string
    Map<String, dynamic> jsonData = json.decode(jsonStr);

    // Extract scores list from the JSON
    List<double> scores = List<double>.from(jsonData['predictions'][0]['scores']);

    // Return the scores list
    return scores;
  }

  void main() {
    String jsonString = '{"predictions":[{"classes":["Advanced","Beginner","Intermediate"],"scores":[0.9919021129608154,0.001683753449469805,0.00641406886279583]}]}';

    // Call the function and get the scores
    List<double> scores = extractScores(jsonString);

    // Print the scores
    print('Scores: $scores');
  }


}
class Prediction {
  final List<String> classes;
  final List<double> scores;

  Prediction({required this.classes, required this.scores});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    List<String> classes = List<String>.from(json['predictions'][0]['classes']);
    List<double> scores = List<double>.from(json['predictions'][0]['scores']);
    return Prediction(classes: classes, scores: scores);
  }
}

class PredictionsResponse {
  final List<Prediction> predictions;

  PredictionsResponse({required this.predictions});

  factory PredictionsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> predictionsJson = json['predictions'];
    List<Prediction> predictions = predictionsJson
        .map((predictionJson) => Prediction.fromJson(predictionJson))
        .toList();
    return PredictionsResponse(predictions: predictions);
  }
}

//{"predictions":[{"classes":["Advanced","Beginner","Intermediate"],"scores":[0.9919021129608154,0.001683753449469805,0.00641406886279583]}],
//[No, No, Yes, NLP, Neutral, 4, 2, TextBook, 3, 1, Verbal, Enjoy Communicating, 8]
//0.04733745008707047,0.0000817018881207332,0.9525808691978455
//ya29.a0AfB_byBe33abA4ndVLEXLmNMPM7cpOvl7pHM84HpfZ30sMpyRgRJl-qFpoL61mq-gqlpLI07qb4IMtmdgN1JMiykPZYnGRU1vh-51f38YmXjswvxyvmX5YVbazuiscqIkj6px0470ni4L9I4knnAmQtlcfE0wXc8qTf3tWJW3-vmwiRmH53c9armo7ROQgqbnnuWT_uywqumpgXKsZXnr8SL9IrmSCM6J2W5W40JcYrj851lnUJ07ghSIRcM7_Qjq6l40att2g0NZSOzav52RYwPAgiYyNwHGo8OgUK3UcV9uyy4Cpf9BTQXRUS-deqL53Gjt-2DkniN3DUqz5MvXli3wFY_1m8f2t2yMP3JsQRK--vY6ynP4k9kJ-AwqjS5jC4JlGGvFG8N1y4DMFonQAuKvWW2m5oaCgYKATkSARESFQGOcNnCB33aHh2q-4zDTHKs6mbHYw0422
