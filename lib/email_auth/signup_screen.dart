import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookmyapp/email_auth/login_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:bookmyapp/models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController myfirstnameController = TextEditingController();
  TextEditingController myemailController = TextEditingController();
  TextEditingController myphoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isEmailVerified =false;

  @override
  void dispose() {
    myfirstnameController.dispose();
    myemailController.dispose();
    myphoneController.dispose();

    super.dispose();
  }

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();
    User? user = await FirebaseAuth.instance.currentUser;

    if (formKey.currentState!.validate()) {
      if (password != cPassword) {
        log("Passwords do not match!");
        print("Passwords do not match!");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Passwords do not match!"),
              backgroundColor: Color.fromRGBO(223, 24, 39, 0.9)),
        );
      } else {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => FirebaseFirestore.instance
                      .collection("users")
                      .doc(value.user!.uid)
                      .set({
                    'first name': myfirstnameController.text.trim(),
                    'phone': int.parse(myphoneController.text.trim()),
                    'email': emailController.text.trim(),
                    'password' : cPassword
                  }));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Account created successfully"),
                backgroundColor: Colors.green),
          );
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => LoginScreen()));
        } on FirebaseAuthException catch (ex) {
          log(ex.code.toString());
          print(ex.code.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("${ex.code.toString()}"),
                backgroundColor: Color.fromRGBO(223, 24, 39, 0.9)),
          );
        }
      }
    }
  }

  // Future addUserDetails(
  //     String firstname, String lastname, int phone, String email) async {
  //   await FirebaseFirestore.instance.collection("users").add({
  //     'first name': firstname,
  //     'last name': lastname,
  //     'phone': phone,
  //     'email': email,
  //   });
  // }
  bool _obscurePassword = true;
  void _togglePasswordStatus() {
    setState(() {
      _obscurePassword  = ! _obscurePassword ;
    });
  }

  bool _obscureConfirm = true;
  void _toggleConfirmPasswordStatus() {
    setState(() {
      _obscureConfirm = !_obscureConfirm;
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
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: ListView(
                children: [
                   Stack(
                    children:[
                      Container(
                       child:Image.asset("assets/images/welcomeimage.webp"),
    
                      )
                    ]
                  ),
                  Form(
                      key: formKey,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: TextFormField(
                            
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Name!';
                              }
                              return null;
                            },
                            controller: myfirstnameController,
                            onEditingComplete: () {
                              if (myfirstnameController.text.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                              else{
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Name',
                                 prefixIcon:Icon(Icons.person, color: Color.fromARGB(255, 79, 78, 78)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Phone Number!';
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              if (myphoneController.text.isNotEmpty) {
                                FocusScope.of(context).nextFocus();
                              }
                              else{
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                            },
                            controller: myphoneController,
                            decoration: InputDecoration(
                               prefixIcon:Icon(Icons.phone, color: Color.fromARGB(255, 79, 78, 78)),
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                )),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your E-mail!';
                                  }
                                  return null;
                                },
                                onEditingComplete: () {
                                  if (emailController.text.isNotEmpty) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  else{
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                   prefixIcon:Icon(Icons.mail, color: Color.fromARGB(255, 79, 78, 78)),
                                    labelText: "E-mail Address",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                    )),
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                })),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Password!';
                                  }
                                  return null;
                                },
                                onEditingComplete: () {
                                  if (passwordController.text.isNotEmpty) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                  else{
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                                },
                              //  obscureText: true,
                              obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                   prefixIcon:Icon(Icons.lock, color: Color.fromARGB(255, 79, 78, 78)),
                                   suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: _togglePasswordStatus,
                                  color: Color.fromARGB(255, 79, 78, 78),
                                ),
                                    labelText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                    )),
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                })),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your Password!';
                                  }
                                  return null;
                                },
                                controller: cPasswordController,
                                //obscureText: true,
                                obscureText: _obscureConfirm,
                                onEditingComplete: () {
                                  if (cPasswordController.text.isNotEmpty) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    //createAccount();
                                  }
                                  else{
                                FocusManager.instance.primaryFocus?.unfocus();
                                  }
                                },
                                decoration: InputDecoration(
                                   prefixIcon:Icon(Icons.lock, color: Color.fromARGB(255, 79, 78, 78)),
                                   suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirm
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: _toggleConfirmPasswordStatus,
                                  color: Color.fromARGB(255, 79, 78, 78),
                                ),
                                    labelText: "Confirm Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(200),
                                    )),
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                })),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: SizedBox(
                              width:400,
                              child: CupertinoButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  createAccount();
                                },
                                color: Color.fromRGBO(223, 24, 39, 0.9),
                                child: Text("SIGN UP"),
                                borderRadius: BorderRadius.circular(200),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        CupertinoButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text("Already have an Account? Sign in", style : (TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(
                          height: 60,
                        )
                      ]))
                ],
              ),
            ));
      }
    );
  }
}
