import 'dart:convert';

TherapistDetail therapistDetailFromJson(String str) =>
    TherapistDetail.fromJson(json.decode(str));

String therapistDetailToJson(TherapistDetail data) =>
    json.encode(data.toJson());

class TherapistDetail {
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
  String? averageRating;
  bool? isAvailable;
  int? clientTotal;
  int? reviewTotal;
  String? firstName;
  String? lastName;
  int? age;
  double? distance;
  List<ServiceTherapis>? services;
  List<Rating>? ratings;
  DateTime? createdAt;
  DateTime? updatedAt;

  TherapistDetail({
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
    this.averageRating,
    this.isAvailable,
    this.clientTotal,
    this.reviewTotal,
    this.firstName,
    this.lastName,
    this.age,
    this.distance,
    this.services,
    this.ratings,
    this.createdAt,
    this.updatedAt,
  });

  TherapistDetail copyWith({
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
    String? averageRating,
    bool? isAvailable,
    int? clientTotal,
    int? reviewTotal,
    String? firstName,
    String? lastName,
    int? age,
    double? distance,
    List<ServiceTherapis>? services,
    List<Rating>? ratings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TherapistDetail(
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
        averageRating: averageRating ?? this.averageRating,
        isAvailable: isAvailable ?? this.isAvailable,
        clientTotal: clientTotal ?? this.clientTotal,
        reviewTotal: reviewTotal ?? this.reviewTotal,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
        distance: distance ?? this.distance,
        services: services ?? this.services,
        ratings: ratings ?? this.ratings,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TherapistDetail.fromJson(Map<String, dynamic> json) =>
      TherapistDetail(
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
        averageRating: json["average_rating"],
        isAvailable: json["is_available"],
        clientTotal: json["client_total"],
        reviewTotal: json["review_total"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        age: json["age"],
        distance: json["distance"]?.toDouble(),
        services: json["services"] == null
            ? []
            : List<ServiceTherapis>.from(
                json["services"]!.map((x) => ServiceTherapis.fromJson(x))),
        ratings: json["ratings"] == null
            ? []
            : List<Rating>.from(
                json["ratings"]!.map((x) => Rating.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "average_rating": averageRating,
        "is_available": isAvailable,
        "client_total": clientTotal,
        "review_total": reviewTotal,
        "first_name": firstName,
        "last_name": lastName,
        "age": age,
        "distance": distance,
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "ratings": ratings == null
            ? []
            : List<dynamic>.from(ratings!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Location {
  double? x;
  double? y;

  Location({
    this.x,
    this.y,
  });

  Location copyWith({
    double? x,
    double? y,
  }) =>
      Location(
        x: x ?? this.x,
        y: y ?? this.y,
      );

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

  Photo copyWith({
    String? url,
  }) =>
      Photo(
        url: url ?? this.url,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Rating {
  int? orderId;
  int? rating;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userAvatar;
  String? userFirstName;
  String? userLastName;

  Rating({
    this.orderId,
    this.rating,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.userAvatar,
    this.userFirstName,
    this.userLastName,
  });

  Rating copyWith({
    int? orderId,
    int? rating,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userAvatar,
    String? userFirstName,
    String? userLastName,
  }) =>
      Rating(
        orderId: orderId ?? this.orderId,
        rating: rating ?? this.rating,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userAvatar: userAvatar ?? this.userAvatar,
        userFirstName: userFirstName ?? this.userFirstName,
        userLastName: userLastName ?? this.userLastName,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        orderId: json["order_id"],
        rating: json["rating"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userAvatar: json["user_avatar"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "rating": rating,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_avatar": userAvatar,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
      };
}

class ServiceTherapis {
  int? serviceId;
  String? name;
  String? description;
  String? pricePerHour;
  Photo? image;
  int? minimumDuration;

  ServiceTherapis({
    this.serviceId,
    this.name,
    this.description,
    this.pricePerHour,
    this.image,
    this.minimumDuration,
  });

  ServiceTherapis copyWith({
    int? serviceId,
    String? name,
    String? description,
    String? pricePerHour,
    Photo? image,
    int? minimumDuration,
  }) =>
      ServiceTherapis(
        serviceId: serviceId ?? this.serviceId,
        name: name ?? this.name,
        description: description ?? this.description,
        pricePerHour: pricePerHour ?? this.pricePerHour,
        image: image ?? this.image,
        minimumDuration: minimumDuration ?? this.minimumDuration,
      );

  factory ServiceTherapis.fromJson(Map<String, dynamic> json) =>
      ServiceTherapis(
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
