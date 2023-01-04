import 'package:bookmyapp/blocs/activeTicket_bloc/activeTicket_bloc.dart';
import 'package:bookmyapp/blocs/moviesNow_bloc/movieNow_bloc.dart';
import 'package:bookmyapp/screens/activeTickets.dart';
import 'package:bookmyapp/screens/detail_screens/detailMovie.dart';
import 'package:bookmyapp/screens/search_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/detailMovie_bloc/detailMovie_bloc.dart';
import '../apis/Livefilm_api.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/live_movies.dart';
import '../models/now_showing.dart';
import '../email_auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final storage = FlutterSecureStorage();
Icon customIcon = const Icon(Icons.search);
Widget customSearchBar = const Text('It All Starts Here...');

class _HomeScreenState extends State<HomeScreen> {
  var subscription;
  bool conn = false;

  @override
  initState() {
    fetchData();
  }

  fetchData() async {
    BlocProvider.of<ActiveTicketBloc>(context).add(FetchActiveTicket());
    BlocProvider.of<MovieNowBloc>(context).add(FetchMovieNow());
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  List<FilmsNow> nowList = [];

  List<LiveFilm> liveList = [];
  final myController = TextEditingController();
  int selectedIndex = 0;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  liveSearch(String search) async {
    try {
      liveList = await getLive(search);
      print("soonList");
      print(liveList[0].film_id);
    } catch (err) {
      print("err");
    }
  }

  var userData;
  Future<void> signOut() async {
    try {
      await auth.signOut();
      await storage.delete(key: "uid");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
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

  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          BlocProvider.of<ActiveTicketBloc>(context).add(FetchActiveTicket());
          BlocProvider.of<MovieNowBloc>(context).add(FetchMovieNow());
          return SingleChildScrollView(
              // physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                AppBar(
                  backgroundColor: Color.fromARGB(255, 43, 56, 97),
                  title: const Text('It All Starts Here...'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SearchBar(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search),
                    ),
                    BlocBuilder<ActiveTicketBloc, ActiveTicketState>(
                      builder: (context, state) {
                        if (state is ActiveTicketLoading) {
                          return Stack(children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.notifications),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ActiveTicket(),
                                    ),
                                  );
                                }),
                          ]);
                        } else if (state is ActiveTicketLoaded) {
                          return Stack(children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.notifications_outlined),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ActiveTicket(),
                                    ),
                                  );
                                }),
                            state.ticketsnow.isNotEmpty
                                ? Positioned(
                                    right: 11,
                                    top: 11,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            223, 24, 39, 0.9),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 14,
                                        minHeight: 14,
                                      ),
                                      child: Text(
                                        '${state.ticketsnow.length}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ]);
                        } else {
                          return Stack(children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.notifications),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ActiveTicket(),
                                    ),
                                  );
                                }),
                          ]);
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(const Duration(seconds: 1), () {
                      BlocProvider.of<ActiveTicketBloc>(context)
                          .add(FetchActiveTicket());
                      BlocProvider.of<MovieNowBloc>(context)
                          .add(FetchMovieNow());
                    });
                  },
                  child: Container(
                    height: 1,
                    child: ListView.builder(
                        //  physics: const AlwaysScrollableScrollPhysics(),
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return const ListTile(title: Text(""));
                        }),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Text(
                      'Recommended Movies',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(223, 24, 39, 0.9),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: snapshot.data == ConnectivityResult.none
                      ? Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 10, right: 10),
                            child: Container(
                              child:
                                  Image.asset("assets/images/noInternet.webp"),
                            ),
                          ),
                          const Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text("Sorry! Connection failed",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          )),
                          const Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Your internet might be unstable",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ))
                        ])
                      : BlocBuilder<MovieNowBloc, MovieNowState>(
                          builder: (context, state) {
                          if (state is StateError) {
                            print(state.locationError);
                            if (state.locationError ==
                                "The location service on the device is disabled.") {
                              return Center(
                                  child: AlertDialog(
                                title: const Text("Location Required"),
                                content: const Text(
                                    "Please allow app to access your location"),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("Settings"),
                                    onPressed: () {
                                      AppSettings.openLocationSettings();
                                      //Navigator.of(context).pop();
                                    },
                                  ),
                                  BlocBuilder<DetailMovieBloc,
                                      DetailMovieState>(
                                    builder: (context, state) {
                                      return TextButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          BlocProvider.of<MovieNowBloc>(context)
                                              .add(FetchMovieNow());
                                        },
                                      );
                                    },
                                  )
                                ],
                              ));
                            } else if (state.locationError ==
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
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text("Your internet might be unstable",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey)),
                                ))
                              ]);
                            } else if (state.locationError ==
                                "User denied permissions to access the device's location.") {
                              return const Text(
                                  "Permissions denied to access the device's location. Please go to \"App Permissions\" allow app to access your device's location to move forward.");
                            } else {
                              return Text(state.locationError.toString());
                            }
                          }
                          else if (state is StateLoaded) {
                            return GridView.builder(
                              physics: ScrollPhysics(),
                              itemCount: state.nowList.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 40,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    String moviename =
                                        state.nowList[index].film_name;
                                    String movieImage =
                                        state.nowList[index].film_image;
                                    String movieSynopsis =
                                        state.nowList[index].synopsis_long;
                                    int movieId = state.nowList[index].film_id;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => DetailMovie(
                                            moviename: moviename,
                                            movieImage: movieImage,
                                            movieId: movieId,
                                            movieSynopsis: movieSynopsis),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 4,
                                    margin: const EdgeInsets.fromLTRB(
                                        0.0, 4.0, 4.0, 4.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    shadowColor: Colors.white,
                                    color: Colors.white70,
                                    child: Stack(children: <Widget>[
                                      Center(
                                        child: Image(
                                          image: NetworkImage(
                                              state.nowList[index].film_image),
                                        ),
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                                width: double.infinity,
                                                color: Colors.white,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8.0, 8.0, 8.0, 8.0),
                                                child: Text(
                                                    state.nowList[index]
                                                        .film_name,
                                                    maxLines: 5,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black))),
                                          ]),
                                    ]),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: Container(
                              height: 100,
                              width: 100,
                              child: const Padding(
                                  padding: EdgeInsets.only(right: 14.0),
                                  child: SpinKitThreeBounce(
                                      color: Color.fromRGBO(223, 24, 39, 0.9),
                                      size: 25.0)),
                            ));
                          }
                        }),
                ),
              ]));
        });
  }
}
