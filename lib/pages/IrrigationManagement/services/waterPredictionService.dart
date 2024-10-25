import 'dart:convert';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/waterConsumtion.dart';
import 'package:http/http.dart' as http;

class WaterPredictionService {
  WaterPredictionService();
  String urlService =
      "https://water-consumption-forecast-api.onrender.com/daily-forecasts";

  Future<WaterConsumption?> getWaterPrediction() async {
    var uri = Uri.parse(urlService);

    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      return WaterConsumption.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
