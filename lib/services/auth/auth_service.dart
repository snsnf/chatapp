

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-credential'){
        throw Exception('Email or password is incorrect');
      } else {
        throw Exception(e.message);
      }
    }
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


  Future<UserCredential> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'uid': userCredential.user!.uid,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<dynamic> getUserData(String key) async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently signed in.');
      }

      DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(currentUser.uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      return data[key];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}