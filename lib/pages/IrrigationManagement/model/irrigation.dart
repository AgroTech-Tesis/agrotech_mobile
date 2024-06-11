import 'dart:convert';

List<Irrigation> irrigationFromJson(String str) =>
    List<Irrigation>.from(
        json.decode(str).map((x) => Irrigation.fromJson(x)));

String irrigationToJson(List<Irrigation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Irrigation {
  int? id;
  DateTime ? createdAt;
  String? updatedAt;
  String? endedAt;
  double? waterAmount;
  int? irrigationNumber;
  int? daysPreviousIrrigation;
  int? riceCropId;
  String? status;

  Irrigation({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.endedAt,
    this.waterAmount,
    this.irrigationNumber,
    this.daysPreviousIrrigation,
    this.riceCropId,
    this.status,
  });

  factory Irrigation.fromJson(Map<String, dynamic> json) {
    return Irrigation(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      endedAt: json['endedAt'],
      waterAmount: json['waterAmount'],
      irrigationNumber: json['irrigationNumber'],
      daysPreviousIrrigation: json['daysPreviousIrrigation'],
      riceCropId: json['riceCropId'],
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'endedAt': endedAt,
      'waterAmount': waterAmount,
      'irrigationNumber': irrigationNumber,
      'daysPreviousIrrigation': daysPreviousIrrigation,
      'riceCropId': riceCropId,
      'status': status
    };
  }
}
