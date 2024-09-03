import 'dart:convert';
import 'dart:ffi';

List<Scheduleirrigation> scheduleirrigationFromJson(String str) =>
    List<Scheduleirrigation>.from(
        json.decode(str).map((x) => Scheduleirrigation.fromJson(x)));

String scheduleirrigationToJson(List<Scheduleirrigation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Scheduleirrigation {
  int? id;
  String ? irrigationDate;
  Float? irrigationTime;
  String? name;

  Scheduleirrigation({
    this.id,
    this.irrigationDate,
    this.irrigationTime,
    this.name,
  });

  factory Scheduleirrigation.fromJson(Map<String, dynamic> json) {
    return Scheduleirrigation(
      id: json['id'],
      irrigationDate: json['irrigationDate'],
      irrigationTime: json['irrigationTime'],
      name: json['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'irrigationDate': irrigationDate,
      'irrigationTime': irrigationTime,
      'name': name
    };
  }
}
