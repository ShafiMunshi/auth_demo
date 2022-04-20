

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  // dynamic user;

  // HomeScreen(this.user);
  final googleInfo = GetStorage();

  addNewCourse(context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        
        builder: (context) {
          return AddNewCourse();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course add'),
        actions: [
          IconButton(
              onPressed: () {
                addNewCourse(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
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
