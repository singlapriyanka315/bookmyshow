class LiveFilm {
  int film_id;
  String film_name;
  String releaseDates, synopsis_long;
  String film_image;

  LiveFilm({
    required this.film_id,
    required this.film_name,
    required this.releaseDates,
    required this.synopsis_long,
    required this.film_image,
  });

  factory LiveFilm.fromJson(dynamic jsonData) {
    return LiveFilm(
      film_id: jsonData['film_id'] ?? -1,
      film_name: jsonData['film_name'] ?? "",
      releaseDates: jsonData['release_dates'][0]['release_date'] ?? "",
      film_image:
          jsonData['images']['poster']['1']['medium']['film_image'] ?? "",
      synopsis_long: jsonData['synopsis_long'].toString() ?? "",
    );
  }

  //   //serilisation obj to map
  static List<LiveFilm> toJson(List value) {
    return value.map((data) {
      return LiveFilm.fromJson(data);
    }).toList();
  }

//     static List<ComingSoon> toJson(List value){
//     return value.map((data){
//       return ComingSoon.fromJson(data);
//       }).toList() ;
// }

  //serilisation obj to map

}
// class LiveFilm {
//   int film_id;
//   String film_name;
//   String releaseDates, synopsis_long;
//   String film_image;

//   LiveFilm({
//     required this.film_id,
//     required this.film_name,
//     required this.releaseDates,
//     required this.synopsis_long,
//      required this.film_image,
//   });

// // constructor taking map use to conver map to object
// //deserilisation map to object


//   factory LiveFilm.fromJson(dynamic jsonData) {
//     print(jsonData['film_id'].runtimeType);
//     // print(jsonData['film_name'].runtimeType);
//     // print(jsonData['release_dates'][0]['release_date'] .runtimeType);
//     // print(jsonData['images']['poster']['1']['medium']['film_image'].runtimeType);
//     return LiveFilm(
//       film_id: jsonData['film_id'] ?? -1,
//       film_name: jsonData['film_name'] ?? "",
//       releaseDates:jsonData['release_dates'][0]['release_date'] ?? "",
//       film_image: jsonData['images']['poster']['1']['medium']['film_image'] ?? "",
//       synopsis_long: jsonData['synopsis_long'] ?? "No data found",
//     );
//   }
//   //serilisation obj to map
//   static List<LiveFilm> toJson(List value){
//     return value.map((data){
//       return LiveFilm.fromJson(data);
//       }).toList() ;
// }
// }