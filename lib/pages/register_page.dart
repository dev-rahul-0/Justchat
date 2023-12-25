import 'package:flutter/material.dart';
import 'package:projecknew/pages/service/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../components/my_btton.dart';
import '../components/my_text_field.dart';
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _conformPassword = TextEditingController();
  void Signup() async {
  if (passwordcontroller.text != _conformPassword.text) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Password do not match'),
    ));
    return;
  }
  final authService = Provider.of<AuthService>(context, listen: false);
  try {
    await authService.signUpWithEmailandPassword(emailcontroller.text, passwordcontroller.text);
  }catch (e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  Icon(
                    Icons.message,
                    size: 80,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(height: 50,),
                  const Text(
                    "Lets's create an account for you",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25,),
                  MyTextField(
                      controller: emailcontroller,
                      hintText: 'E-mail',
                      obscureText: false),
                  const SizedBox(height: 10,),
                  MyTextField(
                      controller: passwordcontroller,
                      hintText: 'Password',
                      obscureText: true),
                  const SizedBox(height: 10,),
                  MyTextField(
                      controller: _conformPassword,
                      hintText: 'Conform Password',
                      obscureText: true),
                  const SizedBox(height: 25,),
                  MyButton(
                      onTap: Signup,
                      text: 'Sign Up'),
                  const SizedBox(height: 50,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already  a member?'),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text('Login now',style:
                        TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


