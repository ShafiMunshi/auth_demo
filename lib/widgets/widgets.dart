// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewCourse extends StatefulWidget {
  @override
  State<AddNewCourse> createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {
  //controller

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  XFile? _courseImage;
  String? imageUrl;

  //Choosing the imageform the gallery

  chooseImageformGallery() async {
    final ImagePicker _picker = ImagePicker();
    _courseImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  //it will write the image to firebase storage console
  writeData() async {
    File imgFile = File(_courseImage!.path);
    FirebaseStorage _storage = FirebaseStorage.instance;
    UploadTask _uploadTask =
        _storage.ref('images').child(_courseImage!.name).putFile(imgFile);
    TaskSnapshot snapshot = await _uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);

    // pushing title and description data to firestore database

    CollectionReference _course =
        FirebaseFirestore.instance.collection('courses');
    _course.add({
      'course-name': _titleController.text,
      'course_desc': _descController.text,
      'img': imageUrl,
    });
    print('Successfully added');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Enter Your Course title'),
            ),
            TextField(
              controller: _descController,
              decoration:
                  InputDecoration(hintText: 'Enter Your Course descripito'),
            ),
            Expanded(
              child: Material(
                child: _courseImage == null
                    ? IconButton(
                        onPressed: () {
                          chooseImageformGallery();
                        }, //it wiill show the image button for getting form the gallery
                        icon: Icon(Icons.image_outlined),
                      )
                    : Image.file(
                        File(_courseImage!.path)), //this will image the image..
              ),
            ),
            ElevatedButton(
              onPressed: () {
                writeData();
               
              },
              child: Text('Push'),
            ),
          ],
        ),
      ),
    );
  }
}
