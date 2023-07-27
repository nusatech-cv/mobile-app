import 'dart:convert';

List<Therapist> therapistFromJson(String str) =>
    List<Therapist>.from(json.decode(str).map((x) => Therapist.fromJson(x)));

String therapistToJson(List<Therapist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Therapist {
  int? id;
  int? userId;
  Location? location;
  Photo? photo;
  int? startDay;
  int? endDay;
  String? startTime;
  String? endTime;
  int? experienceYears;
  DateTime? birthdate;
  String? gender;
  bool? isAvailable;
  String? firstName;
  String? lastName;
  String? readableLocation;
  int? age;
  double? distance;
  List<ServiceTerapist>? services;
  List<dynamic>? ratings;
  double? averageRating;

  Therapist({
    this.id,
    this.userId,
    this.location,
    this.photo,
    this.startDay,
    this.endDay,
    this.startTime,
    this.endTime,
    this.experienceYears,
    this.birthdate,
    this.gender,
    this.isAvailable,
    this.firstName,
    this.lastName,
    this.readableLocation,
    this.age,
    this.distance,
    this.services,
    this.ratings,
    this.averageRating,
  });

  Therapist copyWith({
    int? id,
    int? userId,
    Location? location,
    Photo? photo,
    int? startDay,
    int? endDay,
    String? startTime,
    String? endTime,
    int? experienceYears,
    DateTime? birthdate,
    String? gender,
    bool? isAvailable,
    String? firstName,
    String? lastName,
    String? readableLocation,
    int? age,
    double? distance,
    List<ServiceTerapist>? services,
    List<dynamic>? ratings,
  }) =>
      Therapist(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        location: location ?? this.location,
        photo: photo ?? this.photo,
        startDay: startDay ?? this.startDay,
        endDay: endDay ?? this.endDay,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        experienceYears: experienceYears ?? this.experienceYears,
        birthdate: birthdate ?? this.birthdate,
        gender: gender ?? this.gender,
        isAvailable: isAvailable ?? this.isAvailable,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        readableLocation: readableLocation ?? this.readableLocation,
        age: age ?? this.age,
        distance: distance ?? this.distance,
        services: services ?? this.services,
        ratings: ratings ?? this.ratings,
      );

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
        id: json["id"],
        userId: json["user_id"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
        startDay: json["start_day"],
        endDay: json["end_day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        experienceYears: json["experience_years"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        gender: json["gender"],
        isAvailable: json["is_available"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        age: json["age"],
        distance: json["distance"]?.toDouble(),
        services: json["services"] == null
            ? []
            : List<ServiceTerapist>.from(
                json["services"]!.map((x) => ServiceTerapist.fromJson(x))),
        ratings: json["ratings"] == null
            ? []
            : List<dynamic>.from(json["ratings"]!.map((x) => x)),
        averageRating: json['average_rating'] == null ? null : double.parse(json['average_rating'].toString()),
        
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "location": location?.toJson(),
        "photo": photo?.toJson(),
        "start_day": startDay,
        "end_day": endDay,
        "start_time": startTime,
        "end_time": endTime,
        "experience_years": experienceYears,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "is_available": isAvailable,
        "first_name": firstName,
        "last_name": lastName,
        "age": age,
        "distance": distance,
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "ratings":
            ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x)),
      };
}

class Location {
  double? x;
  double? y;

  Location({
    this.x,
    this.y,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}

class Photo {
  String? url;

  Photo({
    this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class ServiceTerapist {
  int? serviceId;
  String? name;
  String? description;
  String? pricePerHour;
  Photo? image;
  int? minimumDuration;

  ServiceTerapist({
    this.serviceId,
    this.name,
    this.description,
    this.pricePerHour,
    this.image,
    this.minimumDuration,
  });

  factory ServiceTerapist.fromJson(Map<String, dynamic> json) =>
      ServiceTerapist(
        serviceId: json["service_id"],
        name: json["name"],
        description: json["description"],
        pricePerHour: json["price_per_hour"],
        image: json["image"] == null ? null : Photo.fromJson(json["image"]),
        minimumDuration: json["minimum_duration"],
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "name": name,
        "description": description,
        "price_per_hour": pricePerHour,
        "image": image?.toJson(),
        "minimum_duration": minimumDuration,
      };
}
