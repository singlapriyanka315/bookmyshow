import 'package:app_settings/app_settings.dart';
import 'package:bookmyapp/screens/access_location.dart';
import 'package:bookmyapp/screens/connectivity/internet_connectivity.dart';
import 'package:bookmyapp/screens/mainhome.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import '../email_auth/signup_screen.dart';
import '../main.dart';
import 'homeScreen.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import '../email_auth/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _splashState();
}

final storage = new FlutterSecureStorage();
String? lat, long;
bool _isLoading = false;

Future<bool> checkLoginStatus() async {
  String? value = await storage.read(key: "uid");
  if (value == null) {
    print("null value");
    return false;
  }
  print("value");
  return true;
}

class _splashState extends State<Splash> {
  @override
  var subscription;
  bool conn = false;
  var result;
  var permission;
  var connection;
  bool isoffline = false;
  final Connectivity _connectivity = Connectivity();

  void con() async{
  ConnectivityResult result = await _connectivity.checkConnectivity();
   if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }

  }

  @override
  void initState() {
    super.initState();
    con();
    
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      print(result);
      if (result == ConnectivityResult.none) {
         isoffline = true;
      } else {
        print("i am in else splash");
        Timer(
            Duration(seconds: 3),
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => FutureBuilder(
                        future: checkLoginStatus(),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.data == false) {
                            return LoginScreen();
                          }
                          else if (permission != LocationPermission.denied &&
                              permission != LocationPermission.deniedForever) {
                            return MainScreen();
                          }
                          return AccessLocation();
                        }))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        //Stack(
        // children
        StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              return Container(
                  color: Colors.white,
                  child: snapshot.data == ConnectivityResult.none
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: isoffline == true
                              ? <Widget>[
                                  Image.asset("assets/images/my.jpeg",
                                      height: 180),
                                  SizedBox(width: 1.0, height: 100.0),
                                  Text("Sorry! Connection failed",
                                      style: TextStyle(
                                          fontSize: 22,
                                          decoration: TextDecoration.none)),
                                  SizedBox(width: 1.0, height: 20.0),
                                  Center(
                                      child: Text(
                                          "Please make sure you have good network",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 104, 104, 104),
                                              decoration: TextDecoration.none)))
                                ]
                              : <Widget>[
                                  Image.asset("assets/images/my.jpeg",
                                      height: 180),
                                  SizedBox(width: 1.0, height: 100.0),
                                  CircularProgressIndicator()
                                ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: isoffline == true
                              ? <Widget>[
                                  Image.asset("assets/images/my.jpeg",
                                      height: 180),
                                  SizedBox(width: 1.0, height: 100.0),
                                  Text("Sorry! Connection failed",
                                      style: TextStyle(
                                          fontSize: 22,
                                          decoration: TextDecoration.none)),
                                  SizedBox(width: 1.0, height: 20.0),
                                  Center(
                                      child: Text(
                                          "Please make sure you have good network",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 104, 104, 104),
                                              decoration: TextDecoration.none)))
                                ]
                              : <Widget>[
                                  Image.asset("assets/images/my.jpeg",
                                      height: 180),
                                  SizedBox(width: 1.0, height: 100.0),
                                  CircularProgressIndicator()
                                ],
                        ));
            });
  }
}
