import 'package:cloud_firestore/cloud_firestore.dart';
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

  final Stream<QuerySnapshot> _courseStream =
      FirebaseFirestore.instance.collection('courses').snapshots();
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
      // body: Center(
      //   child: Column(
      //     children: [
      //       Text(googleInfo.read('email').toString()),
      //       Text('user email'),
      //       // Text('HOmePage'),
      //     ],
      //   ),
      // ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _courseStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Container(
                  height: 220,
                  child: Column(
                    children: [
                      Expanded(child: Image.network(data['img'])),
                      Text(
                        data['course-name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 25),
                      ),
                      Text(data['course_desc'])
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
