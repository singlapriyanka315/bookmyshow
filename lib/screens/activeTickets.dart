import 'package:bookmyapp/blocs/activeTicket_bloc/activeTicket_bloc.dart';
import 'package:bookmyapp/apis/cinema_detail.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

class ActiveTicket extends StatefulWidget {
  const ActiveTicket({super.key});

  @override
  State<ActiveTicket> createState() => _ActiveTicketState();
}

class _ActiveTicketState extends State<ActiveTicket> {
  var detailCinemaData;
  String? distance;
  var subscription;
  var result;
  final Map<String, Marker> _markers = {};
  @override
  initState() {
    BlocProvider.of<ActiveTicketBloc>(context).add(FetchActiveTicket());
  }

  getcinemainfo(id) async {
    detailCinemaData = await getCinemaDetail(id);
    print("hi");

    print(detailCinemaData.distance);
    distance = await detailCinemaData.distance.toStringAsFixed(2);
    return detailCinemaData;
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      final marker = Marker(
          markerId: MarkerId(detailCinemaData.cinema_id),
          position: LatLng(detailCinemaData.lat, detailCinemaData.lng),
          infoWindow: InfoWindow(
              title: detailCinemaData.cinema_name,
              snippet: detailCinemaData.address,
              onTap: () {
                print("you tapped me");
              }),
          onTap: () {
            print("hi");
          });
      _markers[detailCinemaData.cinema_name] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    launchMap(lat, long) {
      MapsLauncher.launchCoordinates(lat!, long!);
    }

    void showModalSheet(detailCinemaData) {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
                margin:
                    new EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${detailCinemaData.cinema_name}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20))),
                    Divider(),
                    Expanded(
                      child: GoogleMap(
                        onMapCreated: onMapCreated,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                detailCinemaData.lat, detailCinemaData.lng),
                            zoom: 7),
                        markers: _markers.values.toSet(),
                      ),
                    ),
                    Divider(),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${distance} miles away",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16))),
                    Divider(),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            Text(
                                "${detailCinemaData.address},${detailCinemaData.address2},${detailCinemaData.city}, ${detailCinemaData.state}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16)),
                            // TextButton(onPressed: () { print("hi");}, child:
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    icon: Icon(Icons.gps_fixed,
                                        color:
                                            Color.fromARGB(255, 129, 118, 117)),
                                    onPressed: () {
                                      launchMap(detailCinemaData.lat,
                                          detailCinemaData.lng);
                                    }))
                          ],
                        )),
                    SizedBox(height: 20)
                  ],
                ));
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
            child: ListTile(
              title: Text("Active Tickets",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            return SingleChildScrollView(
                child: snapshot.data == ConnectivityResult.none
                    ? Column(children: [
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
                      ])
                    : BlocBuilder<ActiveTicketBloc, ActiveTicketState>(
                        builder: (context, state) {
                          if (state is ActiveTicketLoading) {
                            return Center(
                                child: Container(
                              height: 100,
                              width: 100,
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 14.0),
                                  child: SpinKitThreeBounce(
                                      color: Color.fromRGBO(223, 24, 39, 0.9),
                                      size: 25.0
                                      // Image.asset("assets/images/popcorn-nouns-dao.gif"),
                                      )),
                            ));
                          } else if (state is ActiveTicketError) {
                            if (state.error ==
                                "Failed host lookup: 'api-gate2.movieglu.com'") {
                              return Column(children: [
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
                              ]);
                            }
                            return Text("${state.error}");
                          } else if (state is ActiveTicketLoaded) {
                            return Column(children: [
                              (state.ticketsnow.length != 0 &&
                                      state.ticketsnow != null &&
                                      state.ticketsnow.isEmpty == false)
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.ticketsnow.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          elevation: 5,
                                          margin: EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 16.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          //  DateFormat('KK:mm a').format(state.ticketsnow[index]['orderedTime']);
                                          child: Column(
                                            children: [
                                              Divider(),
                                              SizedBox(height: 10),
                                              Text(
                                                  "Ordered on: ${state.ticketsnow[index]['orderedDate']} at ${state.ticketsnow[index]['orderedTime']} ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 10),
                                              SizedBox(height: 10),
                                              ListTile(
                                                leading: Image.network(
                                                  "${state.ticketsnow[index]['movieImage']}",
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return Image.asset(
                                                        "assets/images/errorr.webp");
                                                  },
                                                ),
                                                title: Text(
                                                    "${state.ticketsnow[index]['name']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    "${state.ticketsnow[index]['seats'].length} ticket : ${state.ticketsnow[index]['seats']}"),
                                                trailing: Text(
                                                    "${state.ticketsnow[index]['mydate']} at ${state.ticketsnow[index]['time']}"),
                                              ),
                                             // GestureDetector(
                                               
                                                 Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                        "${state.ticketsnow[index]['cinema']}",
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                  GestureDetector(
                                                     child: const Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Icon(Icons.info,
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      129,
                                                                      118,
                                                                      117))),
                                                                       onTap: () async {
                                                  var result =
                                                      await Connectivity()
                                                          .checkConnectivity();
                                                  if (result ==
                                                      ConnectivityResult
                                                          .mobile) {
                                                    print(
                                                        "Internet connection is from Mobile data");
                                                    var detailCinemaData =
                                                        await getcinemainfo(
                                                            int.parse(
                                                                "${state.ticketsnow[index]['cinemaId']}"));
                                                    print("detailCinemaData");
                                                    print(detailCinemaData);
                                                    showModalSheet(
                                                        detailCinemaData);
                                                  } else if (result ==
                                                      ConnectivityResult.wifi) {
                                                    var detailCinemaData =
                                                        await getcinemainfo(
                                                            int.parse(
                                                                "${state.ticketsnow[index]['cinemaId']}"));
                                                    print("detailCinemaData");
                                                    print(detailCinemaData);
                                                    showModalSheet(
                                                        detailCinemaData);
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: const Text(
                                                            "Poor Internet Connection, Try again."),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        //backgroundColor: Colors.teal,
                                                        action: SnackBarAction(
                                                          label: 'Dismiss',
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                   )
                                                  ],
                                                ),
                                              
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : const ListTile(
                                      title: Center(
                                          child: Text("No Active Tickets",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      subtitle: Center(
                                        child: Text(
                                          "Go ahead and book a movie",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))
                            ]);
                          } else {
                            return Text("Oops! Something went wrong. Please try again later...");
                          }
                        },
                      ));
          }),
    );
  }
}
