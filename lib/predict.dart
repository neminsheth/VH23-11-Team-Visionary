import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CareerPredictionPage extends StatefulWidget {
  @override
  _CareerPredictionPageState createState() => _CareerPredictionPageState();
}

class _CareerPredictionPageState extends State<CareerPredictionPage> {
  String prediction = '';

  Future<void> predictCareerFromFirebase() async {
    // Retrieve data from the Firebase collection "Students"
    final QuerySnapshot<Map<String, dynamic>> studentsSnapshot =
    await FirebaseFirestore.instance.collection('Students').get();

    // Assuming each student document has fields: 'python', 'javascript', 'dbms', 'htmlCss'
    int pythonMarks = 0;
    int javascriptMarks = 0;
    int dbmsMarks = 0;
    int htmlCssMarks = 0;

    for (QueryDocumentSnapshot<Map<String, dynamic>> student in studentsSnapshot.docs) {
      pythonMarks += (student.data()!['python'] ?? 0) as int;
      javascriptMarks += (student.data()!['javascript'] ?? 0) as int;
      dbmsMarks += (student.data()!['dbms'] ?? 0) as int;
      htmlCssMarks += (student.data()!['htmlCss'] ?? 0) as int;
    }



    // Calculate average marks (assuming all students have the same weight)
    int totalStudents = studentsSnapshot.size;
    pythonMarks ~/= totalStudents;
    javascriptMarks ~/= totalStudents;
    dbmsMarks ~/= totalStudents;
    htmlCssMarks ~/= totalStudents;

    // Predict career based on average marks
    setState(() {
      prediction = predictCareer(pythonMarks, javascriptMarks, dbmsMarks, htmlCssMarks);
    });
  }

  String predictCareer(int pythonMarks, int javascriptMarks, int dbmsMarks, int htmlCssMarks) {
    // Implement your prediction logic here
    // ...

    if ((pythonMarks >= 5 && pythonMarks <= 10) &&
        (javascriptMarks >= 1 && javascriptMarks <= 5) &&
        (dbmsMarks >= 5 && dbmsMarks <= 10) &&
        (htmlCssMarks == 1 || htmlCssMarks == 5)) {
      return 'Analyst';
    } else if ((pythonMarks >= 1 && pythonMarks <= 5) &&
        (javascriptMarks >= 5 && javascriptMarks <= 10) &&
        (dbmsMarks >= 5 && dbmsMarks <= 10) &&
        (htmlCssMarks == 1 || htmlCssMarks == 5)) {
      return 'Software Developer';
    } else {
      return 'Cloud Engineer';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Career Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: predictCareerFromFirebase,
              child: Text('Predict Career from Firebase Data'),
            ),
            SizedBox(height: 20),
            Text(
              'Predicted Career: $prediction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
