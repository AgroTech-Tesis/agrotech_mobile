import 'dart:convert';

List<ZoneDetail> zoneFromJson(String str) =>
    List<ZoneDetail>.from(
        json.decode(str).map((x) => ZoneDetail.fromJson(x)));

String zoneToJson(List<ZoneDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneDetail {
  String? naHumidityOfFloor;
  String ? roomTemperature;
  String? waterConsumption;

  ZoneDetail({
    this.naHumidityOfFloor,
    this.roomTemperature,
    this.waterConsumption,
  });

  factory ZoneDetail.fromJson(Map<String, dynamic> json) {
    return ZoneDetail(
      naHumidityOfFloor: json['naHumidityOfFloor'],
      roomTemperature: json['roomTemperature'],
      waterConsumption: json['waterConsumption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'naHumidityOfFloor': naHumidityOfFloor,
      'roomTemperature': roomTemperature,
      'waterConsumption': waterConsumption,
    };
  }
}
