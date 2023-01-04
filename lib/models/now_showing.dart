class FilmsNow {
  int film_id;
  String film_name;
  String releaseDates, synopsis_long;
  String film_image;

  FilmsNow({
    required this.film_id,
    required this.film_name,
    required this.releaseDates,
    required this.synopsis_long,
    required this.film_image,
  });

// constructor taking map use to conver map to object
//deserilisation map to object
  factory FilmsNow.fromJson(dynamic jsonData) {
    // print("1");
    // print(jsonData['film_id'].runtimeType); //int
    // print("2");
    // print(jsonData['film_name'].runtimeType);//string
    // print("3");
    // print(jsonData['release_dates'][0]['release_date'].runtimeType);
    // print("4");
    // print(jsonData['images']['poster']['1']['medium']['film_image'].runtimeType);//string
    // print("5");
    // print(jsonData['synopsis_long'].runtimeType);
    // print("end");
    return FilmsNow(
      film_id: jsonData['film_id'] ?? -1,
      film_name: jsonData['film_name'].toString() ?? "",
      releaseDates:
          jsonData['release_dates'][0]['release_date'].toString() ?? "",
      film_image: jsonData['images']['poster']['1']['medium']['film_image']
              .toString() ??
          "",
      synopsis_long: jsonData['synopsis_long'].toString() ?? "",
    );
  }

//     static List<ComingSoon> toJson(List value){
//     return value.map((data){
//       return ComingSoon.fromJson(data);
//       }).toList() ;
// }

  //serilisation obj to map
  static List<FilmsNow> toJson(List value) {
    List dummy = [];

    print("value");
    //print(value[8]);

    for (int i = 0; i < value.length; i++) {
      print("for loop");
      if (i == 7) {
        continue;
      }
      if (value[i]['film_id'] != null &&
          value[i]['film_id'].runtimeType == int &&
          value[i]['film_name'].runtimeType == String &&
          value[i]['film_name'] != null &&
          value[i]['release_dates'][0]['release_date'] != null &&
          value[i]['release_dates'][0]['release_date'].runtimeType == String &&
          value[i]['images']['poster']['1']['medium']['film_image'] != null &&
          value[i]['images']['poster']['1']['medium']['film_image']
                  .runtimeType ==
              String &&
          value[i]['synopsis_long'] != null &&
          value[i]['synopsis_long'].runtimeType == String) {
        print(i);
        dummy.add(value[i]);
      }
    }

    print("end loop");
    return dummy.map((data) {
      return FilmsNow.fromJson(data);
    }).toList();
  }
}
