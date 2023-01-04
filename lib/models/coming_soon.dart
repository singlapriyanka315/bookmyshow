class ComingSoon {
  int film_id;
  String film_name;
  String releaseDates, synopsis_long;
  String film_image;

  ComingSoon({
    required this.film_id,
    required this.film_name,
    required this.releaseDates,
    required this.synopsis_long,
    required this.film_image,
  });

// constructor taking map use to conver map to object
//deserilisation map to object
  factory ComingSoon.fromJson(dynamic jsonData) {
    return ComingSoon(
      film_id: jsonData['film_id'] ?? -1,
      film_name: jsonData['film_name'] ?? "",
      releaseDates: jsonData['release_dates'][0]['release_date'] ?? "",
      film_image:
          jsonData['images']['poster']['1']['medium']['film_image'] ?? "",
      synopsis_long: jsonData['synopsis_long'] ?? "",
    );
  }

//     static List<ComingSoon> toJson(List value){
//     return value.map((data){
//       return ComingSoon.fromJson(data);
//       }).toList() ;
// }

  //serilisation obj to map
  static List<ComingSoon> toJson(List value) {
    List dummy = [];
    // print("value");
    for (int i = 0; i < 1; i++) {
      print(value.length);
      dummy.add(value[i]);
    }

    //print("end loop");
    return dummy.map((data) {
      return ComingSoon.fromJson(data);
    }).toList();
  }
}
