import 'dart:convert';

List<HistoryPaymentTherapist> historyPaymentTherapistFromJson(String str) =>
    List<HistoryPaymentTherapist>.from(
        json.decode(str).map((x) => HistoryPaymentTherapist.fromJson(x)));

String historyPaymentTherapistToJson(List<HistoryPaymentTherapist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryPaymentTherapist {
  String? paymentMethod;
  String? paymentStatus;
  double? amountPaid;
  String? toAccount;
  String? senderAccount;
  DateTime? paymentExpired;
  DateTime? paymentAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? orderId;
  int? userId;
  String? serviceName;
  int? appointmentDuration;
  String? userFirstName;
  String? userLastName;

  HistoryPaymentTherapist({
    this.paymentMethod,
    this.paymentStatus,
    this.amountPaid,
    this.toAccount,
    this.senderAccount,
    this.paymentExpired,
    this.paymentAt,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.userId,
    this.serviceName,
    this.appointmentDuration,
    this.userFirstName,
    this.userLastName,
  });

  factory HistoryPaymentTherapist.fromJson(Map<String, dynamic> json) =>
      HistoryPaymentTherapist(
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        amountPaid: json["amount_paid"] == null
            ? null
            : double.parse(json["amount_paid"]),
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
        orderId: json["order_id"],
        userId: json["user_id"],
        serviceName: json["service_name"],
        appointmentDuration: json["appointment_duration"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "amount_paid": amountPaid,
        "to_account": toAccount,
        "sender_account": senderAccount,
        "payment_expired": paymentExpired?.toIso8601String(),
        "payment_at": paymentAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order_id": orderId,
        "user_id": userId,
        "service_name": serviceName,
        "appointment_duration": appointmentDuration,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
      };
}
