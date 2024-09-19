import 'dart:convert';

List<SensorDataRecord> sensorDataRecordFromJson(String str) =>
    List<SensorDataRecord>.from(
        json.decode(str).map((x) => SensorDataRecord.fromJson(x)));

String sensorDataRecordToJson(List<SensorDataRecord> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SensorDataRecord {
  double? flowSensor;
  double? humiditySensor;
  double? temperatureSensor;

  SensorDataRecord({
    this.flowSensor,
    this.humiditySensor,
    this.temperatureSensor,
  });

  factory SensorDataRecord.fromJson(Map<String, dynamic> json) {
    return SensorDataRecord(
      flowSensor: json['flowSensor'],
      humiditySensor: json['humiditySensor'],
      temperatureSensor: json['temperatureSensor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flowSensor': flowSensor,
      'humiditySensor': humiditySensor,
      'temperatureSensor': temperatureSensor,
    };
  }
}
