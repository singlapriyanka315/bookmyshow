import 'package:bookmyapp/models/coming_soon.dart';
import 'package:bookmyapp/models/movie_details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

List<DetailMovie> resdata = [];
var moviedata;
String? lat, long;

Future<DetailMovie> getDetail(int id) async {
  print("id");
  print(id);

  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  lat = await currentPosition.latitude.toStringAsFixed(4);
  long = await currentPosition.longitude.toStringAsFixed(4);
  var uri =
      Uri.parse("https://api-gate2.movieglu.com/filmDetails/?film_id=${id}");
  // print(search);

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
    "geolocation": "-22.0;14.0",
    //"geolocation": "30.333;76.3586",
    //"geolocation":	"${lat};${long}",
    "device-datetime":
        "${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",
  });
  print(response);

  print(response.statusCode);
  //print(response.body);

  if (response.statusCode == 200) {
    print("response.body");
    var data = jsonDecode(response.body);
    moviedata = DetailMovie(
      directors: data['directors'][0]['director_name'] ?? "",
      duration: data['duration_mins'] ?? 0,
      film_id: data["film_id"] ?? -1,
      film_image: data['images']['poster']['1']['medium']['film_image'] ?? "",
      film_name: data["film_name"] ?? "",
      releaseDates: data['release_dates'][0]['release_date'] ?? "",
      genre_name: data['genres'][0]['genre_name'] ?? "",
      review: data['review_stars'] ?? 0,
      synopsis_long: data['synopsis_long'] ?? "",
    );
    print("i am in detail api");
    return moviedata;
  } else {
    print("i am in detail error api");
    return moviedata;
  }
}
