import 'package:bookmyapp/models/cinema_details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

List<CinemaDetails> resdata = [];
var cinemadata;
String? lat, long;

Future<CinemaDetails> getCinemaDetail(int id) async {
  print("id");
  print("i am lat");
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  lat = await currentPosition.latitude.toStringAsFixed(4);
  long = await currentPosition.longitude.toStringAsFixed(4);
  //try{
  var uri = Uri.parse(
      "https://api-gate2.movieglu.com/cinemaDetails/?cinema_id=${id}");

  var response = await http.get(uri, headers: {
    //  "client":	"TICK_3",
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
    //"geolocation":	"${lat};${long}",
    "device-datetime":
        "${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",
  });
  print(response.statusCode);
  // print(response.body);

  if (response.statusCode == 200) {
    print(response.body);
    var data = jsonDecode(response.body);
    cinemadata = CinemaDetails(
        cinema_id: data['cinema_id'],
        cinema_name: data['cinema_name'],
        phone: data['phone'],
        distance: data["distance"],
        lat: data['lat'],
        lng: data["lng"],
        address: data['address'],
        address2: data['address2'],
        state: data['state'],
        city: data['city'],
        logo_url: data['logo_url']);
    print("i am in cinema detail api");
    return cinemadata;
  } else {
    return cinemadata;
  }

  //}
  // catch(err){
  //   print("err");
  //   print(err);
  //    print(cinemadata);
  //   return cinemadata;
  // }
}
