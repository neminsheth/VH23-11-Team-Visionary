import 'package:flutter/material.dart';

class CareerPredictionPage extends StatefulWidget {
  @override
  _CareerPredictionPageState createState() => _CareerPredictionPageState();
}

class _CareerPredictionPageState extends State<CareerPredictionPage> {
  final TextEditingController pythonController = TextEditingController();
  final TextEditingController javascriptController = TextEditingController();
  final TextEditingController dbmsController = TextEditingController();
  final TextEditingController htmlCssController = TextEditingController();

  String prediction = '';

  String predictCareer(int pythonMarks, int javascriptMarks, int dbmsMarks, int htmlCssMarks) {
    // Implement your prediction logic here
    // ...
    return 'Unknown Career';
  }

  void predictCareerButtonPressed() {
    int pythonMarks = int.tryParse(pythonController.text) ?? 0;
    int javascriptMarks = int.tryParse(javascriptController.text) ?? 0;
    int dbmsMarks = int.tryParse(dbmsController.text) ?? 0;
    int htmlCssMarks = int.tryParse(htmlCssController.text) ?? 0;

    setState(() {
      prediction = predictCareer(pythonMarks, javascriptMarks, dbmsMarks, htmlCssMarks);
    });
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
            TextField(
              controller: pythonController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Python Marks'),
            ),
            TextField(
              controller: javascriptController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'JavaScript Marks'),
            ),
            TextField(
              controller: dbmsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'DBMS Marks'),
            ),
            TextField(
              controller: htmlCssController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'HTMLCSS Marks'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: predictCareerButtonPressed,
              child: Text('Predict Career'),
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
