import 'package:firebase_auth_demo/helper/auth_helper.dart';
import 'package:firebase_auth_demo/sign_up.dart';
import 'package:flutter/material.dart';

class SignIN extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  SignIN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Sign UP')),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(children: [
            TextField(
              controller: _emailController,
            ),
            TextField(
              controller: _passController,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  final userEmail = _emailController.text;
                  final userPass = _passController.text;

                  var obj = AuthHelper();
                  obj.signIn(userEmail, userPass, context);
                },
                child: Text('Login')),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text('Dont Have an Account?'))
          ]),
        ),
      ),
    );
  }
}
