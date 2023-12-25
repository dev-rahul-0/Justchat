import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.timestamp,
    required this.message,
    required this.receiverId,
    required this.senderEmail,
    required this.senderId
});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'message': message,
      'receiverId': receiverId,
      'timestamp': timestamp
    };
  }

}