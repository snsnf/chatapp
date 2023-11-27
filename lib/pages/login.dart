import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/widgets/myButton.dart';
import 'package:chat/widgets/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signIn(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('assets/images/logo.png', height: 100.0, width: 100.0,),
           const SizedBox(height: 50.0),
           const Text('Welcome Back!', style: TextStyle(fontSize: 24.0)),
            const SizedBox(height: 20.0),
            MyTextField(controller: emailController, hintText: 'Email', obscureText: false),
            const SizedBox(height: 10.0),
            MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
            const SizedBox(height: 20.0),
            MyButton(onTap: signIn, text: 'Login'),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account? '),
                TextButton(
                  onPressed: widget.onTap,
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    foregroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0.0)),
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
