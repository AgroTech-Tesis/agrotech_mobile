import 'dart:convert';

List<Zone> zoneFromJson(String str) =>
    List<Zone>.from(
        json.decode(str).map((x) => Zone.fromJson(x)));

String zoneToJson(List<Zone> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Zone {
  int? id;
  String? name;
  String ? createdAt;
  String? updatedAt;
  double? waterAmount;

  Zone({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.waterAmount,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      waterAmount: json['waterAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'waterAmount': waterAmount
    };
  }
}
