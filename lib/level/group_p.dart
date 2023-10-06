import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_study_buddy/colors.dart';
import 'package:virtual_study_buddy/auth/login.dart';




class ChatScreenP extends StatefulWidget {
  @override
  _ChatScreenPState createState() => _ChatScreenPState();
}

class _ChatScreenPState extends State<ChatScreenP> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String chatRoomId =
      "Professional"; // Change this to your chat room ID
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
  }

  // Function to log out the user
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    // Navigator.of(context).pop();
    //// Pop the chat screen and return to the previous screen
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed:
                _logout, // Call the logout function when the button is pressed
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
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
                    MessageWidget(sender: senderEmail, text: messageText, isCurrentUser:senderEmail == userEmail ,),
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
            leading: Icon(Icons.message),
            title: TextField(
              controller: _textController,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              onSubmitted: _handleSubmitted,
            ),
            trailing: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }
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
          color: isCurrentUser ? AppColors.primary : AppColors.secondary,
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
                borderRadius: BorderRadius.circular(8.0),
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

