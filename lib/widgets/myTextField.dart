import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
final TextEditingController controller;
final String hintText;
final bool obscureText;

const MyTextField({ Key? key, required this.controller, required this.hintText, required this.obscureText }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide:  BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        contentPadding: const EdgeInsets.all(20.0),
      ),
    );
  }
}