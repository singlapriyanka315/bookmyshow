// class ClosestCinema {
//   int cinema_id;
//   String times;
//   double  distance;
//   String cinema_name, logo_url;
//   //String address, address2, city;

//   ClosestCinema(
//       {
//        requiredrequiredrequired this.cinema_id,
//        requiredrequiredrequired this.cinema_name,
//        //requiredrequiredrequired this.address,
//        //requiredrequiredrequired this.address2,
//        requiredrequiredrequired this.distance,
//        requiredrequiredrequired this.logo_url,
//        requiredrequiredrequired this.times,
//        //requiredrequired this.city,

//      });

// // constructor taking map use to conver map to object
// //deserilisation map to object
//   factory ClosestCinema.fromJson(dynamic jsonData) {

//     return ClosestCinema(
//       cinema_id: jsonData['cinema_id'] ?? -1,
//       cinema_name: jsonData['cinema_name'].toString() ?? "",
//       // address: jsonData['address'].toString() ?? "" ,
//       // address2: jsonData['address2'].toString() ?? "" ,
//        distance: jsonData['distance'] ?? -1 ,
//        logo_url: jsonData['logo_url'].toString() ?? "",
//        //city: jsonData['city'].toString() ?? "",
//        times: jsonData['showings']['Standard']['times'] ?? "",
//     );
//   }

// //     static List<ComingSoon> toJson(List value){
// //     return value.map((data){
// //       return ComingSoon.fromJson(data);
// //       }).toList() ;
// // }

//   //serilisation obj to map
//   static List<ClosestCinema> toJson(List value){
//     List dummy=[];

//     for(int i=0;i<value.length;i++){

//       // if(value[i]['cinema_id']!=null && value[i]['cinema_id'].runtimeType == int && value[i]['cinema_name'].runtimeType== String && value[i]['cinema_name']!=null &&  value[i]['address2']!=null && value[i]['address2'].runtimeType == String)
//       // {
//         print(i);
//         dummy.add(value[i]);
//       //}

// }

//  print("i am cinema model");
// return dummy.map((data){

//       return ClosestCinema.fromJson(data);
//       }).toList() ;
// }
// }

// To parserequiredrequired this JSON data, do
//
//     final closestCinema = closestCinemaFromJson(jsonString);

// To parserequired this JSON data, do
//
//     final closestCinema = closestCinemaFromJson(jsonString);

import 'dart:convert';

class ClosestCinema {
  ClosestCinema({
    required this.cinemaId,
    required this.cinemaName,
    required this.distance,
    required this.logoUrl,
    required this.showings,
  });

  int cinemaId;
  String cinemaName;
  double distance;
  String logoUrl;
  Showings showings;

  factory ClosestCinema.fromJson(Map<String, dynamic> json) => ClosestCinema(
        cinemaId: json["cinema_id"],
        cinemaName: json["cinema_name"],
        distance: json["distance"].toDouble(),
        logoUrl: json["logo_url"],
        showings: Showings.fromJson(json["showings"]),
      );

  static List<ClosestCinema> toJson(List value) {
    List dummy = [];

    for (int i = 0; i < value.length; i++) {
      // print(i);
      dummy.add(value[i]);
    }

    // print("i am cinema model");
    return dummy.map((data) {
      return ClosestCinema.fromJson(data);
    }).toList();
  }
}

class Showings {
  Showings({
    required this.standard,
  });

  Standard standard;

  factory Showings.fromJson(Map<String, dynamic> json) => Showings(
        standard: Standard.fromJson(json["Standard"]),
      );

  Map<String, dynamic> toJson() => {
        "Standard": standard.toJson(),
      };
}

class Standard {
  Standard({
    required this.filmId,
    required this.filmName,
    required this.times,
  });

  int filmId;
  String filmName;
  List<Time> times;

  factory Standard.fromJson(Map<String, dynamic> json) => Standard(
        filmId: json["film_id"],
        filmName: json["film_name"],
        times: List<Time>.from(json["times"].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "film_id": filmId,
        "film_name": filmName,
        "times": List<dynamic>.from(times.map((x) => x.toJson())),
      };
}

class Time {
  Time({
    required this.startTime,
    required this.endTime,
  });

  String startTime;
  String endTime;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
      };
}
