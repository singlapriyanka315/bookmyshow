// closestShowing/?film_id=123456
import 'package:bookmyapp/models/closest_showing.dart';
import 'package:bookmyapp/models/now_showing.dart';
import 'package:bookmyapp/models/showtimecinema.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List<ShowTime> result = [];
String? lat, long;

Future<List<ShowTime>> getshowtime(int filmId, int cinemaId) async {
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  lat = await currentPosition.latitude.toStringAsFixed(4);
  long = await currentPosition.longitude.toStringAsFixed(4);
  print(filmId);
  print(lat);
  print("i am long ");
  print(long);
  print(DateTime.now().toString());

  var uri = Uri.parse(
      "https://api-gate2.movieglu.com/cinemaShowTimes/?film_id=${filmId}&cinema_id=${cinemaId}&date=2022-11-02&sort=popularity");

  var response = await http.get(uri, headers: {
    // "client":	"TICK_3",
    // "x-api-key":	"TkQJadPADB8cFRtgWZWD42C70P8IjqkIu9UpfQc7",
    // "authorization":	"Basic VElDS18zOnZsYmhrYXBEeEx0ag==",
    // "territory":	"IN",
    // "api-version":	"v200",
    // "geolocation":	"${lat};${long}",
    // //"device-datetime":"${DateTime.now().toString()}",
    //  "device-datetime":"${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",

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
  print("i am in closest time");
  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);
    print("000000000");
    Map data = jsonDecode(response.body);
    List resshowtime = [];
    resshowtime.addAll(data['films']);

    result = ShowTime.toJson(resshowtime);
    print("i am cinema time yessss");
    //result = ShowTimeFromJson(ShowTimes);
    // print(result[0].showings.standard.times[0].startTime);
    return result;
  } else {
    return result;
  }
}
