import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController reppasswordController = TextEditingController();
  final storage = new FlutterSecureStorage();

  String? lat, long;
  var _formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid = true;

  bool _obscureRep = true;
  bool _obscureOld = true;
  bool _obscureNew = true;
  var snapshot;

  void _toggleOldPassword() {
    setState(() {
      _obscureOld = !_obscureOld;
    });
  }

  void _toggleNewPassword() {
    setState(() {
      _obscureNew = !_obscureNew;
    });
  }

  void _toggleNewRepPassword() {
    setState(() {
      _obscureRep = !_obscureRep;
    });
  }

  @override
  initState() {
    getprofile();
  }

  void getprofile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    print(snapshot['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: ListTile(
            title: Text("Change Password",
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
              Padding(
                padding: EdgeInsets.all(5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: oldpasswordController,
                          //obscureText:true,
                          obscureText: _obscureOld,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Old Password!';
                            } else if (value != snapshot['password']) {
                              return 'Incorrect Old Password!';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            if (oldpasswordController.text.isNotEmpty) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // login();
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Old Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureOld
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: _toggleOldPassword,
                                color: Color.fromARGB(255, 79, 78, 78),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 79, 78, 78),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: newpasswordController,
                          //obscureText:true,
                          obscureText: _obscureNew,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your New Password!';
                            } else if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            if (newpasswordController.text.isNotEmpty) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // login();
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "New Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureNew
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: _toggleNewPassword,
                                color: Color.fromARGB(255, 79, 78, 78),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 79, 78, 78),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: reppasswordController,
                          //obscureText:true,
                          obscureText: _obscureRep,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value != newpasswordController.text.trim()) {
                              return 'Please repeat your New Password!';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            if (reppasswordController.text.isNotEmpty) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // login();
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Repeat New Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureRep
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: _toggleNewRepPassword,
                                color: Color.fromARGB(255, 79, 78, 78),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 79, 78, 78),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 400,
                        child: CupertinoButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            User? currentUser =
                                FirebaseAuth.instance.currentUser;

                            currentUser!
                                .updatePassword(reppasswordController.text)
                                .then((value) {
                              print(reppasswordController);
                              return print("success");
                            }).catchError((err) {
                              throw err;
                            });

                            //checkCurrentPasswordValid = checkCurrentPassword();
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "✓ Password changed successfully",
                                        style: TextStyle(color: Colors.white)),
                                    duration: Duration(milliseconds: 900),
                                    backgroundColor:
                                        Color.fromARGB(255, 58, 126, 60)),
                              );
                            }
                          },
                          color: Color.fromRGBO(223, 24, 39, 0.9),
                          child: Text("Change Password"),
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
}
