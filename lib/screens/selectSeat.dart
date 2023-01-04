// ignore_for_file: unnecessary_string_interpolations
import 'package:bookmyapp/screens/finalPay.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../blocs/seats_bloc/seats_bloc.dart';

class SelectSeat extends StatefulWidget {
  String time;
  final data, moviedata;
  String mydate;
  int index, index2;
  int selectedSeat = -1;

  // bool seatSelected = false; 
   List seatIndex = [];
  List seatsoften = [];
  List<dynamic> finallist = [];
  int cinemaId;
  String movieImage;

  SelectSeat(
      {required this.time,
      required this.data,
      required this.moviedata,
      required this.mydate,
      required this.index,
      required this.index2,
      required this.cinemaId,
      required this.movieImage,
      super.key});

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  //List ticket = [];
  int price = 200;
  @override
  void initState() {

    BlocProvider.of<SeatsBloc>(context).add(FetchSeats(
        movieName: widget.moviedata.film_name,
        cinemaName: widget.data[widget.index].cinemaName,
        date: widget.mydate,
        time: widget.time));
    print("I am below bloc");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none
              ? Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: const Color.fromARGB(255, 43, 56, 97),
                        title: ListTile(
                          title: Text(
                            '${widget.moviedata.film_name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle:
                              Text("${widget.data[widget.index].cinemaName}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
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
                      ]))))
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor:const Color.fromARGB(255, 43, 56, 97),
                    title: ListTile(
                      title: Text(
                        '${widget.moviedata.film_name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("${widget.data[widget.index].cinemaName}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  body: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(
                        const Duration(seconds: 1),
                        () {

                          BlocProvider.of<SeatsBloc>(context).add(FetchSeats(
                              movieName: widget.moviedata.film_name,
                              cinemaName: widget.data[widget.index].cinemaName,
                              date: widget.mydate,
                              time: widget.time));
                        },
                      );
                    },
                    child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                      child: BlocBuilder<SeatsBloc, SeatsState>(
                          builder: (context, state) {
                        if (state is SeatsLoading) {
                          return const Center(
                              child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Padding(
                                padding:  EdgeInsets.only(right: 14.0),
                                child: SpinKitThreeBounce(
                                    color: Color.fromRGBO(223, 24, 39, 0.9),
                                    size: 25.0
                                    )),
                          ));
                        } else if (state is SeatsLoaded) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50.0, top: 20),
                                      child: Text(
                                          "Date & Time: ${DateFormat.yMMMEd().format(DateTime.parse(widget.mydate))} | ${widget.time} ",
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  223, 24, 39, 0.9),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:20.0, vertical:20),
                                child: GridView.builder(
                                  itemCount: 168,
                                  shrinkWrap: true, // new line
                                  physics:
                                      const NeverScrollableScrollPhysics(), // new line
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 12),
                                  itemBuilder: (context, index) {
                                    return state.ticket.contains(index)
                                        ? Center(
                                            child: IconButton(
                                              disabledColor: const Color.fromARGB(
                                                    255, 69, 69, 69),
                                              icon: const Icon(
                                                Icons.square,
                                                color: Color.fromARGB(
                                                    255, 69, 69, 69),
                                              ),
                                              onPressed: () {
                                                null;
                                              },
                                            ),
                                          )
                                        : Center(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.crop_square_sharp,
                                                color: (widget.seatsoften
                                                        .contains(index))
                                                    ? const Color.fromRGBO(
                                                        223, 24, 39, 0.9)
                                                    : Color.fromARGB(255, 4, 172, 13),
                                              ),
                                              onPressed: () {
                                                // seatIndex.add(widget.index);
                                                // print(seatIndex);

                                                if (widget.seatsoften
                                                    .contains(index)) {
                                                  //seatSelected = false;
                                                  widget.seatsoften
                                                      .remove(index);
                                                  widget.seatIndex
                                                      .remove(index);
                                                  print(widget.seatIndex);
                                                } else {
                                                  print(widget.seatIndex);
                                                  if (widget.seatIndex.length <
                                                      6) {
                                                    widget.seatIndex.add(index);
                                                    widget.seatsoften
                                                        .add(index);
                                                    print(widget.seatIndex);
                                                  } else {
                                                    showMax();
                                                  
                                                    
                                                  }
                                      
                                                }
                                                setState(() {});
                                              },
                                            ),
                                          );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 15.0,
                                  width: 300.0,
                                  color: Colors.transparent,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 43, 56, 97),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: const Center(
                                          // child: new Text("Rounded Corner Rectangle Shape",
                                          // style: TextStyle(color: Colors.white, fontSize: 22),
                                          // textAlign: TextAlign.center,),
                                          )),
                                ),
                              ),
                              const Text(
                                "All eyes this way please!",
                                style: TextStyle(
                                    color: Color.fromRGBO(223, 24, 39, 0.9),
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height:5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0, vertical: 5.0),
                                child: Row(children: const [
                                   Icon(
                                    Icons.square,
                                    color: Color.fromARGB(
                                                    255, 69, 69, 69),
                                  ),
                                   Text("Sold"),
                                   SizedBox(width: 10),
                                   Icon(
                                    Icons.crop_square_sharp,
                                    color: Colors.green,
                                  ),
                                   Text("Available"),
                                   SizedBox(width: 10),
                                   Icon(
                                    Icons.crop_square_sharp,
                                    color: Color.fromRGBO(223, 24, 39, 0.9),
                                  ),
                                  Text("Selected"),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0),
                                child: Row(children: [
                                  TextButton(
                                      child: Text(
                                          "Ticket count:${widget.seatIndex.length}"),
                                      onPressed: () {
                                        null;
                                      }),
                                  const SizedBox(width: 10),
                                  TextButton(
                                      child: Text(
                                          "To Pay:${widget.seatIndex.length * price}"),
                                      onPressed: () {
                                        null;
                                      }),
                                ]),
                              ),
                              SizedBox(
                                width: 350,
                                child: CupertinoButton(
                                    borderRadius: BorderRadius.circular(200),
                                    color: const Color.fromRGBO(223, 24, 39, 0.9),
                                    child: const Text('Proceed to Pay'),
                                    onPressed: () {
                                      if (widget.seatIndex.isNotEmpty) {
                                        widget.finallist.addAll(state.ticket);
                                        print("i am final list 1");
                                        print(widget.finallist);
                                        widget.finallist
                                            .addAll(widget.seatIndex);
                                        print("i am final list 2");
                                        print(widget.finallist);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FinalPay(
                                                  movieName: widget
                                                      .moviedata.film_name,
                                                  cinemaName: widget
                                                      .data[widget.index]
                                                      .cinemaName,
                                                  mydate: widget.mydate,
                                                  mytime: widget.time,
                                                  finalList: widget.finallist,
                                                  currentList: widget.seatIndex,
                                                  tickets:
                                                      widget.seatIndex.length,
                                                  totalprice:
                                                      widget.seatIndex.length *
                                                          price,
                                                  movieImage: widget.movieImage,
                                                  cinemaId: widget.cinemaId),
                                            ));
                                      } else {
                                        showPopup();


                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //     content: Text(
                                        //         "Please select at least one ticket"),
                                        //     behavior: SnackBarBehavior.floating,
                                        //     //backgroundColor: Colors.teal,
                                        //     action: SnackBarAction(
                                        //       label: 'Dismiss',
                                        //       textColor: Colors.white,
                                        //       onPressed: () {},
                                        //     ),
                                        //   ),
                                        // );
                                      }
                                    }),
                              ),
                              const SizedBox(
                                width: 40,
                                height: 20,
                              ),
                            ],
                          );
                        }
                        if (state is SeatsError) {
                          if (state.error ==
                              "Failed host lookup: 'api-gate2.movieglu.com'") {
                            return Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 10, right: 10),
                                  child: Image.asset(
                                      "assets/images/noInternet.webp"),
                                ),
                              const Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text("Sorry! Connection failed",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              )),
                             const Center(
                                  child: Padding(
                                padding:  EdgeInsets.only(top: 8.0),
                                child: Text("Your internet might be unstable",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey)),
                              ))
                            ]);
                          } else {
                            return Center(
                              child: Text(state.error),
                            );
                          }
                        } else {
                          return const Text("I am else");
                        }
                      }),
                    ),
                  ),
                );
        });
  }

 void showPopup() {
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
                      "Please select at least one ticket",
                      style: TextStyle(
                        backgroundColor: CupertinoColors.white,
                        color:Color.fromRGBO(223, 24, 39, 0.9),
                        fontSize: 18,
                        fontWeight : FontWeight.bold
                      ),
                    )),
                    Divider(color : Color.fromARGB(255, 93, 92, 92)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CupertinoButton(
                             color: Color.fromRGBO(223, 24, 39, 0.9),
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
                      "You can book maximum 6 tickets at once",
                      style: TextStyle(
                        backgroundColor: CupertinoColors.white,
                        color:Color.fromRGBO(223, 24, 39, 0.9),
                        fontSize: 18,
                        fontWeight : FontWeight.bold
                      ),
                    )),
                    Divider(color : Color.fromARGB(255, 93, 92, 92)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CupertinoButton(
                             color: Color.fromRGBO(223, 24, 39, 0.9),
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
