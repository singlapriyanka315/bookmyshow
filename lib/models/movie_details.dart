class DetailMovie {
  int film_id, duration;
  int review;
  String film_name, directors;
  String releaseDates, synopsis_long;
  String film_image, genre_name; // producers;
  //List<dynamic> cast;

  DetailMovie({
    required this.film_id,
    required this.film_name,
    required this.releaseDates,
    required this.synopsis_long,
    required this.film_image,
    // required this.producers,
    required this.genre_name,
    required this.duration,
    required this.review,
    required this.directors,
    // required this.cast,
  });
  factory DetailMovie.fromJson(dynamic jsonData) {
    //print(jsonData['duration_mins'].runtimeType);
    print("i am in detail movie model");
    return DetailMovie(
      film_id: jsonData['film_id'] ?? -1,
      film_name: jsonData['film_name'].toString() ?? "",
      releaseDates:
          jsonData['release_dates'][0]['release_date'].toString() ?? "",
      film_image: jsonData['images']['poster']['1']['medium']['film_image']
              .toString() ??
          "",
      synopsis_long: jsonData['synopsis_long'].toString() ?? "No data found",
      genre_name: jsonData['genres'][0]['genre_name'] ?? "",
      directors: jsonData['directors'][0]['director_name'] ?? "",
      //producers: jsonData['producers'][0]['producer_name'] ?? "",
      // writers: jsonData['writers'][0]['writer_name'] ?? "",
      duration: jsonData['duration_mins'] ?? -1,
      review: jsonData['review_stars'] ?? -1,
      // review_txt: jsonData['review_txt'] ?? "No review yet",
      // cast: jsonData['cast'] ?? [],
    );
  }

  static List<DetailMovie> toJson(List value) {
    return value.map((data) {
      return DetailMovie.fromJson(data);
    }).toList();
  }
}
