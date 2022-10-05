import 'package:weather_app/models/weather_model.dart';

class TodayForcast {
  String countryCode;
  String cityName;
  double temperature;
  DateTime date;
  Weather weather;

  TodayForcast({
    required this.countryCode,
    required this.cityName,
    required this.temperature,
    required this.date,
    required this.weather,
  });

  factory TodayForcast.fromJson(Map<String, dynamic> json) => TodayForcast(
        countryCode: json["country_code"],
        cityName: json["city_name"],
        temperature: json["temp"].toDouble(),
        date: DateTime.now(),
        weather: Weather.fromJson(json["weather"]),
      );
}
