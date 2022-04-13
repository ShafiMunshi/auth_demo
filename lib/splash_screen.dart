import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/home_screen.dart';
import 'package:firebase_auth_demo/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Splash extends StatelessWidget {
  final box = GetStorage();
  final googleInfo = GetStorage();

  chooseScreen(context) async {
    var userID = await box.read('id');
    var userStuff = await googleInfo.read('email'.toString());

    if (userID != null || userStuff != null) {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(googleInfo.read('email'));
    Timer(Duration(seconds: 2), () => chooseScreen(context));
    return Scaffold(
      body: Center(
        child: CircleAvatar(),
      ),
    );
  }
}
