import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:virtual_study_buddy/groups/groups.dart';
import 'package:virtual_study_buddy/groups/leaderboard.dart';
import 'package:virtual_study_buddy/level/group_a.dart';
import 'package:virtual_study_buddy/auth/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virtual_study_buddy/dashboard/pomodoro.dart';
import 'package:virtual_study_buddy/level/group_b.dart';
import 'package:virtual_study_buddy/level/group_i.dart';
import 'package:virtual_study_buddy/profilepage.dart';
import 'package:virtual_study_buddy/splashscreen.dart';
import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase App',
      home: LoginPage(),
    );
  }
}
