import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_study_buddy/colors.dart';
import 'package:virtual_study_buddy/profile/profile.dart';
import 'package:virtual_study_buddy/profile/profilepage.dart';

class CareerPredictionPage extends StatefulWidget {
  @override
  _CareerPredictionPageState createState() => _CareerPredictionPageState();
}

class _CareerPredictionPageState extends State<CareerPredictionPage> {
  String prediction = '';
  String imagePath = ''; // Empty path initially

  // Dummy list of professors with generic names and icons
  List<Map<String, dynamic>> professorsList = [
    {"name": "Nemin Sheth", "icon": Icons.school},
    {"name": "Dhruv Joshi", "icon": Icons.school},
    {"name": "Abey Geoge", "icon": Icons.school},
    {"name": "Anuj Bohra", "icon": Icons.school},

    // Add more professors as needed
  ];

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
      imagePath = getImagePath(prediction); // Set image path based on prediction
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

  String getImagePath(String prediction) {
    // Implement logic to return the appropriate image path based on the prediction
    // For example:
    if (prediction == 'Analyst') {
      return 'assets/icons/analyst.png';
    } else if (prediction == 'Software Developer') {
      return 'assets/icons/software.png';
    } else {
      return 'assets/icons/cloud.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              width: 500,
              child: ElevatedButton(
                onPressed: predictCareerFromFirebase,
                child: Text(
                  'Predict Career from Firebase Data',
                  style: TextStyle(color: AppColors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Predicted Career: $prediction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Conditionally show the image after prediction is made
            if (imagePath.isNotEmpty) ...[
              SizedBox(height: 20),
              Image.asset(
                imagePath,
                width: 300, // Set width as per your requirement
                height: 300, // Set height as per your requirement
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Professors:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Display the list of professors
              ListView.builder(
                shrinkWrap: true,
                itemCount: professorsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(professorsList[index]['icon']), // Icon for each professor
                    title: Text(professorsList[index]['name']), // Professor name
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
        'Career guidance!',
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
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}


