import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int? id;
  String? uid;
  int? userId;
  int? therapistId;
  int? serviceId;
  String? orderStatus;
  dynamic appointmentStart;
  DateTime? appointmentEnd;
  DateTime? appointmentDate;
  int? appointmentDuration;
  String? totalPrice;
  Location? location;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userEmail;
  String? userLastName;
  String? userAvatar;
  String? therapistName;
  TherapistAvatar? therapistAvatar;
  double? distance;
  String? serviceName;
  String? serviceDescription;
  Ratings? ratings;

  Order({
    this.id,
    this.uid,
    this.userId,
    this.therapistId,
    this.serviceId,
    this.orderStatus,
    this.appointmentStart,
    this.appointmentEnd,
    this.appointmentDate,
    this.appointmentDuration,
    this.totalPrice,
    this.location,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.userEmail,
    this.userLastName,
    this.userAvatar,
    this.therapistName,
    this.therapistAvatar,
    this.distance,
    this.serviceName,
    this.serviceDescription,
    this.ratings,
  });

  Order copyWith({
    int? id,
    String? uid,
    int? userId,
    int? therapistId,
    int? serviceId,
    String? orderStatus,
    dynamic appointmentStart,
    DateTime? appointmentEnd,
    DateTime? appointmentDate,
    int? appointmentDuration,
    String? totalPrice,
    Location? location,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userEmail,
    String? userLastName,
    String? userAvatar,
    String? therapistName,
    TherapistAvatar? therapistAvatar,
    double? distance,
    String? serviceName,
    String? serviceDescription,
    Ratings? ratings,
  }) =>
      Order(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        userId: userId ?? this.userId,
        therapistId: therapistId ?? this.therapistId,
        serviceId: serviceId ?? this.serviceId,
        orderStatus: orderStatus ?? this.orderStatus,
        appointmentStart: appointmentStart ?? this.appointmentStart,
        appointmentEnd: appointmentEnd ?? this.appointmentEnd,
        appointmentDate: appointmentDate ?? this.appointmentDate,
        appointmentDuration: appointmentDuration ?? this.appointmentDuration,
        totalPrice: totalPrice ?? this.totalPrice,
        location: location ?? this.location,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userEmail: userEmail ?? this.userEmail,
        userLastName: userLastName ?? this.userLastName,
        userAvatar: userAvatar ?? this.userAvatar,
        therapistName: therapistName ?? this.therapistName,
        therapistAvatar: therapistAvatar ?? this.therapistAvatar,
        distance: distance ?? this.distance,
        serviceName: serviceName ?? this.serviceName,
        serviceDescription: serviceDescription ?? this.serviceDescription,
        ratings: ratings ?? this.ratings,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        uid: json["uid"],
        userId: json["user_id"],
        therapistId: json["therapist_id"],
        serviceId: json["service_id"],
        orderStatus: json["order_status"],
        appointmentStart: json["appointment_start"],
        appointmentEnd: json["appointment_end"] == null
            ? null
            : DateTime.parse(json["appointment_end"]),
        appointmentDate: json["appointment_date"] == null
            ? null
            : DateTime.parse(json["appointment_date"]),
        appointmentDuration: json["appointment_duration"],
        totalPrice: json["total_price"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userEmail: json["user_email"],
        userLastName: json["user_last_name"],
        userAvatar: json["user_avatar"],
        therapistName: json["therapist_name"],
        therapistAvatar: json["therapist_avatar"] == null
            ? null
            : TherapistAvatar.fromJson(json["therapist_avatar"]),
        distance: json["distance"]?.toDouble(),
        serviceName: json["service_name"],
        serviceDescription: json["service_description"],
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "user_id": userId,
        "therapist_id": therapistId,
        "service_id": serviceId,
        "order_status": orderStatus,
        "appointment_start": appointmentStart,
        "appointment_end": appointmentEnd?.toIso8601String(),
        "appointment_date": appointmentDate?.toIso8601String(),
        "appointment_duration": appointmentDuration,
        "total_price": totalPrice,
        "location": location?.toJson(),
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_email": userEmail,
        "user_last_name": userLastName,
        "user_avatar": userAvatar,
        "therapist_name": therapistName,
        "therapist_avatar": therapistAvatar?.toJson(),
        "distance": distance,
        "service_name": serviceName,
        "service_description": serviceDescription,
        "ratings": ratings?.toJson(),
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

class Ratings {
  int? userId;
  int? therapistId;
  int? orderId;
  int? rating;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ratings({
    this.userId,
    this.therapistId,
    this.orderId,
    this.rating,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  Ratings copyWith({
    int? userId,
    int? therapistId,
    int? orderId,
    int? rating,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Ratings(
        userId: userId ?? this.userId,
        therapistId: therapistId ?? this.therapistId,
        orderId: orderId ?? this.orderId,
        rating: rating ?? this.rating,
        note: note ?? this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        userId: json["user_id"],
        therapistId: json["therapist_id"],
        orderId: json["order_id"],
        rating: json["rating"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "therapist_id": therapistId,
        "order_id": orderId,
        "rating": rating,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class TherapistAvatar {
  String? url;

  TherapistAvatar({
    this.url,
  });

  TherapistAvatar copyWith({
    String? url,
  }) =>
      TherapistAvatar(
        url: url ?? this.url,
      );

  factory TherapistAvatar.fromJson(Map<String, dynamic> json) =>
      TherapistAvatar(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
