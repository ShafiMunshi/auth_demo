import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  // dynamic user;

  // HomeScreen(this.user);
  final googleInfo = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Center(
        child: Column(
          children: [
            Text(googleInfo.read('email').toString()),
            Text('user email'),
            // Text('HOmePage'),
          ],
        ),
      ),
    );
  }
}
