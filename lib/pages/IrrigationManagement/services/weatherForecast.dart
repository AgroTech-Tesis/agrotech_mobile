import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agrotech_mobile/pages/IrrigationManagement/model/weatherForecast.dart'; // Asegúrate de importar el modelo

class WeatherForecastService {
  static const String _apiKey = '2f9e9bd1c34f8074792547f6b3bf82bb';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherForecast> getWeatherData(String city) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$city&appid=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherForecast.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
