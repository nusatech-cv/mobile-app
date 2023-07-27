// To parse this JSON data, do
//
//     final paymentMethods = paymentMethodsFromJson(jsonString);

import 'dart:convert';

List<PaymentMethods> paymentMethodsFromJson(String str) =>
    List<PaymentMethods>.from(
        json.decode(str).map((x) => PaymentMethods.fromJson(x)));

String paymentMethodsToJson(List<PaymentMethods> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMethods {
  String? key;
  String? label;
  String? icon;

  PaymentMethods({
    this.key,
    this.label,
    this.icon,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
        key: json["key"],
        label: json["label"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "label": label,
        "icon": icon,
      };
}
