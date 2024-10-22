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
  String getWeatherIcon() {
    print(description);
    if (description.contains('cielo despejado')) {
      return 'assets/sunny.png';
    } else if (description.contains('nubes dispersas')) {
      return 'assets/cloudy.png';
    } else if (description.contains('lluvioso')) {
      return 'assets/rainy.png';
    } else if (description.contains('tormenta eléctrica')) {
      return 'assets/thunderstorm.png';
    } else if (description.contains('nieve')) {
      return 'assets/snow.png';
    } else if (description.contains('niebla')) {
      return 'assets/mist.png';
    } else {
      return 'assets/default_weather.png';
    }
  }
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
