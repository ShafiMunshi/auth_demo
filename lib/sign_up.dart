import 'package:firebase_auth_demo/helper/auth_helper.dart';
import 'package:firebase_auth_demo/sign_in.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  SignUp({Key? key}) : super(key: key);
  var obj = AuthHelper();
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
                  obj.signUp(userEmail, userPass, context);
                },
                child: Text('Sign Up')),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIN()));
                },
                child: Text('Already Have an Account?'))
          ]),
        ),
      ),
    );
  }
}
