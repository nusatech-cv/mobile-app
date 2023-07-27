// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

List<Service> serviceFromJson(String str) => List<Service>.from(json.decode(str).map((x) => Service.fromJson(x)));

String serviceToJson(List<Service> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Service {
    int? serviceId;
    String? name;
    String? description;
    String? pricePerHour;
    ImageUser? image;
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
        ImageUser? image,
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
        image: json["image"] == null ? null : ImageUser.fromJson(json["image"]),
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

class ImageUser {
    dynamic url;

    ImageUser({
        this.url,
    });

    ImageUser copyWith({
        dynamic url,
    }) => 
        ImageUser(
            url: url ?? this.url,
        );

    factory ImageUser.fromJson(Map<String, dynamic> json) => ImageUser(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
