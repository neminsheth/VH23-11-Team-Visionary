import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_study_buddy/groups/questionnaire.dart';
import 'package:virtual_study_buddy/groups/readingbooks.dart';
import 'package:virtual_study_buddy/level/group_a.dart';
import 'package:virtual_study_buddy/level/group_b.dart';
import 'package:virtual_study_buddy/level/group_i.dart';
import '../colors.dart';
import '../general/styleCard.dart';
import '../home.dart';
import 'languages/language.dart';
import 'leaderboard.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<String> userGroups = [];
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    loadUserGroups();
  }

  Future<void> loadUserGroups() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null)
      setState(() {
        userEmail = user.email!;
        print(userEmail);
      });
    try {
      userGroups = await getGroupsForUser(userEmail);
      setState(() {});
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  void _handleGroupTap(String groupId) {
    // Check the groupId and navigate accordingly
    if (groupId == 'Advanced') {
      // Navigate to a separate page for the 'Advanced' group
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreenA(),
        ),
      );
    } else if (groupId == 'Beginner') {
      // Navigate to a separate page for the 'Beginner' group
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreenB(),
        ),
      );
    } else if (groupId == 'Intermediate') {
      // Navigate to a separate page for the 'Intermediate' group
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreenI(),
        ),
      );
    } else {
      // Navigate to the default group chat page with the selected groupId
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupChatPage(groupId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StyleCard(
                      title: "Join new group",
                      img: "assets/icons/happy.svg",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionnairePage(),
                          ),
                        );
                      },
                      bgColor: AppColors.primary,
                      textColor: AppColors.white,
                      description: "AI selected group!",
                    ),
                    StyleCard(
                      title: "Books",
                      img: "assets/icons/reading.svg",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadingBooks(),
                          ),
                        );
                      },
                      bgColor: AppColors.primary,
                      textColor: AppColors.white,
                      description: "Subject-oriented books!",
                    ),
                    StyleCard(
                      title: "Leaderboard",
                      img: "assets/icons/music.svg",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LeaderboardPage(),
                          ),
                        );
                      },
                      bgColor: AppColors.primary,
                      textColor: AppColors.white,
                      description: "Find where you stand!",
                    ),
                    StyleCard(
                      title: "Language",
                      img: "assets/icons/language.svg",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LanguagePage(),
                          ),
                        );
                      },
                      bgColor: AppColors.primary,
                      textColor: AppColors.white,
                      description: "Learn and Code!",
                    ),


                  ],

                ),

              ),
              //SizedBox(height: 10),
              Text(
                'Your Groups',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  height: 510,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userGroups.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () =>
                              _handleGroupTap(userGroups[index]), // Handle group tap
                          child: ListTile(
                            title: Text(
                              userGroups[index],
                              style: TextStyle(
                                fontSize: 18, // Adjust the font size as needed
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Description or additional information about the group',
                              style: TextStyle(
                                fontSize: 14, // Adjust the font size as needed
                                color: Colors.grey,
                              ),
                            ),
                            leading: CircleAvatar(
                              // You can use a group icon or image here
                              backgroundColor:
                                  Colors.black, // Customize the background color
                              child: Icon(
                                Icons
                                    .group, // Customize with an appropriate group icon
                                color: Colors.white, // Customize the icon color
                              ),
                            ),
                            trailing: Icon(
                              Icons
                                  .arrow_forward_ios, // Add an arrow icon for navigation
                              color: Colors.grey, // Customize the icon color
                            ),
                            onTap: () => _handleGroupTap(
                                userGroups[index]), // Handle group tap
                          ));
                    },
                  ),
                ),
              ),
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

class GroupChatPage extends StatelessWidget {
  final String groupId;

  GroupChatPage(this.groupId);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat: $groupId'), // Display the group name or ID
      ),
      body: Center(
        child: Text(
            'Group Chat Content Here'), // Replace with actual group chat content
      ),
    );
  }
}

Future<List<String>> getGroupsForUser(String userEmailAddress) async {
  try {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('messages') // Query all message collections
        .where('senderEmail', isEqualTo: userEmailAddress)
        .get();

    Set<String> groupIds = Set<String>();

    // Iterate through the documents to find group IDs
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      // Extract the group ID from the document's reference
      String groupId = doc.reference.parent.parent!.id;
      groupIds.add(groupId);
    }

    // Convert the set to a list
    List<String> groupList = groupIds.toList();

    return groupList;
  } catch (e) {
    print('An error occurred: $e');
    return []; // Return an empty list in case of an error
  }
}
