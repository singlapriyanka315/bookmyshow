class CinemaDetails {
  int cinema_id;
  double lat, lng, distance;
  String cinema_name, address, address2, city, state, phone, logo_url;
  CinemaDetails({
    required this.cinema_id,
    required this.cinema_name,
    required this.distance,
    required this.phone,
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
  factory CinemaDetails.fromJson(dynamic jsonData) {
    return CinemaDetails(
      cinema_id: jsonData['cinema_id'] ?? -1,
      phone: jsonData['phone'] ?? 0,
      distance: jsonData['distance'] ?? -1,
      cinema_name: jsonData['cinema_name'] ?? "",
      address: jsonData['address'] ?? "",
      address2: jsonData['address2'] ?? "",
      city: jsonData['city'] ?? "",
      state: jsonData['state'] ?? "",
      lat: jsonData['lat'] ?? -1,
      lng: jsonData['lng'] ?? -1,
      logo_url: jsonData['logo_url'] ?? "",
    );
  }

  //serilisation obj to map
  static List<CinemaDetails> toJson(List value) {
    return value.map((data) {
      return CinemaDetails.fromJson(data);
    }).toList();
  }
}
