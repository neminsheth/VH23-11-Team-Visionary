import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';

import '../home.dart';

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Students').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var users = snapshot.data!.docs;
          print(users);

          // Sort users based on the sum of their scores
          users.sort((a, b) {
            int sumA = a['python'] + a['dbms'] + a['javascript'] + a['htmlCss'];
            int sumB = b['python'] + b['dbms'] + b['javascript'] + b['htmlCss'];
            return sumA - sumB;
          });

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              int totalScore = user['python'] + user['dbms'] + user['javascript'] + user['htmlCss'];

              return ListTile(
                title: Text(user['name']),
                subtitle: Text('Total Score: $totalScore'),
              );
            },
          );
        },
      ),
    );
  }
  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => HomePage()));
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
        'Leaderboard !!',
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

