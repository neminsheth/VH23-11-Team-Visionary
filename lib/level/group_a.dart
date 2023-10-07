import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_study_buddy/colors.dart';
import 'package:virtual_study_buddy/auth/login.dart';

class ChatScreenA extends StatefulWidget {
  @override
  _ChatScreenAState createState() => _ChatScreenAState();
}

class _ChatScreenAState extends State<ChatScreenA> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String chatRoomId = "Advanced"; // Change this to your chat room ID
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email!;
      });
    }
  }

  void _handleSubmitted(String text) async {
    if (text.isNotEmpty) {
      final messageData = {
        'message': text,
        'senderEmail': userEmail,
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Reference to the chat room's message collection
      final chatRoomMessageCollection = _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('messages');

      // Add the new message to the collection
      await chatRoomMessageCollection.add(messageData);

      _textController.clear();
    }
    getEmails();
  }

  void getEmails() async {
    try {
      List<String> emails = await getEmailsFromGroupChat();

      if (emails.isNotEmpty) {
        // Loop through the list of emails and display them
        for (String email in emails) {
          print('Sender Email in the chatroom: $email');
        }
      } else {
        print('No sender emails found in the chatroom messages.');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  // Function to log out the user
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    // Navigator.of(context).pop();
    //// Pop the chat screen and return to the previous screen
    ///
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
              body: Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/icons/desktop-wallpaper-whatsapp-dark-whatsapp-chat.jpg'), // Replace with your background image asset
              fit: BoxFit.cover,
              ),
              ),
              child: Column(
        children: <Widget>[
          SizedBox(height: 5,),
          Row(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () => _showEmails(context), // Pass the context
                tooltip: 'Show Emails',
                child: Icon(Icons.email,
                  color: Colors.black,),
              ),
          SizedBox(width: 5),

          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => _showEmails(context), // Pass the context
            tooltip: 'Video Call',
            child: Icon(Icons.video_call_outlined,
              color: Colors.black,),
          ),
            ],
          ),

          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('chatroom')
                  .doc(chatRoomId)
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final messages = snapshot.data!.docs;
                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message['message'];
                  final senderEmail = message['senderEmail'];

                  messageWidgets.add(
                    MessageWidget(
                      sender: senderEmail,
                      text: messageText,
                      isCurrentUser: senderEmail == userEmail,
                    ),
                  );
                }
                return ListView(
                  children: messageWidgets,
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.message,
              color: Colors.white,),
            title: TextField(
              controller: _textController,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message',
                hintStyle: TextStyle(color: Colors.white), // Change the hint text color
              ),
              style: TextStyle(color: Colors.white), // Change the input text color
              onSubmitted: _handleSubmitted,
            ),

            trailing: IconButton(
              icon: Icon(Icons.send,
                color: Colors.white,),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
     )
    );

  }
}

AppBar appBar() {
  return AppBar(
    title: const Text(
      'Virtual Study buddy!',
      style: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    leading: GestureDetector(
      onTap: () {},
    ),
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
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    ],
  );
}

class MessageWidget extends StatelessWidget {
  final String sender;
  final String text;
  final bool isCurrentUser;

  MessageWidget({
    required this.sender,
    required this.text,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.black12 : Colors.black12,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sender,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<String>> getEmailsFromGroupChat() async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('chatroom')
      .doc('Beginner')
      .collection('messages')
      .get();

  List<String> emailsList = [];

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    final senderEmail = doc['senderEmail'];
    if (!emailsList.contains(senderEmail)) {
      emailsList.add(senderEmail);
    }
  }

  return emailsList;
}

void _showEmails(BuildContext context) async {
  try {
    List<String> emails = await getEmailsFromGroupChat();

    if (emails.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Emails in the Group Chat'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: emails.map((email) {
                return Text(email);
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      print('No sender emails found in the chatroom messages.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

Future<void> addUserToGroupChat(
    String docId, String message, String senderEmail) async {
  try {
    final messageData = {
      'message': message,
      'senderEmail': senderEmail,
      'timestamp': FieldValue.serverTimestamp(),
    };

    // Reference to the specified chat room's message collection
    final chatRoomMessageCollection = FirebaseFirestore.instance
        .collection('chatroom')
        .doc(docId)
        .collection('messages');

    // Add the new message (user) to the collection
    await chatRoomMessageCollection.add(messageData);
    print('sucess');
  } catch (e) {
    print('An error occurred: $e');
    // Handle any errors here
  }
}
