import 'dart:developer';
import 'package:app_settings/app_settings.dart';
import 'package:bookmyapp/email_auth/signup_screen.dart';
import 'package:bookmyapp/screens/mainhome.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = new FlutterSecureStorage();

  String? lat, long;

  bool _obscureText = true;
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return  snapshot.data == ConnectivityResult.none ? SingleChildScrollView(
                          child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 80.0, left: 10, right: 10),
                          child: Container(
                            child: Image.asset("assets/images/noInternet.webp"),
                          ),
                        ),
                       const Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text("Sorry! Connection failed",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        )),
                        const Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Your internet might be unstable",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                        ))
                      ]))
                      : Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(
              child: ListTile(
                title: Text("Reset Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListView(
                children: [
                  Stack(children: [
                    Container(
                      child: Image.asset("assets/images/welcomeimage.webp"),
                    )
                  ]),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          "Enter your registered email below to receive password reset instructions.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 95, 94, 94),
                              fontSize: 18)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Form(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                                controller: emailController,
                                onEditingComplete: () {
                                  if (emailController.text.isNotEmpty) {
                                    FocusScope.of(context).nextFocus();
                                  } else {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your E- mail!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: "Email Address",
                                    prefixIcon: Icon(Icons.person,
                                        color: Color.fromARGB(255, 79, 78, 78)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                    ))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 400,
                            child: CupertinoButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: emailController.text.trim())
                                    .then((value) => {Navigator.of(context).pop()});
                              },
                              color: Color.fromRGBO(223, 24, 39, 0.9),
                              child: Text("Reset Password"),
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
