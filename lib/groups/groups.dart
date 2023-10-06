import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_study_buddy/groups/questionnaire.dart';
import 'package:virtual_study_buddy/groups/readingbooks.dart';
import '../colors.dart';
import '../home.dart';

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //SizedBox(width: 45,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionnairePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                  ),
                  child: Text('Join new group', style: TextStyle(fontSize: 18)),
                ),
                //SizedBox(width: 45,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReadingBooks()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                  ),
                  child: Text('Books', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle leaderboard button tap
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary, // Set the button color to AppColor.primary
                ),
                child: Text('Leaderboard', style: TextStyle(fontSize: 18)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle streaks button tap
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary, // Set the button color to AppColor.primary
                ),
                child: Text('Streaks', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('Your Groups',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),)
          // Add more widgets or content here
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Groups :)',
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
