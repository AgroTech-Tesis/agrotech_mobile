import 'dart:convert';

List<RiceCrop> riceCropFromJson(String str) =>
    List<RiceCrop>.from(
        json.decode(str).map((x) => RiceCrop.fromJson(x)));

String riceCropToJson(List<RiceCrop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiceCrop {
  int? id;
  String ? name;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? farmerId;

  RiceCrop({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.farmerId,
  });

  factory RiceCrop.fromJson(Map<String, dynamic> json) {
    return RiceCrop(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      farmerId: json['farmerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status,
      'farmerId': farmerId
    };
  }
}
