class Cinemas {
  int cinema_id;
  double lat, lng;
  String cinema_name, address, address2, city, state, logo_url;
  //  address2,city, state, ;

  Cinemas({
    required this.cinema_id,
    required this.cinema_name,
    required this.address,
    required this.address2,
    required this.city,
    required this.state,
    required this.lat,
    required this.lng,
    required this.logo_url,
  });

// constructor taking map use to conver map to object
//deserilisation map to object
  factory Cinemas.fromJson(dynamic jsonData) {
    return Cinemas(
      cinema_id: jsonData['cinema_id'] ?? "",
      cinema_name: jsonData['cinema_name'] ?? "",
      address: jsonData['address'] ?? "",
      address2: jsonData['address2'] ?? "",
      city: jsonData['city'] ?? "",
      state: jsonData['state'] ?? "",
      lat: jsonData['lat'] ?? "",
      lng: jsonData['lng'] ?? "",
      logo_url: jsonData['logo_url'] ?? "",
    );
  }

  //serilisation obj to map
  static List<Cinemas> toJson(List value) {
    return value.map((data) {
      return Cinemas.fromJson(data);
    }).toList();
  }
}
