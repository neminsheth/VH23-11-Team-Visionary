import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_study_buddy/colors.dart';
import 'package:virtual_study_buddy/auth/login.dart';

class ChatScreenI extends StatefulWidget {
  @override
  _ChatScreenIState createState() => _ChatScreenIState();
}

class _ChatScreenIState extends State<ChatScreenI> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String chatRoomId = "Intermediate"; // Change this to your chat room ID
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
      appBar: appBar(),
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
}
