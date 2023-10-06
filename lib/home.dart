import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import 'package:virtual_study_buddy/profile.dart';
import 'colors.dart';
import 'feed.dart';
import 'notes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FeedPage(),
    NotesScreen(),
    Page(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Study Buddy',
      //     style: TextStyle(color: AppColors.primary),
      //   ),
      //   backgroundColor: AppColors.white,
      //   elevation: 0,
      // ),
      body: _pages[_currentIndex],
      bottomNavigationBar: FlashyTabBar( // Use FlashyTabBar
        selectedIndex: _currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        backgroundColor: AppColors.secondary, // Set background color
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home, color: AppColors.white),
            title: Text('Feed', style: TextStyle(color: AppColors.white)),
            ),
          FlashyTabBarItem(
            icon: Icon(Icons.emoji_emotions, color: AppColors.white),
            title: Text('Notes', style: TextStyle(color: AppColors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.groups, color: AppColors.white),
            title: Text('Community', style: TextStyle(color: AppColors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.more_horiz, color: AppColors.white),
            title: Text('More', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}


class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 3 Content'),
    );
  }
}
