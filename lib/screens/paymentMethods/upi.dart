import 'dart:async';
import 'package:bookmyapp/blocs/activeTicket_bloc/activeTicket_bloc.dart';
import 'package:bookmyapp/screens/homeScreen.dart';
import 'package:bookmyapp/screens/mainhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UPI extends StatefulWidget {
  final int amount;
  final movieName,
      cinemaName,
      mydate,
      tickets,
      totalprice,
      finalList,
      mytime,
      currentList,
      movieImage,
      cinemaId;
  UPI(
      {required this.amount,
      required this.movieName,
      required this.cinemaName,
      required this.mydate,
      required this.tickets,
      required this.totalprice,
      required this.currentList,
      required this.finalList,
      required this.mytime,
      required this.cinemaId,
      required this.movieImage,
      super.key});

  @override
  State<UPI> createState() => _UPIState();
}

class _UPIState extends State<UPI> {
  void insertData(String name, String cinema, String mydate, String time,
      List finallist, List seats) async {
    print("you clicked on pay");
    var db = FirebaseFirestore.instance.collection("bookseats");
    print(finallist.length);
    Map<String, dynamic> ourData = {
      "$name": {
        "$cinema": {
          "$mydate": {"$time": finallist}
        }
      }
    };

    db.doc("movie_name").set(ourData, SetOptions(merge: true)).then((value) {
      print("succesfull");
    });

    inserttickets(name, cinema, mydate, time, seats);

    setState(() {});
  }

  void inserttickets(String name, String cinema, String mydate, String time,
      List seats) async {
    List dbTickets = [];
    List finalTickets = [];

    User? user = await FirebaseAuth.instance.currentUser;
    var value = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    print(value.data()!['ticket']);
    setState(() {
      if (value.data()!['ticket'] != null) {
        dbTickets = value.data()!['ticket'];
      }
      print(dbTickets);
    });
    var db = FirebaseFirestore.instance.collection("users");
    var ordertime = DateFormat('KK:mm a').format(DateTime.now());
    List ourData = [
      {
        "name": "${name}",
        "cinema": "${cinema}",
        "mydate": "${mydate}",
        "time": "${time}",
        "cinemaId": "${widget.cinemaId}",
        "movieImage": "${widget.movieImage}",
        "orderedDate": DateFormat('dd-MMM-yyyy').format(DateTime.now()),
        "orderedTime": "${ordertime}",
        //(DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${ordertime}"))),
        "seats": seats
      }
    ];

    finalTickets.addAll(ourData);
    finalTickets.addAll(dbTickets);
    print(dbTickets);

    db.doc(user.uid).update({'ticket': finalTickets});
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController vpnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              print(snapshot.data);
              return snapshot.data == ConnectivityResult.none
                  ? Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Scaffold(
                          backgroundColor: Colors.white,
                          appBar: AppBar(
                            iconTheme: IconThemeData(
                                color: Color.fromRGBO(223, 24, 39, 0.9)),
                            backgroundColor: Colors.white,
                            elevation: 0,
                            title: Center(
                              child: ListTile(
                                title: Text("UPI",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                          body: SingleChildScrollView(
                              child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0, left: 10, right: 10),
                              child: Container(
                                child: Image.asset(
                                    "assets/images/noInternet.webp"),
                              ),
                            ),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text("Sorry! Connection failed",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            )),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("Your internet might be unstable",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ))
                          ]))))
                  : Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        iconTheme: const IconThemeData(
                            color: Color.fromRGBO(223, 24, 39, 0.9)),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        title: const Center(
                          child: ListTile(
                            title: Text("UPI",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                            child: Column(children: [
                          const Divider(),
                          ListTile(
                            title: const Text("Amount Payable",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            trailing: Text("₹${widget.amount}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                          const Divider(),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    controller: vpnController,
                                    //obscureText:true,

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your Virtual Payment Address(VPA)!';
                                      }
                                      return null;
                                    },
                                    onEditingComplete: () {
                                      if (vpnController.text.isNotEmpty) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        //  login();
                                      } else {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      labelText:
                                          "Enter your Virtual Payment Address(VPA)",
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 300,
                                  child: CupertinoButton(
                                    onPressed: () {
                                      if (vpnController.text.isNotEmpty) {
                                        insertData(
                                            widget.movieName,
                                            widget.cinemaName,
                                            widget.mydate,
                                            widget.mytime,
                                            widget.finalList,
                                            widget.currentList);
                                        showDialog<String>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: Image.asset(
                                                "assets/images/greentick.gif"),
                                            content: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 2.0),
                                              child: Text(
                                                  'Your Tickets Booked Successfully',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            actions: <Widget>[
                                              const ListTile(
                                                  leading: Text("Payment type"),
                                                  trailing: Text("UPI")),
                                              ListTile(
                                                  leading: const Text(
                                                      "Amount Paid",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  trailing: Text(
                                                      "₹${widget.amount}",
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              TextButton(
                                                onPressed: () => 
                                                Navigator.of(
                                                        context,rootNavigator: true)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MainScreen()),
                                                        (route) => false)
                                                    .then((_) {
                                                  BlocProvider.of<
                                                              ActiveTicketBloc>(
                                                          context)
                                                      .add(FetchActiveTicket());
                                                }),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      } else {
                                        showMax();
                                      }
                                    },
                                    child: Text("Pay"),
                                    color:
                                        const Color.fromRGBO(223, 24, 39, 0.9),
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ])),
                      ),
                    );
            }));
  }

  void showMax() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return CupertinoPopupSurface(
            isSurfacePainted: true,
            child: Container(
                padding: const EdgeInsetsDirectional.all(20),
                color: CupertinoColors.white,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).copyWith().size.height * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Material(
                        child: Text(
                      "Please Enter your Virtual Payment Address!",
                      style: TextStyle(
                          backgroundColor: CupertinoColors.white,
                          color: Color.fromRGBO(223, 24, 39, 0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                    const Divider(color: Color.fromARGB(255, 93, 92, 92)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CupertinoButton(
                              color: const Color.fromRGBO(223, 24, 39, 0.9),
                              borderRadius: BorderRadius.circular(200),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Okay")),
                        ]),
                  ],
                )),
          );
        });
  }
}
