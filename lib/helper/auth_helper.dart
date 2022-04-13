

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home_screen.dart';
import '../sign_up.dart';

class AuthHelper {
  final box = GetStorage();
  final googleInfo = GetStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _otpController = TextEditingController();

  phoneAuth(number, context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential _userCredential =
            await auth.signInWithCredential(credential);
        User? _user = _userCredential.user;
        if (_user!.uid.isNotEmpty) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          print('failed');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Enter your OTP'),
                content: Column(
                  children: [
                    TextField(
                      controller: _otpController,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          PhoneAuthCredential _phoneAuthCredential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: _otpController.text);
                          UserCredential _userCredential = await auth
                              .signInWithCredential(_phoneAuthCredential);
                          User? _user = _userCredential.user;
                          if (_user!.uid.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          } else {
                            print('failed');
                          }
                        },
                        child: Text('Continue')),
                  ],
                ),
              );
            });
      },
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential _usecredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // user information
      User? _user = _usecredential.user;
      await googleInfo.write('email', _user?.email.toString());

      if (_user!.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print('something is wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signUp(email, password, context) async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var authCredintial = usercredential.user;
      User _user;
      _user = authCredintial!;
      print(authCredintial);
      if (_user.uid.isNotEmpty) {
        box.write('id', _user.uid);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Sign Up failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(
            msg: "The Password is too waek",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "This email is already in use",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  Future signIn(email, password, context) async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      var authCredintial = usercredential.user;
      print(authCredintial);
      User _user;
      _user = authCredintial!;
      if (_user.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Sign in failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "Weak Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }
}
