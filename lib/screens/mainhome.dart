import 'package:bookmyapp/models/coming_soon.dart';
import 'package:bookmyapp/screens/homeScreen.dart';
import 'package:connectivity/connectivity.dart';
import '../apis/now_showing_api.dart';
import 'package:bookmyapp/screens/buzz.dart';
import 'package:bookmyapp/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../apis/coming_soon_api.dart';
import '../models/live_movies.dart';
import '../models/now_showing.dart';
import '../email_auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => MainScreenState();
}

final storage = new FlutterSecureStorage();
Icon customIcon = const Icon(Icons.search);
Widget customSearchBar = const Text('It All Starts Here...');

class MainScreenState extends State<MainScreen> {
  @override
  initState() {}

  final FirebaseAuth auth = FirebaseAuth.instance;
  List<FilmsNow> nowList = [];
  List<ComingSoon> soonList = [];
  List<LiveFilm> liveList = [];
  final myController = TextEditingController();
  int selectedIndex = 0;

  @override
  liveSearch(String search) async {
    // try {
    //   liveList = await getLive(search);
    //   print("soonList");
    //   print(liveList);
    //   return liveList;
    // } catch (err) {
    //   print(err);
    // }
  }

  moviesSoon() async {
    try {
      soonList = await getSoon();
      print("soonList");
      print(soonList);
      return soonList;
    } catch (err) {
      print(err);
    }
  }

  moviesNow() async {
    try {
      nowList = await getNow();
      print(nowList);
      return nowList;
    } catch (err) {
      rethrow;
    }
  }

  var userData;
  Future<void> signOut() async {
    try {
      await auth.signOut();
      await storage.delete(key: "uid");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      throw Exception(e);
    }
  }

  getUserData() async {
    userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(userData.data()['first name']);
    return userData;
  }

  List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    Buzz(),
    EditProfile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return  StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
        return snapshot.data == ConnectivityResult.none ? Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: Container(
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bookone.jpg"),
                        fit: BoxFit.fitWidth))),
          ),
    
          body: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Center(
            //   child: widgetOptions.elementAt(selectedIndex),
            Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 10, right: 10),
                        child: Container(
                          child: Image.asset("assets/images/noInternet.webp"),
                        ),
                      ),
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Text("Sorry! Connection failed", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      )),
                      Center(child: Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("Your internet might be unstable", style: TextStyle(fontSize: 16, color:Colors.grey)),
                      ))
            // )
          ])),
    
    // Drawer----------------------
    
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Buzz',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_sharp),
                label: 'Profile',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        ) : Scaffold(
          // appBar: AppBar(
          //   iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          //   flexibleSpace: Container(
          //       // ignore: prefer_const_constructors
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //               image: AssetImage("assets/images/bookone.jpg"),
          //               fit: BoxFit.fitWidth))),
          // ),
    
          body: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Center(
              child: widgetOptions.elementAt(selectedIndex),
            )
          ])),
    
    // Drawer----------------------
    
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Buzz',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_sharp),
                label: 'Profile',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        );
      }
    );
  }
}
