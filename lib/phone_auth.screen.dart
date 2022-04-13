import 'package:firebase_auth_demo/helper/auth_helper.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatelessWidget {
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Enter Your Phone Numbre'),
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(children: [
            TextField(
              controller: _phoneController,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthHelper().phoneAuth(_phoneController.text, context);
                },
                child: Text('Check')),
          ]),
        ),
      ),
    );
  }
}
