import 'dart:convert';

List<Device> deviceFromJson(String str) =>
    List<Device>.from(
        json.decode(str).map((x) => Device.fromJson(x)));

String deviceToJson(List<Device> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Device {
  int? id;
  String ? createdAt;
  String? updatedAt;
  String? endedAt;
  double? waterAmount;
  int? deviceNumber;
  int? daysPreviousDevice;

  Device({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.endedAt,
    this.waterAmount,
    this.deviceNumber,
    this.daysPreviousDevice,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      endedAt: json['endedAt'],
      waterAmount: json['waterAmount'],
      deviceNumber: json['deviceNumber'],
      daysPreviousDevice: json['daysPreviousDevice']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'endedAt': endedAt,
      'waterAmount': waterAmount,
      'deviceNumber': deviceNumber,
      'daysPreviousDevice': daysPreviousDevice
    };
  }
}
