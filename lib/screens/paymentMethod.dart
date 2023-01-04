import 'package:bookmyapp/screens/paymentMethods/upi.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:bookmyapp/screens/paymentMethods/card.dart';

class PaymentMethod extends StatefulWidget {
  final int amount;
  final movieName,
      cinemaName,
      mydate,
      tickets,
      totalprice,
      finalList,
      mytime,
      currentList,
      cinemaId,
      movieImage;

  PaymentMethod(
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
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          print(snapshot.data);
          return snapshot.data == ConnectivityResult.none
              ? Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Scaffold(
                      appBar: AppBar(
                        iconTheme: IconThemeData(
                            color: Color.fromRGBO(223, 24, 39, 0.9)),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        title: Center(
                          child: ListTile(
                            title: Text("Payment",
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
                              top: 20.0, left: 10, right: 10),
                          child: Container(
                            child: Image.asset("assets/images/noInternet.webp"),
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text("Sorry! Connection failed",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        )),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Your internet might be unstable",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                        ))
                      ]))))
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    iconTheme:
                        IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Center(
                      child: ListTile(
                        title: Text("Payment",
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
                      Divider(),
                      ListTile(
                        title: Text("Amount Payable",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        trailing: Text("₹${widget.amount}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      Divider(),
                      Column(
                        children: [
                          ListTile(
                            title: Text("Payment Options",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                          Divider(),
                          ListTile(
                            leading: Container(
                                child: Icon(
                              Icons.smartphone,
                              // color: Colors.white,
                            )),
                            title: Text("UPI"),
                            trailing: Icon(
                              Icons.arrow_forward_ios,

                              //color: Colors.white,
                            ),
                            onTap: () {
                              splashColor:
                              Color.fromARGB(255, 48, 48, 48);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UPI(
                                      amount: widget.amount,
                                      movieName: widget.movieName,
                                      cinemaName: widget.cinemaName,
                                      mydate: widget.mydate,
                                      tickets: widget.tickets,
                                      totalprice: widget.totalprice,
                                      finalList: widget.finalList,
                                      mytime: widget.mytime,
                                      currentList: widget.currentList,
                                      cinemaId: widget.cinemaId,
                                      movieImage: widget.movieImage),
                                ),
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Container(
                                child: Icon(
                              Icons.payment,
                              //color: Colors.white,
                            )),
                            title: Text("Card"),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              // color: Colors.white,
                            ),
                            onTap: () {
                              splashColor:
                              Color.fromARGB(255, 48, 48, 48);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Cards(
                                      amount: widget.amount,
                                      movieName: widget.movieName,
                                      cinemaName: widget.cinemaName,
                                      mydate: widget.mydate,
                                      tickets: widget.tickets,
                                      totalprice: widget.totalprice,
                                      finalList: widget.finalList,
                                      mytime: widget.mytime,
                                      currentList: widget.currentList,
                                      cinemaId: widget.cinemaId,
                                      movieImage: widget.movieImage),
                                ),
                              );
                            },
                          ),
                          Divider(),
                        ],
                      ),
                      Image.asset("assets/images/rewards.webp"),
                      SizedBox(height: 50),
                    ])),
                  ));
        });
  }
}
