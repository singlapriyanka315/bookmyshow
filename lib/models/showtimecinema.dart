// class ShowTime {
//   List<Films>? films;

//   ShowTime({this.films});

//   ShowTime.fromJson(Map<String, dynamic> json) {
//     if (json['films'] != null) {
//       films = <Films>[];
//       json['films'].forEach((v) {
//         films!.add(new Films.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.films != null) {
//       data['films'] = this.films!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class ShowTime {
  int? filmId;
  String? filmName;
  String? filmImage;
  Showings? showings;
  List<ShowDates>? showDates;

  ShowTime(
      {this.filmId,
      this.filmName,
      this.filmImage,
      this.showings,
      this.showDates});

  ShowTime.fromJson(Map<String, dynamic> json) {
    filmId = json['film_id'];
    filmName = json['film_name'];
    filmImage = json['film_image'];
    showings = json['showings'] != null
        ? new Showings.fromJson(json['showings'])
        : null;
    if (json['show_dates'] != null) {
      showDates = <ShowDates>[];
      json['show_dates'].forEach((v) {
        showDates!.add(new ShowDates.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['film_id'] = this.filmId;
  //   data['film_name'] = this.filmName;
  //   data['film_image'] = this.filmImage;
  //   if (this.showings != null) {
  //     data['showings'] = this.showings!.toJson();
  //   }
  //   if (this.showDates != null) {
  //     data['show_dates'] = this.showDates!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
  static List<ShowTime> toJson(List value) {
    List dummy = [];

    for (int i = 0; i < value.length; i++) {
      print(i);
      dummy.add(value[i]);
    }

    print("i am cinema model");
    return dummy.map((data) {
      return ShowTime.fromJson(data);
    }).toList();
  }
}

class Showings {
  Standard? standard;

  Showings({this.standard});

  Showings.fromJson(Map<String, dynamic> json) {
    standard = json['Standard'] != null
        ? new Standard.fromJson(json['Standard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.standard != null) {
      data['Standard'] = this.standard!.toJson();
    }
    return data;
  }
}

class Standard {
  int? filmId;
  String? filmName;
  List<Times>? times;

  Standard({this.filmId, this.filmName, this.times});

  Standard.fromJson(Map<String, dynamic> json) {
    filmId = json['film_id'];
    filmName = json['film_name'];
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(new Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['film_id'] = this.filmId;
    data['film_name'] = this.filmName;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  String? startTime;
  String? endTime;

  Times({this.startTime, this.endTime});

  Times.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

class ShowDates {
  String? date;

  ShowDates({this.date});

  ShowDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    return data;
  }
}
