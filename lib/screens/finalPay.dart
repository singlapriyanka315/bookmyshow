import 'package:bookmyapp/blocs/profile_bloc/profile_bloc.dart';
import 'package:bookmyapp/blocs/seats_bloc/seats_bloc.dart';
import 'package:bookmyapp/screens/paymentMethod.dart';
import 'package:bookmyapp/screens/profile_screens/edit_profile.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FinalPay extends StatefulWidget {
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

  FinalPay(
      {required this.movieName,
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
  State<FinalPay> createState() => _FinalPayState();
}

int fee = 63;
int confee = 1;
int totalamount = 0;

// var slotdate;
// slotdate = widgetmydate;
// var formatdate = (DateFormat.MMMd().format(slotdate));

class _FinalPayState extends State<FinalPay> {
  @override
  initState() {
    BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
    BlocProvider.of<SeatsBloc>(context).add(FetchSeats(
        movieName: widget.movieName,
        cinemaName: widget.cinemaName,
        date: widget.mydate,
        time: widget.mytime));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
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
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 5.0),
                                child: ListTile(
                                  title: Text("Almost there!",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          body: SingleChildScrollView(
                              child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 10, right: 10),
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
                        iconTheme: IconThemeData(
                            color: Color.fromRGBO(223, 24, 39, 0.9)),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        title: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 5.0),
                            child: ListTile(
                              title: Text("Almost there!",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                            child: Column(children: [
                          ListTile(
                              title: Text("${widget.movieName}"),
                              subtitle: Text(
                                  "${DateFormat.yMMMEd().format(DateTime.parse(widget.mydate))}")),
                          ListTile(
                            title: Text("${widget.cinemaName}"),
                            // subtitle: Text("cinema name and info")
                          ),
                          Divider(),
                          ListTile(
                              leading: Text("Ticket"),
                              trailing: Text("${widget.tickets}")),
                          ListTile(
                              title: Text("Ticket Price"),
                              subtitle: Text(
                                  "₹${widget.totalprice / widget.tickets} per ticket"),
                              trailing: Text("₹${widget.totalprice}")),
                          ListTile(
                              leading: Text("Convenience fees"),
                              trailing: Text("₹${fee}")),
                          ListTile(
                              leading: Image.asset("assets/images/my.jpeg"),
                              title: Text("Contribution to BookASmile"),
                              subtitle: Text("₹1 per ticket will be added"),
                              trailing: Text("₹${widget.tickets}")),
                          ListTile(
                              title: Text("Total Payable Amount"),
                              trailing: Text(
                                  "₹${widget.totalprice + fee + widget.tickets * confee}")),
                          Divider(
                            thickness: 5,
                            indent: 20,
                            endIndent: 20,
                            color: Colors.black,
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text("Contact Details",
                                    style: TextStyle(fontSize: 18)),
                              )),
                          BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                            if (state is ProfileLoading) {
                              return ListTile(
                                  //leading: Text("Contact Details"),
                                  title: Text("Email"),
                                  subtitle: Text("Contact Number"));
                            } else if (state is ProfileLoaded) {
                              return ListTile(
                                //leading: Text("Contact Details"),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 45, 45, 45),
                                ),
                                title: Text("${state.profileData['email']}"),
                                subtitle: Text("${state.profileData['phone']}"),
                                onTap: () {
                                  splashColor:
                                  Color.fromARGB(255, 48, 48, 48);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Edit_profile(),
                                    ),
                                  ).then((_) {
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(FetchProfile());
                                  });
                                },
                              );
                            } else {
                              return ListTile(
                                  title: Text(""),
                                  subtitle: Text(""));
                            }
                          }),
                          Divider(),
                          SizedBox(height: 20),
                        ])),
                      ),
                      bottomNavigationBar: BottomAppBar(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0),
                          child: BlocBuilder<SeatsBloc, SeatsState>(
                              builder: (context, state) {
                            return CupertinoButton(
                              color: Color.fromRGBO(223, 24, 39, 0.9),
                              borderRadius: BorderRadius.circular(200),
                              child: Text("Pay"),
                              onPressed: () {
                                totalamount = widget.totalprice +
                                    fee +
                                    widget.tickets * confee;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentMethod(
                                          amount: totalamount,
                                          movieName: widget.movieName,
                                          cinemaName: widget.cinemaName,
                                          mydate: widget.mydate,
                                          tickets: widget.tickets,
                                          totalprice: widget.totalprice,
                                          finalList: widget.finalList,
                                          mytime: widget.mytime,
                                          currentList: widget.currentList,
                                          cinemaId: widget.cinemaId,
                                          movieImage: widget.movieImage)),
                                );
                              },
                            );
                          }),
                        ),
                      ));
            }));
  }
}
