import 'dart:convert';

import 'package:agrotech_mobile/pages/IrrigationManagement/model/riceCrop.dart';

List<Scheduleirrigation> scheduleirrigationFromJson(String str) =>
    List<Scheduleirrigation>.from(
        json.decode(str).map((x) => Scheduleirrigation.fromJson(x)));

String scheduleirrigationToJson(List<Scheduleirrigation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Scheduleirrigation {
  int? id;
  String ? irrigationDate;
  double? irrigationTime;
  String? name;
  int? riceCropId;

  Scheduleirrigation({
    this.id,
    this.irrigationDate,
    this.irrigationTime,
    this.name,
    this.riceCropId
  });

  factory Scheduleirrigation.fromJson(Map<String, dynamic> json) {
    return Scheduleirrigation(
      id: json['id'],
      irrigationDate: json['irrigationDate'],
      irrigationTime: json['irrigationTime'],
      name: json['name'],
      riceCropId: json['riceCropId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'irrigationDate': irrigationDate,
      'irrigationTime': irrigationTime,
      'name': name,
      'riceCropId': riceCropId
    };
  }
}
