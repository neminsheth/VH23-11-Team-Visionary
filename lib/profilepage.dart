import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';

class ProfileView extends StatefulWidget {
  final String userId;

  ProfileView({required this.userId});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDetails;

  @override
  void initState() {
    super.initState();
    _userDetails = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget.userId) // Use the provided user ID
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _userDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User details not found.'));
          } else {
            var userData = snapshot.data!.data();
            var email = userData?['email'] ?? 'N/A';
            var name = userData?['name'] ?? 'N/A';
            var surname = userData?['surname'] ?? 'N/A';
            var subjects = userData?['subjects'] ?? 'N/A';

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: $email', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 12),
                  Text('Name: $name', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 12),
                  Text('Surname: $surname', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 12),
                  Text('Subjects: $subjects', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
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
        'Your happy, Profile!',
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
