import 'dart:convert';

List<SensorDataRecord> sensorDataRecordFromJson(String str) =>
    List<SensorDataRecord>.from(
        json.decode(str).map((x) => SensorDataRecord.fromJson(x)));

String sensorDataRecordToJson(List<SensorDataRecord> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SensorDataRecord {
  int? id;
  String? typeSensor;
  String? createdAt;
  double? lastValue;

  SensorDataRecord({
    this.id,
    this.typeSensor,
    this.createdAt,
    this.lastValue,
  });

  factory SensorDataRecord.fromJson(Map<String, dynamic> json) {
    return SensorDataRecord(
      id: json['id'],
      typeSensor: json['typeSensor'],
      createdAt: json['createdAt'],
      lastValue: json['lastValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeSensor': typeSensor,
      'createdAt': createdAt,
      'lastValue': lastValue,
    };
  }
}
