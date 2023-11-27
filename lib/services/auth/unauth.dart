import 'package:chat/pages/login.dart';
import 'package:chat/pages/register.dart';
import 'package:flutter/material.dart';

class Unauth extends StatefulWidget {
  const Unauth({super.key});

  @override
  State<Unauth> createState() => _UnauthState();
}

class _UnauthState extends State<Unauth> {

  bool showLogin = true;

  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLogin) {
      return Login(onTap: togglePages);
    } else {
      return Register(onTap: togglePages);
    }
  }
}