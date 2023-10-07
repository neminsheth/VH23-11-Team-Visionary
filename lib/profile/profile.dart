import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_study_buddy/auth/login.dart';
import 'package:virtual_study_buddy/profile/profilepage.dart';
import 'package:virtual_study_buddy/groups/readingbooks.dart';

import '../colors.dart';
import '../general/styleCard.dart';
import '../predict.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'How can we help you ?',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {

          },
          // child: Container(
          //   margin: const EdgeInsets.all(10),
          //   alignment: Alignment.center,
          //   child: SvgPicture.asset(
          //     'assets/icons/Arrow - Left 2.svg',
          //     height: 20,
          //     width: 20,
          //   ),
          //   decoration: BoxDecoration(
          //       color: const Color(0xffF7F8F8),
          //       borderRadius: BorderRadius.circular(10)
          //   ),
          // ),
        ),
        actions: [
           GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: 37,
                decoration: BoxDecoration(
                    color: const Color(0xffF7F8F8),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: SvgPicture.asset(
                  'assets/icons/dots.svg',
                  height: 5,
                  width: 5,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 100,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: AppColors.secondary,
                    radius: 50,
                    child: Text(
                      'Pictcha!',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            StyleCard(
              title: "Profile",
              img: "assets/icons/profile.svg",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Check out your profile!",
            ),
            SizedBox(
              height: 15,
            ),

            StyleCard(
              title: "Predict",
              img: "assets/icons/profile.svg",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CareerPredictionPage()));
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Check your road-map!",
            ),
            SizedBox(
              height: 5,
            ),
            StyleCard(
              title: "Notification",
              img: "assets/icons/notfication.svg",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CareerPredictionPage()));
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Ting ting!",
            ),
            SizedBox(
              height: 15,
            ),
            StyleCard(
              title: "Settings",
              img: "assets/icons/settings.svg",
              onTap: () {
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Customize for yourself",
            ),
            SizedBox(
              height: 15,
            ),
            StyleCard(
              title: "Help Centre",
              img: "assets/icons/question.svg",
              onTap: () {
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Here to help!",
            ),
             SizedBox(
              height: 15,
            ),
            StyleCard(
              title: "Log Out",
              img: "assets/icons/logout.svg",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "See you soon!",
            ),
            SizedBox(
              height: 15,
            ),
            StyleCard(
              title: "Delete Account",
              img: "assets/icons/delete.svg",
              onTap: () {
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: ":(",
            ),
            SizedBox(
              height: 15,
            ),

          ],
        ),

      )
    );
  }
}
