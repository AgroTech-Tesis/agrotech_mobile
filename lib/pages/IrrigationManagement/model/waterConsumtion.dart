import 'dart:convert';

List<WaterConsumption> sensorDataRecordFromJson(String str) =>
    List<WaterConsumption>.from(
        json.decode(str).map((x) => WaterConsumption.fromJson(x)));

String sensorDataRecordToJson(List<WaterConsumption> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WaterConsumption {
  String? waterConsumtion;

  WaterConsumption({
    this.waterConsumtion,
  });

  factory WaterConsumption.fromJson(Map<String, dynamic> json) {
    return WaterConsumption(
      waterConsumtion: json['water-consumption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'waterConsumtion': waterConsumtion,
    };
  }
}
