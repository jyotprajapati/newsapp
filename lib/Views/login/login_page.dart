import 'package:flutter/material.dart';
import 'package:newsapp/Controllers/auth_controller.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';

import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Image.asset("assets/images/login2.png"),
            SizedBox(
              height: 20,
            ),
            Text("Just one tap away",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Spacer(),
            GoogleAuthButton(
              onPressed: () {
                AuthController.signInWithGoogle().then((value) {
                  if (value != null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                });
              },
              darkMode: false,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
