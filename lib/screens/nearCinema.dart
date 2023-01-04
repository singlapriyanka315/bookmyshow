import 'package:bookmyapp/apis/cinema_detail.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../apis/TimeCinema.dart';
import '../apis/showtime.dart';

class NearCinemas extends StatefulWidget {
  final moviedata;
  var Nearcinemadata;

  NearCinemas({required this.moviedata, super.key});
  @override
  _CinemasState createState() => _CinemasState(moviedata);
}

class _CinemasState extends State<NearCinemas> {
  // final _currentDate = DateTime.now();
  // final _dayFormatter = DateFormat('d');
  // final _monthFormatter = DateFormat('MMM');
  final Map<String, Marker> _markers = {};
  //Set<Marker> _markers = {};
//Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final date =
      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
  List<DateTime> days = [];
  var detailCinemaData;
  late List Nearcinemadata;

  List<DateTime> generateDays(int n) {
    DateTime currentDay = DateTime.now();
    for (int i = 0; i < n; i++) {
      days.add(currentDay.add(Duration(days: i)));
    }
    return days;
  }

  initState() {}

  final moviedata;

  _CinemasState(this.moviedata);

  gettimedata(int filmId, int cinemaId) async {
    final List Nearcinematime = await getshowtime(filmId, cinemaId);
    return Nearcinematime;
  }

  getdata() async {
    Nearcinemadata = await getNearCinema(moviedata.film_id);

    // final List cinemadata = await getCinema(moviedata.film_id);
    print(" Nearcinemadata");
    // print(moviedata.film_name);
    print(Nearcinemadata.length);
    return Nearcinemadata;
  }

  getcinemainfo(id) async {
    detailCinemaData = await getCinemaDetail(id);
    print("hiiiiii");
    print(detailCinemaData.distance);
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
                      child: Text(
                          "${detailCinemaData.cinema_name} : ${detailCinemaData.city}",
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
                      child: Text("${detailCinemaData.distance} miles",
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
                              "${detailCinemaData.address},${detailCinemaData.address2}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 13)),
                          Text(
                              "${detailCinemaData.city}, ${detailCinemaData.state}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 13)),
                          // TextButton(onPressed: () { print("hi");}, child:
                          Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon:
                                      Icon(Icons.gps_fixed, color: Colors.red),
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
        return Scaffold(
          appBar: AppBar(
            title: Text('${moviedata.film_name}'),
          ),
          body: Column(
            children: [
              FutureBuilder(
                  future: getdata(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return Expanded(
                          child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) => Container(
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
                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.black),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () async {
                                          //String id = snapshot.data[index].cinemaId.toString();
                                          var detailCinemaData =
                                              await getcinemainfo(
                                                  snapshot.data[index].cinema_id);
                                          showModalSheet(detailCinemaData);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                ("${snapshot.data[index].cinema_name}"),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                            Align(
                                                alignment: Alignment.centerRight,
                                                child: Icon(Icons.info,
                                                    color: Colors.red))
                                          ],
                                        ),
                                        // child:Text(
                                        //     "${snapshot.data[index].cinemaName}",)
                                      )),
                                ),
                                FutureBuilder(
                                    future: gettimedata(moviedata.film_id,
                                        snapshot.data[index].cinema_id),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return ListView.builder(
                                          physics: const ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          // scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data.length,
                                          itemBuilder:
                                              (BuildContext context, int index2) =>
                                                  Container(
                                            ///height: 50,
                                            child:
                                                // Card(
                                                //   elevation: 3,
                                                //   margin: const EdgeInsets.all(10),
                                                //   child:
                                                Expanded(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15),
                                                  Center(
                                                    child: GridView.builder(
                                                      itemCount: snapshot
                                                          .data[index2]
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
                                                      itemBuilder:
                                                          (context, index3) {
                                                        return Center(
                                                          child: TextButton(
                                                            onPressed: () {
                                                              String time = snapshot
                                                                  .data[index2]
                                                                  .showings
                                                                  .standard
                                                                  .times[index3]
                                                                  .startTime;
                                                              //              Navigator.of(context).push(
                                                              //   MaterialPageRoute(
    
                                                              //     builder: (_) => SelectSeat(
                                                              //         time : time, index: index, index2: index2, index3: index3, data:snapshot.data, nearcinemadata : Nearcinemadata, moviedata: moviedata  ),
                                                              //   ),
                                                              // );
                                                              print(snapshot
                                                                  .data[index2]
                                                                  .showings
                                                                  .standard
                                                                  .times[index3]
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
                                                                snapshot
                                                                    .data[index2]
                                                                    .showings
                                                                    .standard
                                                                    .times[index3]
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
                                            ),
                                            // Center(
                                            // ),
                                          ),
                                        );
                                      }
                                      return const Center(child: Text(""));
                                    }),
                              ],
                            ),
                            // Center(
                          ),
                        ),
                      ));
                    }
                     return Center(
                      child: 
                      Container(
                          height: 100,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 14.0),
                            child:
                            SpinKitThreeBounce(
                            color: Color.fromRGBO(223, 24, 39, 0.9),
                             size: 25.0
                                // Image.asset("assets/images/popcorn-nouns-dao.gif"),
                          )),
                      )
    
                    );
                  }),
            ],
          ),
          // ),
        );
      }
    );
  }
}
