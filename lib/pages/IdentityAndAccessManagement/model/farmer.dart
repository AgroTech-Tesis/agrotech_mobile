import 'dart:convert';

List<Farmer> farmerFromJson(String str) =>
    List<Farmer>.from(
        json.decode(str).map((x) => Farmer.fromJson(x)));

String farmerToJson(List<Farmer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Farmer {
  int ? id;
  String? name;
  String ? address;
  String ? phoneNumber;

  Farmer({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phoneNumber']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber
    };
  }
}
