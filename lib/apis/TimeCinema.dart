// closestShowing/?film_id=123456
import 'package:bookmyapp/models/closest_showing.dart';
import 'package:bookmyapp/models/now_showing.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/cinematime.dart';

List<NearCinema> result = [];
String? lat, long;

Future<List<NearCinema>> getNearCinema(int id) async {
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  lat = await currentPosition.latitude.toStringAsFixed(4);
  long = await currentPosition.longitude.toStringAsFixed(4);
  print(id);
  print(lat);
  print("i am long ");
  print(long);
  print(DateTime.now().toString());

  var uri =
      Uri.parse("https://api-gate2.movieglu.com/closestShowing/?film_id=${id}");

  var response = await http.get(uri, headers: {
    // "client":	"TICK_3",
    //   "x-api-key":	"TkQJadPADB8cFRtgWZWD42C70P8IjqkIu9UpfQc7",
    //   "authorization":	"Basic VElDS18zOnZsYmhrYXBEeEx0ag==",
    //   "territory":	"IN",
    //   "api-version":	"v200",
    //   "geolocation":	"${lat};${long}",
    //   //"device-datetime":"${DateTime.now().toString()}",
    //    "device-datetime":"${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",

    "client": "SOFT_17",
    "x-api-key": "	MDBAHh2Odq8LCnZgvUTGb7KRBhfEpJUN8SHN8TFM",
    "authorization": "	Basic U09GVF8yMV9YWDpWRXhVUFdmeTZNM0E=",
    "territory": "XX",
    "api-version": "v200",
    //"geolocation": "30.333;76.3586",
    "geolocation": "-22.0;14.0",
    // "geolocation":	"${lat};${long}",
    "device-datetime":
        "${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",
  });
  print("i am in Nearcinema");
  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);

    Map data = jsonDecode(response.body);
    List closestcinemas = [];
    closestcinemas.addAll(data['cinemas']);

    result = NearCinema.toJson(closestcinemas);
    print("final data");
    //result = closestCinemaFromJson(closestcinemas);
    // print(result[0].showings.standard.times[0].startTime);
    return result;
  } else {
    return result;
  }
}
