import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_study_buddy/questionnaire.dart';
import 'colors.dart';
import 'home.dart';


class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionnairePage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary, // Set the button color to AppColor.primary
                ),
                child: Text('Join new group', style: TextStyle(fontSize: 18)),
              )

            ),
            // Add more widgets or content here
          ],
        ),
      ),
    );
  }
  AppBar appBar() {
    return AppBar(
      // leading: GestureDetector(
      //   onTap: () {
      //     // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      //     Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context) => HomePage()));
      //   },
      //   child: Container(
      //     margin: const EdgeInsets.all(10),
      //     alignment: Alignment.center,
      //     width: 37,
      //     child: SvgPicture.asset(
      //       'assets/icons/Arrow - Left 2.svg',
      //       height: 25,
      //       width: 25,
      //     ),
      //     decoration: BoxDecoration(
      //       color: const Color(0xffF7F8F8),
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //   ),
      // ),
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
