class WeatherForecast {
  final String name;
  final String tempCelcius;
  final String tempMin;
  final String tempMax;
  final String description;

  WeatherForecast({
    required this.name,
    required this.tempCelcius,
    required this.tempMin,
    required this.tempMax,
    required this.description,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      name: json['name'],
      tempCelcius: (json['main']['temp'] - 273.15).toStringAsFixed(0),
      tempMin: (json['main']['temp_min'] - 273.15).toStringAsFixed(0),
      tempMax: (json['main']['temp_max'] - 273.15).toStringAsFixed(0),
      description: getDescription(json['weather'][0]['description']),
    );
  }

  static String getDescription(String description) {
    switch (description) {
      case 'clear sky':
        return 'cielo despejado';
      case 'few clouds':
        return 'parcialmente nublado';
      case 'scattered clouds':
        return 'nubes dispersas';
      case 'broken clouds':
        return 'nubes rotas';
      case 'shower rain':
        return 'lluvia de chubascos';
      case 'rain':
        return 'lluvioso';
      case 'thunderstorm':
        return 'tormenta eléctrica';
      case 'snow':
        return 'nieve';
      case 'mist':
        return 'niebla';
      default:
        return description;
    }
  }
}
