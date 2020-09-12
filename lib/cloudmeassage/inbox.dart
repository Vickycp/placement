import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:placement/models/messagemodels.dart';

class InboxMessage extends StatefulWidget {
  @override
  _InboxMessageState createState() => _InboxMessageState();
}

class _InboxMessageState extends State<InboxMessage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(title:notification['title'],body:notification['body'] ));
        });

        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: messages.map(buildmessage).toList(),
      ),
    );
  }

  Widget buildmessage(Message m) => ListTile(
        title: Text(m.title),
        subtitle: Text(m.body),
      );
}
