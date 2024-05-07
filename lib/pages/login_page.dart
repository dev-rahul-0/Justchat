import 'package:flutter/material.dart';
import 'package:projecknew/components/my_btton.dart';
import 'package:projecknew/components/my_text_field.dart';
import 'package:projecknew/pages/service/auth/auth_service.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  final void Function()? onTap;
  const Layout({super.key, this.onTap});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  void Signin() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
        _emailcontroller.text,
        _passwordcontroller.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
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
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 250,
                    child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage("images/logo-removebg-preview.png")),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Welcome back you\'ve been missed",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                      controller: _emailcontroller,
                      hintText: 'E-mail',
                      obscureText: false),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                      controller: _passwordcontroller,
                      hintText: 'Password',
                      obscureText: true),
                  const SizedBox(
                    height: 25,
                  ),
                  MyButton(onTap: Signin, text: 'Sign In'),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?'),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
