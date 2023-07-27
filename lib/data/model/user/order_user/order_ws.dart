import 'dart:convert';

OrderWs orderWsFromJson(String str) =>
    OrderWs.fromJson(json.decode(str)['global.orders']['record']);

String orderWsToJson(OrderWs data) => json.encode(data.toJson());

class OrderWs {
  DateTime? appointmentDate;
  int? appointmentDuration;
  DateTime? createdAt;
  int? id;
  Locoation? locoation;
  String? note;
  String? orderStatus;
  int? serviceId;
  TherapistData? therapist;
  String? totalPrice;
  String? uid;
  DateTime? updatedAt;
  TherapistData? user;

  OrderWs({
    this.appointmentDate,
    this.appointmentDuration,
    this.createdAt,
    this.id,
    this.locoation,
    this.note,
    this.orderStatus,
    this.serviceId,
    this.therapist,
    this.totalPrice,
    this.uid,
    this.updatedAt,
    this.user,
  });

  factory OrderWs.fromJson(Map<String, dynamic> json) => OrderWs(
        appointmentDate: json["appointment_date"] == null
            ? null
            : DateTime.parse(
                json["appointment_date"].toString().replaceAll(" UTC", '')),
        appointmentDuration: json["appointment_duration"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(
                json["created_at"].toString().replaceAll(" UTC", '')),
        id: json["id"],
        locoation: json["locoation"] == null
            ? null
            : Locoation.fromJson(json["locoation"]),
        note: json["note"],
        orderStatus: json["order_status"],
        serviceId: json["service_id"],
        therapist: json["therapist"] == null
            ? null
            : TherapistData.fromJson(json["therapist"]),
        totalPrice: json["total_price"],
        uid: json["uid"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(
                json["updated_at"].toString().replaceAll(" UTC", '')),
        user:
            json["user"] == null ? null : TherapistData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "appointment_date": appointmentDate,
        "appointment_duration": appointmentDuration,
        "created_at": createdAt,
        "id": id,
        "locoation": locoation?.toJson(),
        "note": note,
        "order_status": orderStatus,
        "service_id": serviceId,
        "therapist": therapist?.toJson(),
        "total_price": totalPrice,
        "uid": uid,
        "updated_at": updatedAt,
        "user": user?.toJson(),
      };
}

class Locoation {
  double? x;
  double? y;

  Locoation({
    this.x,
    this.y,
  });

  factory Locoation.fromJson(Map<String, dynamic> json) => Locoation(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}

class TherapistData {
  String? email;
  String? role;
  String? uid;

  TherapistData({
    this.email,
    this.role,
    this.uid,
  });

  factory TherapistData.fromJson(Map<String, dynamic> json) => TherapistData(
        email: json["email"],
        role: json["role"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "role": role,
        "uid": uid,
      };
}
