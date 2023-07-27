// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
    int? notifId;
    String? messages;
    bool? isSend;
    bool? isRead;
    DateTime? createdAt;

    NotificationModel({
        this.notifId,
        this.messages,
        this.isSend,
        this.isRead,
        this.createdAt,
    });

    NotificationModel copyWith({
        int? notifId,
        String? messages,
        bool? isSend,
        bool? isRead,
        DateTime? createdAt,
    }) => 
        NotificationModel(
            notifId: notifId ?? this.notifId,
            messages: messages ?? this.messages,
            isSend: isSend ?? this.isSend,
            isRead: isRead ?? this.isRead,
            createdAt: createdAt ?? this.createdAt,
        );

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        notifId: json["notif_id"],
        messages: json["messages"],
        isSend: json["is_send"],
        isRead: json["is_read"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "notif_id": notifId,
        "messages": messages,
        "is_send": isSend,
        "is_read": isRead,
        "created_at": createdAt?.toIso8601String(),
    };
}
