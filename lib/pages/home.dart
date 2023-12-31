import 'package:chat/pages/chat.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _name = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getName();
  }
  
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  void getName() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final name = await authService.getUserData('name');
    print(name);
    setState(() {
      _name = name;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Chat'),
        actions: [
          Center(
            child: Row(
              children: [
                const Icon(Icons.account_circle_rounded, size: 30.0, color: Colors.white,),
                const SizedBox(width: 5.0),
                Text(_name),
              ],
          )),
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
        ),
        body: _buildUserList(),
    );
  }


  Widget _buildUserList() {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs
            .map<Widget>((doc)=> _buildUserItem(doc))
            .toList(),
        );
      },
    );

  }

  Widget _buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if(_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  
          Chat(receiverUserEmail: data['email'], receiverUserID: data['uid'],)));
        },
      );

    } else {
      return Container();
    }
  }
}