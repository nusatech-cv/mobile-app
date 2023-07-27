import 'dart:convert';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  int? id;
  String? uid;
  int? userId;
  int? therapistId;
  int? serviceId;
  String? orderStatus;
  DateTime? appointmentStart;
  DateTime? appointmentEnd;
  DateTime? appointmentDate;
  int? appointmentDuration;
  double? totalPrice;
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
  Payment? payment;

  OrderDetail({
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
    this.payment,
  });

  OrderDetail copyWith({
    int? id,
    String? uid,
    int? userId,
    int? therapistId,
    int? serviceId,
    String? orderStatus,
    DateTime? appointmentStart,
    DateTime? appointmentEnd,
    DateTime? appointmentDate,
    int? appointmentDuration,
    double? totalPrice,
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
    Payment? payment,
  }) =>
      OrderDetail(
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
        payment: payment ?? this.payment,
      );

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        uid: json["uid"],
        userId: json["user_id"],
        therapistId: json["therapist_id"],
        serviceId: json["service_id"],
        orderStatus: json["order_status"],
        appointmentStart: json["appointment_start"] == null
            ? null
            : DateTime.parse(json["appointment_start"]),
        appointmentEnd: json["appointment_end"] == null
            ? null
            : DateTime.parse(json["appointment_end"]),
        appointmentDate: json["appointment_date"] == null
            ? null
            : DateTime.parse(json["appointment_date"]),
        appointmentDuration: json["appointment_duration"],
        totalPrice: json["total_price"] == null
            ? null
            : double.parse(json["total_price"]),
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
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "user_id": userId,
        "therapist_id": therapistId,
        "service_id": serviceId,
        "order_status": orderStatus,
        "appointment_start": appointmentStart,
        "appointment_end": appointmentEnd,
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
        "ratings": ratings,
        "payment": payment?.toJson(),
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

class Payment {
  String? paymentMethod;
  String? paymentStatus;
  String? amountPaid;
  String? toAccount;
  String? senderAccount;
  DateTime? paymentExpired;
  DateTime? paymentAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Payment({
    this.paymentMethod,
    this.paymentStatus,
    this.amountPaid,
    this.toAccount,
    this.senderAccount,
    this.paymentExpired,
    this.paymentAt,
    this.createdAt,
    this.updatedAt,
  });

  Payment copyWith({
    String? paymentMethod,
    String? paymentStatus,
    String? amountPaid,
    String? toAccount,
    String? senderAccount,
    DateTime? paymentExpired,
    DateTime? paymentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Payment(
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        amountPaid: amountPaid ?? this.amountPaid,
        toAccount: toAccount ?? this.toAccount,
        senderAccount: senderAccount ?? this.senderAccount,
        paymentExpired: paymentExpired ?? this.paymentExpired,
        paymentAt: paymentAt ?? this.paymentAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        amountPaid: json["amount_paid"],
        toAccount: json["to_account"],
        senderAccount: json["sender_account"],
        paymentExpired: json["payment_expired"] == null
            ? null
            : DateTime.parse(json["payment_expired"]),
        paymentAt: json["payment_at"] == null
            ? null
            : DateTime.parse(json["payment_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "amount_paid": amountPaid,
        "to_account": toAccount,
        "sender_account": senderAccount,
        "payment_expired": paymentExpired?.toIso8601String(),
        "payment_at": paymentAt?.toIso8601String(),
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
