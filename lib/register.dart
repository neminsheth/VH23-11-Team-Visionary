import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:virtual_study_buddy/dashboard.dart';
import 'package:virtual_study_buddy/login.dart';

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
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  _selectedSubject =
                      values.join(', '); // Store selected subjects as a comma-separated string
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
            ),
          ],
        ),
      ),
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

      // Step 4: Redirect to the Dashboard upon successful registration
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print("Error: $e");
    }
  }
}