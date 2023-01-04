import 'package:bookmyapp/models/coming_soon.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

List<ComingSoon> resdata = [];
String? lat, long;

Future<List<ComingSoon>> getSoon() async {
  Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  lat = await currentPosition.latitude.toStringAsFixed(4);
  long = await currentPosition.longitude.toStringAsFixed(4);
  var uri = Uri.parse("https://api-gate2.movieglu.com/filmsComingSoon/?n=5");
  // print(search);

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
    //"geolocation": "30.333;76.3586",
    "geolocation": "-22.0;14.0",
    //"geolocation":	"${lat};${long}",
    "device-datetime":
        "${DateFormat("yyyy-MM-ddTHH:mm:ss.sss").format(DateTime.now())}",
  });
  print("coming soon");
  print(response.body);

  if (response.statusCode == 200) {
    //  print("response.statuscode of coming soonnnn");
    // //  print(response.statusCode);
    //  print("response.body of coming soon");
    //  print(response.body);
    print("i am in soon movie 200");
    Map data = jsonDecode(response.body);
    List soonfilms = [];
    soonfilms.addAll(data['films']);
    print(soonfilms.length);
    print(soonfilms);

    resdata = ComingSoon.toJson(soonfilms);
    print(resdata.length);
    //  print(resdata.length);
    print("final data.........");
    print(resdata);
    return resdata;
  } else {
    return resdata;
  }
}
