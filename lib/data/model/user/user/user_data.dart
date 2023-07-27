import 'dart:convert';

UserData userDataFromJson(String str) =>
    UserData.fromJson(json.decode(str)['data']);

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String? firstName;
  String? lastName;
  String? email;
  String? googleId;
  String? avatar;
  String? role;
  String? tokenDevice;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? age;
  double? balance;
  double? averageRating;
  Therapist? therapist;
  List<Service>? services;
  List<dynamic>? rating;

  UserData({
    this.firstName,
    this.lastName,
    this.email,
    this.googleId,
    this.avatar,
    this.role,
    this.tokenDevice,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.age,
    this.balance,
    this.averageRating,
    this.therapist,
    this.services,
    this.rating,
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? googleId,
    String? avatar,
    String? role,
    String? tokenDevice,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? age,
    double? balance,
    double? averageRating,
    Therapist? therapist,
    List<Service>? services,
    List<dynamic>? rating,
  }) =>
      UserData(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        googleId: googleId ?? this.googleId,
        avatar: avatar ?? this.avatar,
        role: role ?? this.role,
        tokenDevice: tokenDevice ?? this.tokenDevice,
        address: address ?? this.address,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        age: age ?? this.age,
        balance: balance ?? this.balance,
        averageRating: averageRating ?? this.averageRating,
        therapist: therapist ?? this.therapist,
        services: services ?? this.services,
        rating: rating ?? this.rating,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        googleId: json["google_id"],
        avatar: json["avatar"],
        role: json["role"],
        tokenDevice: json["token_device"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        age: json["age"],
        balance: json["balance"] == null ? null : double.parse(json["balance"]),
        averageRating: json["average_rating"] == null
            ? null
            : double.parse(json["average_rating"]),
        therapist: json["therapist"] == null
            ? null
            : Therapist.fromJson(json["therapist"]),
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"]!.map((x) => Service.fromJson(x))),
        rating: json["rating"] == null
            ? []
            : List<dynamic>.from(json["rating"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "google_id": googleId,
        "avatar": avatar,
        "role": role,
        "token_device": tokenDevice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "age": age,
        "balance": balance,
        "average_rating": averageRating,
        "therapist": therapist?.toJson(),
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "rating":
            rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
      };
}

class Service {
  int? serviceId;
  String? name;
  String? description;
  String? pricePerHour;
  Photo? image;
  int? minimumDuration;

  Service({
    this.serviceId,
    this.name,
    this.description,
    this.pricePerHour,
    this.image,
    this.minimumDuration,
  });

  Service copyWith({
    int? serviceId,
    String? name,
    String? description,
    String? pricePerHour,
    Photo? image,
    int? minimumDuration,
  }) =>
      Service(
        serviceId: serviceId ?? this.serviceId,
        name: name ?? this.name,
        description: description ?? this.description,
        pricePerHour: pricePerHour ?? this.pricePerHour,
        image: image ?? this.image,
        minimumDuration: minimumDuration ?? this.minimumDuration,
      );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
        x: json["x"],
        y: json["y"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
