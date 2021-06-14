import 'package:chatapp/widgets/chats/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  bool isMe(String uid) {
    return FirebaseAuth.instance.currentUser.uid == uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, chatsnapshot) {
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final documents = chatsnapshot.data.docs;

          return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (context, index) => MessageBubble(
              documents[index]['text'],
              isMe(documents[index]['userId']),
              documents[index]['username'],
              documents[index]['image_url'],
              key: ValueKey(documents[index].id),
            ),
          );
        }
      },
    );
  }
}
