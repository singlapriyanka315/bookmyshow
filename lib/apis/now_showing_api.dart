import 'package:bookmyapp/models/now_showing.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List<FilmsNow> result = [];
String? lat, long;

Future<List<FilmsNow>> getNow() async {
  Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  lat = await currentPosition.latitude.toStringAsFixed(4);
  long = await currentPosition.longitude.toStringAsFixed(4);
  var uri = Uri.parse("https://api-gate2.movieglu.com/filmsNowShowing/?n=25");
  // print(search);

  var response = await http.get(uri, headers: {
//  "client":	"TICK_3",
//       "x-api-key":	"TkQJadPADB8cFRtgWZWD42C70P8IjqkIu9UpfQc7",
//       "authorization":	"Basic VElDS18zOnZsYmhrYXBEeEx0ag==",
//       "territory":	"IN",
//       "api-version":	"v200",
//       "geolocation":	"${lat};${long}",
//       //"device-datetime":"${DateTime.now().toString()}",
//        "device-datetime":"${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",

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
  // print(response.body);

  if (response.statusCode == 200) {
    //  print("response.statuscode");
    //  print(response.statusCode);
    //  print("response.body");
    print(response.body);
    Map data = jsonDecode(response.body);
    List nowfilms = [];
    nowfilms.addAll(data['films']);
    // print(nowfilms.length);
    // print(nowfilms);
    result = FilmsNow.toJson(nowfilms);
    print("final data");
    print(result);
    return result;
  } else {
    return result;
  }
}
