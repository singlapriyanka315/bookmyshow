import 'package:bookmyapp/blocs/liveMovie_bloc/liveMovie_bloc.dart';
import 'package:bookmyapp/blocs/nearCinemas_bloc/nearCinema_bloc.dart';
import 'package:bookmyapp/apis/cinema_detail.dart';
import 'package:bookmyapp/apis/closest_showing.dart';
import 'package:bookmyapp/screens/selectSeat.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../apis/TimeCinema.dart';

class Cinemas extends StatefulWidget {
  final moviedata;
  List Nearcinemadata = [];

  Cinemas({required this.moviedata, super.key});
  @override
  _CinemasState createState() => _CinemasState(moviedata);
}

class _CinemasState extends State<Cinemas> {
  final Map<String, Marker> _markers = {};
  int selected = 0;
  String mydate = " ";
  List project = [];
  String today = "";
  final date =
      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

  List<DateTime> days = [];
  var detailCinemaData;

  List<DateTime> generateDays(int n) {
    DateTime currentDay = DateTime.now();
    for (int i = 0; i < n; i++) {
      days.add(currentDay.add(Duration(days: i)));
    }

    return days;
  }

  initState() {

    generateDays(7);
    print("i am date");

    print(DateFormat.MMMd().format(days[0]));
    if (days[0].day < 10) {
      mydate = "${days[0].year}-${days[0].month}-0${days[0].day}";
    } else {
      mydate = "${days[0].year}-${days[0].month}-${days[0].day}";
    }
    print(mydate);

    print(days[0].day);

       BlocProvider.of<NearCinemaBloc>(context).add(FetchNearCinema(moviedata.film_id, mydate));
  }

  final moviedata;
  String? distance;



  _CinemasState(this.moviedata);
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
    // setState(() {
    //   _markers[MarkerId(detailCinemaData.address)] = marker;
    // });
  }

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return snapshot.data == ConnectivityResult.none
              ? Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Scaffold(
                      resizeToAvoidBottomInset: true,
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        title: Text('${moviedata.film_name}'),
                        backgroundColor: Color.fromARGB(255, 43, 56, 97),
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
                  appBar: AppBar(
                    title: Text('${moviedata.film_name}'),
                    backgroundColor: Color.fromARGB(255, 43, 56, 97),
                  ),
                  body: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () {
                        },
                      );
                    },
                    child: Column(
                        
                      children: [
                        GridView.builder(
                          itemCount: days.length,
                          shrinkWrap: true, // new line
                          physics:
                              const NeverScrollableScrollPhysics(), // new line
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7),
                          itemBuilder: (context, i) {
                            return Center(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    selected = i;
                                    if (days[i].day < 10) {
                                      mydate =
                                          "${days[i].year}-${days[i].month}-0${days[i].day}";

                      


                                    } else {
                                      mydate =
                                          "${days[i].year}-${days[i].month}-${days[i].day}";


                                    }
                                  });


                                  print("i am button");
                                  print(i);
                                     BlocProvider.of<NearCinemaBloc>(context).add(FetchNearCinema(widget.moviedata.film_id, mydate));
                                },
                                child: Text(DateFormat.MMMd().format(days[i]),
                                    style: selected == i
                                        ? TextStyle(
                                            color:
                                                Color.fromARGB(255, 255, 3, 3),
                                            fontSize: 11,
                                          )
                                        : TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 11,
                                          )),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<NearCinemaBloc, NearCinemaState>(
                        builder: (context, state) {
                          if(state is NearCinemaLoading){
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
                          }

                           else if(state is NearCinemaError){
                           if (state.error == "Failed host lookup: 'api-gate2.movieglu.com'"){
                                    return  Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, right: 10),
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
                      ]);
            
                                  }
                                  else {
                                    return Text(
                                        "${state.error.toString()}"
                                        );
                                  }
                          }
                                  else if (state is NearCinemaLoaded) {

                                    if (state.cinemadata.isEmpty) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 240, horizontal: 10),
                                          child: Text(
                                              "Oops! ${moviedata.film_name} is not streaming in cinemas for selected date, try for another",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 255, 3, 3),
                                                  fontSize: 22)),
                                        ),
                                      );
                                    }
                                     else {
                                      return Expanded(
                                          child: ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.horizontal,
                                        itemCount: state.cinemadata.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Container(
                                          ///height: 50,
                                          child: Card(
                                            elevation: 3,
                                            margin: const EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 15),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                      margin:
                                                          new EdgeInsets.symmetric(
                                                              horizontal: 20.0),
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              width: 1,
                                                              color: Colors.black),
                                                        ),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          //String id = snapshot.data[index].cinemaId.toString();
                        
                                                          var detailCinemaData =
                                                              await getcinemainfo(
                                                                 state.cinemadata[index]
                                                                      .cinemaId);
                                                          print("detailCinemaData");
                                                          print(detailCinemaData);
                                                          showModalSheet(
                                                              detailCinemaData);
                                                          project.add(1);
                                                          print("project");
                                                          print(project);
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                ("${state.cinemadata[index].cinemaName}"),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Icon(
                                                                    Icons.info,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            129,
                                                                            118,
                                                                            117)))
                                                          ],
                                                        ),
                                                        // child:Text(
                                                        //     "${snapshot.data[index].cinemaName}",)
                                                      )),
                                                ),
                                                Center(
                                                  child: GridView.builder(
                                                    itemCount: state.cinemadata[index]
                                                        .showings
                                                        .standard
                                                        .times
                                                        .length,
                                                    shrinkWrap: true, // new line
                                                    physics:
                                                        const NeverScrollableScrollPhysics(), // new line
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 5),
                                                    itemBuilder: (context, index2) {
                                                      return Center(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            print("mydate");
                                                            String time = state.cinemadata[index]
                                                                .showings
                                                                .standard
                                                                .times[index2]
                                                                .startTime;
                                                            Navigator.of(context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder: (_) => SelectSeat(
                                                                    time: time,
                                                                    index: index,
                                                                    index2: index2,
                                                                    data: state.cinemadata,
                                                                    moviedata:
                                                                        moviedata,
                                                                    movieImage:
                                                                        moviedata
                                                                            .film_image,
                                                                    mydate: mydate,
                                                                    cinemaId: state.cinemadata[index]
                                                                        .cinemaId),
                                                              ),
                                                            );
                                                            print(state.cinemadata[index]
                                                                .showings
                                                                .standard
                                                                .times[index2]
                                                                .startTime);
                                                          },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Color
                                                                          .fromARGB(
                                                                              228,
                                                                              227,
                                                                              41,
                                                                              57))),
                                                          child: Text(
                                                              state.cinemadata[index]
                                                                  .showings
                                                                  .standard
                                                                  .times[index2]
                                                                  .startTime,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            // Center(
                                          ),
                                        ),
                                      ));
                                    }
                                  }
                                  else{
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
                                  }
                                            
                        }
                        ),
                      ],
                    ),
                  ),
                  // ),
                );
        });
  }
}
