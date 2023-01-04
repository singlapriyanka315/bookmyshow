import 'dart:developer';
import 'package:app_settings/app_settings.dart';
import 'package:bookmyapp/email_auth/resetPassword.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = new FlutterSecureStorage();

  String? lat, long;
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          await storage.write(key: "uid", value: userCredential.user?.uid);
          //Navigator.popUntil(context, (route) => route.isFirst);

         // getCurrentLocation();

          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => MainScreen()));
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${ex.code.toString()}"),
            backgroundColor: Color.fromRGBO(223, 24, 39, 0.9),
          ),
        );
      }
    }
  }

//   getCurrentLocation() async {
//     try {
// //      bool geolocationStatus = await location.ser viceEnabled();
//       LocationPermission permission = await Geolocator.checkPermission();
//       bool geolocationStatus1 =
//           await Permission.location.serviceStatus.isEnabled;
//       if (geolocationStatus1) {
//         if (Theme.of(context).platform == TargetPlatform.android) {
//           var _permissionGranted = await Permission.location.status;
//           if (_permissionGranted == PermissionStatus.granted) {
//             // var data = await Permission.location.getLocation();
//             Position currentPosition = await Geolocator.getCurrentPosition(
//                 desiredAccuracy: LocationAccuracy.best);
//             print("Latitude" + currentPosition.latitude.toString());
//             lat = await currentPosition.latitude.toStringAsFixed(4);
//             print("Longitude" + currentPosition.longitude.toString());
//             long = await currentPosition.longitude.toStringAsFixed(4);
//           } else {
//             // _permissionGranted = await Geolocator.requestPermission();
//             LocationPermission asked = await Geolocator.requestPermission();
//             if (permission != PermissionStatus.granted) {
//               LocationPermission asked = await Geolocator.requestPermission();
//               if (permission == PermissionStatus.granted) {
//                 Position currentPosition = await Geolocator.getCurrentPosition(
//                     desiredAccuracy: LocationAccuracy.best);
//                 print("Latitude" + currentPosition.latitude.toString());
//                 lat = await currentPosition.latitude.toStringAsFixed(4);
//                 print("Longitude" + currentPosition.longitude.toString());
//                 long = await currentPosition.longitude.toStringAsFixed(4);

//                 // var data = await location.getLocation();
//                 // setState(() {
//                 //   _locationData=data;
//                 // });
//               } else {}
//             } else {
//               Position currentPosition = await Geolocator.getCurrentPosition(
//                   desiredAccuracy: LocationAccuracy.best);
//               print("Latitude" + currentPosition.latitude.toString());
//               lat = await currentPosition.latitude.toStringAsFixed(4);
//               print("Longitude" + currentPosition.longitude.toString());
//               long = await currentPosition.longitude.toStringAsFixed(4);
//               // var data = await location.getLocation();
//               // setState(()  {
//               //   _locationData=data;
//               // });
//             }
//           }
//         }
//       } else {
//         if (!await Permission.location.serviceStatus.isEnabled) {
//           AlertDialog(
//             title: Text("Location Required"),
//             content: Text("Please allow app to access your location"),
//             actions: <Widget>[
//               TextButton(
//                 child: Text("Settings"),
//                 onPressed: () {
//                   AppSettings.openLocationSettings();
//                   //Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: _isLoading
//                     ? SizedBox(
//                         height: 25,
//                         width: 25,
//                         child: CircularProgressIndicator(),
//                       )
//                     : Text("OK"),
//                 onPressed: () {

//                   setState(() {
//                     _isLoading = true;
//                   });
//                   navigatorKey.currentState?.pop();
//                 },
//               )
//             ],
//           );
//         } else {
//           Position currentPosition = await Geolocator.getCurrentPosition(
//               desiredAccuracy: LocationAccuracy.best);
//           print("Latitude" + currentPosition.latitude.toString());
//           lat = await currentPosition.latitude.toStringAsFixed(4);
//           print("Longitude" + currentPosition.longitude.toString());
//           long = await currentPosition.longitude.toStringAsFixed(4);
//         }
//       }
//     } catch (exception) {
//       print('exception is $exception');
//     }
//   }
  

  bool _obscureText = true;
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<ConnectivityResult>(
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
                      ])):
                      SafeArea(
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
                      key: formKey,
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
                            height: 10,
                          ),
                          SizedBox(
                            width: 400,
                            child: TextFormField(
                              controller: passwordController,
                              //obscureText:true,
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Password!';
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                if (passwordController.text.isNotEmpty) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  //login();
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: _togglePasswordStatus,
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
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                login();
                              },
                              color: Color.fromRGBO(223, 24, 39, 0.9),
                              child: Text("LOGIN"),
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                            SizedBox(
                            height: 10,
                          ),
                          CupertinoButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ResetPassword()));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: (TextStyle(fontWeight: FontWeight.bold)),
                              )),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          CupertinoButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Text(
                                "Don't have an Account? Sign Up",
                                style: (TextStyle(fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
