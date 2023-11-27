import 'package:chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/myButton.dart';
import 'package:chat/widgets/myTextField.dart';
import 'package:provider/provider.dart';


class Register extends StatefulWidget {
  final void Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final namecontroller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async{
    if(passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      
        final authService = Provider.of<AuthService>(context, listen: false);
        try {
          await authService.signUp(
            namecontroller.text,
            emailController.text,
            passwordController.text,
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
      child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('assets/images/logo.png', height: 100.0, width: 100.0,),
           const SizedBox(height: 50.0),
           const Text('New Era Unlocked!', style: TextStyle(fontSize: 24.0)),
            const SizedBox(height: 20.0),
            MyTextField(controller: namecontroller, hintText: 'Name', obscureText: false),
            const SizedBox(height: 10.0),
            MyTextField(controller: emailController, hintText: 'Email', obscureText: false),
            const SizedBox(height: 10.0),
            MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
            const SizedBox(height: 10.0),
            MyTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
            const SizedBox(height: 20.0),
            MyButton(onTap: signUp, text: 'Sign up'),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                TextButton(
                  onPressed: widget.onTap,
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    foregroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0.0)),
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}