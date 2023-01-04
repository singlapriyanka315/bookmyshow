import 'package:bookmyapp/models/live_movies.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

List<LiveFilm> result = [];
var result2;
late int filmid;
List<LiveFilm> liveList = [];
String? lat, long;

Future<List<LiveFilm>> getLive(String search) async {
  print(search);

  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  lat = await currentPosition.latitude.toStringAsFixed(4);
  long = await currentPosition.longitude.toStringAsFixed(4);
  var uri = Uri.parse(
      "https://api-gate2.movieglu.com/filmLiveSearch/?query=${search}");
  print(search);

  var response = await http.get(uri, headers: {
    //  "client":	"TICK_3",
    //     "x-api-key":	"TkQJadPADB8cFRtgWZWD42C70P8IjqkIu9UpfQc7",
    //     "authorization":	"Basic VElDS18zOnZsYmhrYXBEeEx0ag==",
    //     "territory":	"IN",
    //     "api-version":	"v200",
    //     "geolocation":	"${lat};${long}",
    //     //"device-datetime":"${DateTime.now().toString()}",
    //      "device-datetime":"${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",

    "client": "SOFT_17",
    "x-api-key": "	MDBAHh2Odq8LCnZgvUTGb7KRBhfEpJUN8SHN8TFM",
    "authorization": "	Basic U09GVF8yMV9YWDpWRXhVUFdmeTZNM0E=",
    "territory": "XX",
    "api-version": "v200",
    "geolocation": "-22.0;14.0",
    //"geolocation": "30.333;76.3586",
    // "geolocation":	"${lat};${long}",
    "device-datetime":
        "${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",
  });
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);
    Map data = jsonDecode(response.body);
    List livefilms = [];
    livefilms.addAll(data['films']);
    result = LiveFilm.toJson(livefilms);
    print("final data");
    liveList = result;

    ///filmid = liveList[0].film_id;
    print("i am list of search movies");
    // result2 = getDetail(filmid);
    print(liveList.length);

    return liveList;
  } else {
    return liveList;
  }
}
