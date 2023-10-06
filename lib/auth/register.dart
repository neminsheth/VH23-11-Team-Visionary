import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:virtual_study_buddy/auth/login.dart';

import '../colors.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedSubject = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/icons/background.png'), // Replace with your background image asset
              fit: BoxFit.cover,
              ),
              ),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                 SizedBox(height: 150),
                   Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: AppColors.white, width: 2.0),
              ),
                    child: Column(
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: _surnameController,
                    decoration: InputDecoration(labelText: 'Surname'),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  SizedBox(height: 20),
                  DropdownSearch<String>.multiSelection(
                    items: ["DBMS", "DSA", "OS", 'CN'],
                    popupProps: PopupPropsMultiSelection.menu(
                      showSelectedItems: true,
                      disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    onChanged: (values) {
                      setState(() {
                        _selectedSubject = values.join(', ');
                      });
                    },
                    selectedItems:
                    _selectedSubject.isNotEmpty ? [_selectedSubject] : [],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final String name = _nameController.text.trim();
                      final String surname = _surnameController.text.trim();
                      final String email = _emailController.text.trim();
                      final String password = _passwordController.text.trim();
                      _registerUser(name, surname, email, password, _selectedSubject);
                    },
                    child: Text('Register'),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
       ),
      )
    );
  }


Future<void> _registerUser(String name, String surname, String email,
      String password, String selectedSubject) async {
    try {
      // Step 1: Register the user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Step 2: Generate a unique ID for the user
      String userId = userCredential.user!.uid;

      // Step 3: Store user data in Firestore with the unique user ID
      await FirebaseFirestore.instance.collection('Students').doc(userId).set({
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'subjects': selectedSubject,
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
        } catch (e) {
      print("Error: $e");
    }
  }
  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Sign up',
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

      ),
      actions: [
        GestureDetector(
          onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
          ,
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
    );
  }
}