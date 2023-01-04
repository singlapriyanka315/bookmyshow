import 'package:bookmyapp/blocs/order_bloc/order_bloc.dart';
import 'package:bookmyapp/apis/cinema_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

// DateTime now = DateTime.now();
// String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

class Order_screen extends StatefulWidget {
  const Order_screen({super.key});

  @override
  State<Order_screen> createState() => _Order_screenState();
}
final Map<String, Marker> _markers = {};
  int selected = 0;
  String mydate= " ";
  List project=[];
  var detailCinemaData;
   //final moviedata;
  String? distance;



void getMovieTicket() async {
  User? user = await FirebaseAuth.instance.currentUser;
  final snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
  print(snapshot.data());
  print("1snapshot.data()");
  print(snapshot.data()!['ticket'][0]);
}

class _Order_screenState extends State<Order_screen> {
  @override
  initState() {
    BlocProvider.of<OrderBloc>(context).add(FetchOrder());
    //getMovieTicket();
    print("1snapshot.data()");
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                  child: ListTile(
                    title: Text("Orders",
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
              child:
                  BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
                if (state is OrderLoading) {
               return Center(
                    child: Container(
                  height: 100,
                  width: 100,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: SpinKitThreeBounce(
                          color: Color.fromRGBO(223, 24, 39, 0.9), size: 25.0
                          // Image.asset("assets/images/popcorn-nouns-dao.gif"),
                          )),
                ));
                } else if (state is OrderLoaded) {
                  return 
                    Column(
                      children: [ 
                        (state.orders.length>0)?
                        ListView.builder(
                           scrollDirection: Axis.vertical,
                           physics: NeverScrollableScrollPhysics(),
                        
                        shrinkWrap: true,
                        itemCount: state.orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                             elevation:5,
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                            child: Column(
                              children: [
                                Divider(),
                                SizedBox(height:10),
                                Text("Ordered on: ${state.orders[index]['orderedDate']} at ${state.orders[index]['orderedTime']} ", style:TextStyle(fontSize:15, fontWeight:FontWeight.bold)),
                                    SizedBox(height:10),
                               
                                   SizedBox(height:10),
                                ListTile(
                                  leading:Image.network("${state.orders[index]['movieImage']}"),
                                  title: Text("${state.orders[index]['name']}", style:TextStyle(fontSize:15, fontWeight:FontWeight.bold)),
                                   subtitle:  Text("${state.orders[index]['seats'].length} ticket : ${state.orders[index]['seats']}"),
                                   trailing:  Text("${state.orders[index]['mydate']} at ${state.orders[index]['time']}"),
                                                 ),
                                                 GestureDetector(
                                      onTap: () async {
                                        //String id = snapshot.data[index].cinemaId.toString();
                                        var result = await Connectivity().checkConnectivity();
                                       if(result == ConnectivityResult.mobile) {
                                       print("Internet connection is from Mobile data");
                                       var detailCinemaData =
                                            await getcinemainfo(
                                               int.parse("${state.orders[index]['cinemaId']}"));
                                        showModalSheet(detailCinemaData);
                                       }else if(result == ConnectivityResult.wifi) {
                                        print("internet connection is from wifi");
                                         var detailCinemaData =
                                            await getcinemainfo(
                                               int.parse("${state.orders[index]['cinemaId']}"));
                                        showModalSheet(detailCinemaData);
                                       }
                                       else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                       content: Text("Poor Internet Connection, Try again."),
                                       behavior: SnackBarBehavior.floating,
                                //backgroundColor: Colors.teal,
                                      action: SnackBarAction(
                                      label: 'Dismiss',
                                  textColor: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                            );
                                       }




                                       
                                        // project.add(1);
                                        // print(project);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("${state.orders[index]['cinema']}", style:TextStyle(fontSize:13, fontWeight:FontWeight.bold)),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(Icons.info,
                                                  color: Color.fromARGB(
                                                      255, 129, 118, 117)))
                                        ],
                                      ),
                                   
                                    )
                              ],
                            ),
                          );
                        },
              ):Container(
                      child:
                        ListTile(
                          title: Center(child: Text("No Ticket Booked yet " , style:TextStyle(fontSize:15, fontWeight:FontWeight.bold))),
                          subtitle:Center(
                            child: Text("Go ahead and book a movie ticket" , style:TextStyle(fontSize:13, fontWeight:FontWeight.bold),

                        ),
                          )
                          ),
                )
                      ]
                    );
                } else {
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
                }
              }),
            )));
  }
}
