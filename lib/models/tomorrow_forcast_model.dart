import 'package:weather_app/models/weather_model.dart';

class TomorrowForcast {
  String countryCode;
  String cityName;
  double temperature;
  DateTime date;
  Weather weather;

  TomorrowForcast({
    required this.countryCode,
    required this.cityName,
    required this.temperature,
    required this.date,
    required this.weather,
  });

  factory TomorrowForcast.fromJson(Map<String, dynamic> json) => TomorrowForcast(
        countryCode: '',
        cityName: '',
        temperature: json["temp"].toDouble(),
        date: DateTime.now(),
        weather: Weather.fromJson(json["weather"]),
      );
}
