import 'dart:convert';

PaymentUser paymentUserFromJson(String str) =>
    PaymentUser.fromJson(json.decode(str));

String paymentUserToJson(PaymentUser data) => json.encode(data.toJson());

class PaymentUser {
  String? paymentMethod;
  String? paymentStatus;
  String? amountPaid;
  String? toAccount;
  String? senderAccount;
  DateTime? paymentExpired;
  dynamic paymentAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentUser({
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

  factory PaymentUser.fromJson(Map<String, dynamic> json) => PaymentUser(
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        amountPaid: json["amount_paid"],
        toAccount: json["to_account"],
        senderAccount: json["sender_account"],
        paymentExpired: json["payment_expired"] == null
            ? null
            : DateTime.parse(json["payment_expired"]),
        paymentAt: json["payment_at"],
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
        "payment_at": paymentAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
