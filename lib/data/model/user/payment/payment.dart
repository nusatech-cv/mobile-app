// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) => List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
    int? orderId;
    int? userId;
    String? paymentMethod;
    String? paymentStatus;
    int? amountPaid;
    String? toAccount;
    String? senderAccount;
    DateTime? paymentExpired;
    DateTime? paymentAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? serviceName;
    int? appointmentDuration;
    String? userFirstName;
    String? userLastName;

    Payment({
        this.orderId,
        this.userId,
        this.paymentMethod,
        this.paymentStatus,
        this.amountPaid,
        this.toAccount,
        this.senderAccount,
        this.paymentExpired,
        this.paymentAt,
        this.createdAt,
        this.updatedAt,
        this.serviceName,
        this.appointmentDuration,
        this.userFirstName,
        this.userLastName,
    });

    Payment copyWith({
        int? orderId,
        int? userId,
        String? paymentMethod,
        String? paymentStatus,
        int? amountPaid,
        String? toAccount,
        String? senderAccount,
        DateTime? paymentExpired,
        DateTime? paymentAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? serviceName,
        int? appointmentDuration,
        String? userFirstName,
        String? userLastName,
    }) => 
        Payment(
            orderId: orderId ?? this.orderId,
            userId: userId ?? this.userId,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            paymentStatus: paymentStatus ?? this.paymentStatus,
            amountPaid: amountPaid ?? this.amountPaid,
            toAccount: toAccount ?? this.toAccount,
            senderAccount: senderAccount ?? this.senderAccount,
            paymentExpired: paymentExpired ?? this.paymentExpired,
            paymentAt: paymentAt ?? this.paymentAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            serviceName: serviceName ?? this.serviceName,
            appointmentDuration: appointmentDuration ?? this.appointmentDuration,
            userFirstName: userFirstName ?? this.userFirstName,
            userLastName: userLastName ?? this.userLastName,
        );

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        orderId: json["order_id"],
        userId: json["user_id"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        amountPaid: json["amount_paid"],
        toAccount: json["to_account"],
        senderAccount: json["sender_account"],
        paymentExpired: json["payment_expired"] == null ? null : DateTime.parse(json["payment_expired"]),
        paymentAt: json["payment_at"] == null ? null : DateTime.parse(json["payment_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        serviceName: json["service_name"],
        appointmentDuration: json["appointment_duration"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "amount_paid": amountPaid,
        "to_account": toAccount,
        "sender_account": senderAccount,
        "payment_expired": paymentExpired?.toIso8601String(),
        "payment_at": paymentAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "service_name": serviceName,
        "appointment_duration": appointmentDuration,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
    };
}
