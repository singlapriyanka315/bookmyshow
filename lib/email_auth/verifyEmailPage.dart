import 'dart:async';

import 'package:bookmyapp/email_auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 2),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      navigateToNext();
    }
  }

  Future navigateToNext() async {
    // await storage.write(key: "verification", value: "true");
    User? user = await FirebaseAuth.instance.currentUser;
    var value = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    var db = FirebaseFirestore.instance.collection("users");

    db.doc(user.uid).update({'verification': "true"});
    // setState(() {});
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => LoginScreen()));
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerified == false) {
      return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Icon(
                Icons.verified,
                color: Colors.red,
                size: 80.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text("Verify your email",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 14, right: 14),
              child: Text(
                  "A verification email has been sent to your email address. Please check your email and click on the link to verify your email address.",
                  style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 70),
            CircularProgressIndicator(),
            Container(child: Text("I am not verified")),
          ],
        )),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Icon(
                Icons.verified,
                color: Colors.red,
                size: 80.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text("Verify your email",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 14, right: 14),
              child: Text(
                  "A verification email has been sent to your email address. Please check your email and click on the link to verify your email address.",
                  style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 70),
            Container(child: Text("verified")),
          ],
        )),
      );
    }
  }
}
