import 'package:bookmyapp/screens/profile_screens/changePwd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../email_auth/login_screen.dart';

class Account_Screen extends StatefulWidget {
  const Account_Screen({super.key});

  @override
  State<Account_Screen> createState() => _Account_ScreenState();
}

final storage = new FlutterSecureStorage();
final FirebaseAuth auth = FirebaseAuth.instance;

class _Account_ScreenState extends State<Account_Screen> {
  @override
  Future<void> signOut() async {
    try {
       await storage.delete(key: "uid");
       await auth.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()),(route) => false));
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      throw Exception(e);
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Center(
                child: ListTile(
                  title: Text("Account & Settings",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            body: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric( horizontal: 1.0),
                    child: Card(
                      color:  Color.fromARGB(255, 123, 121, 121),
                      child: ListTile(
                      
                        title: Text("App info & Location Permission",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                                 trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
                        onTap: () {
                          splashColor:
                          Color.fromARGB(255, 48, 48, 48);
                          openAppSettings();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => E(),
                          //   ),
                          // );
                        },
                      ),
                    ),
                  ),
                   Padding(
                    padding:
                        EdgeInsets.symmetric( horizontal: 1.0),
                    child: Card(
                      color: Color.fromARGB(255, 123, 121, 121),
                      child: ListTile(
                            trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
                        title: Text("Change Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          splashColor:
                          Color.fromARGB(255, 48, 48, 48);
                           Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ChangePassword()));
                        },
                      ),
                    ),
                  ),
                 Padding(
                    padding:
                        EdgeInsets.symmetric( horizontal: 1.0),
                    child: Card(
                      color: Color.fromARGB(255, 123, 121, 121),
                      child: ListTile(
                        trailing: Icon(
                          Icons.logout,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        title: Text("Sign Out",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          splashColor:
                          Color.fromARGB(255, 48, 48, 48);
                          signOut();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => E(),
                          //   ),
                          // );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 250),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal:0.0),
                    child: Image.asset("assets/images/theater.png"),
                  ),
                ]))));
  }
}
