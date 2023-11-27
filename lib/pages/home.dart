import 'package:chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _name = '';

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
    );
  }
}