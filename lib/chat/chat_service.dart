import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecknew/models/message.dart';
class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        timestamp: timestamp,
        message: message,
        receiverId: receiverId,
        senderEmail: currentUserEmail,
        senderId: currentId);


    List<String> ids = [currentId,receiverId];
    ids.sort();
    String chatRoomId = ids.join(
      "_"
    );


    await _firestore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('message')
    .add(newMessage.toMap());


  }

Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy('timestamp',descending: false)
        .snapshots();
}
}