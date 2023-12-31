import 'package:chat/model/message.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final AuthService authService = AuthService();

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverID, String message) async {
    
    final name = await authService.getUserData('name');
    final user = _auth.currentUser;
    final senderID = user!.uid;
    final senderEmail = user.email;
    final senderName = name;
    final timestamp = Timestamp.now();
    final messageID = const Uuid().v4();
    Message newMessage = Message(
      senderID: senderID,
      senderEmail: senderEmail!,
      senderName: senderName!,
      receiverID: receiverID,
      message: message,
      messageID: messageID,
      timestamp: timestamp.toString(),
    );

    List<String> ids = [senderID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .doc(messageID)
        .set(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();

  }

  // delete message
  Future<void> deleteMessage(String messageID, String userID, String otherUserID) async {
    print('delete message inside chat service');
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .doc(messageID)
        .delete();
  }
}
