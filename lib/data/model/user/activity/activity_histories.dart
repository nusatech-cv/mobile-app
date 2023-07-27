import 'dart:convert';

List<ActivityHistories> activityHistoriesFromJson(String str) =>
    List<ActivityHistories>.from(
        json.decode(str).map((x) => ActivityHistories.fromJson(x)));

String activityHistoriesToJson(List<ActivityHistories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityHistories {
  String? firstName;
  String? lastName;
  String? userEmail;
  String? result;
  String? activityType;
  String? ipAddress;
  String? deviceInfo;
  Location? location;
  DateTime? createdAt;

  ActivityHistories({
    this.firstName,
    this.lastName,
    this.userEmail,
    this.result,
    this.activityType,
    this.ipAddress,
    this.deviceInfo,
    this.location,
    this.createdAt,
  });

  factory ActivityHistories.fromJson(Map<String, dynamic> json) =>
      ActivityHistories(
        firstName: json["first_name"],
        lastName: json["last_name"],
        userEmail: json["user_email"],
        result: json["result"],
        activityType: json["activity_type"],
        ipAddress: json["ip_address"],
        deviceInfo: json["device_info"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "user_email": userEmail,
        "result": result,
        "activity_type": activityType,
        "ip_address": ipAddress,
        "device_info": deviceInfo,
        "location": location?.toJson(),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Location {
  double? x;
  double? y;

  Location({
    this.x,
    this.y,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
