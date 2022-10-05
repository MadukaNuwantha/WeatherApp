import 'package:weather_app/models/weather_model.dart';

class SixteenDayForecast {
  double temperature;
  String windDirection;
  double windSpeed;
  DateTime date;
  Weather weather;

  SixteenDayForecast({
    required this.temperature,
    required this.windDirection,
    required this.windSpeed,
    required this.date,
    required this.weather,
  });

  factory SixteenDayForecast.fromJson(Map<String, dynamic> json) => SixteenDayForecast(
        temperature: json["temp"].toDouble(),
        windDirection: json["wind_cdir"],
        windSpeed: json["wind_spd"].toDouble(),
        date: DateTime.parse(json["datetime"]),
        weather: Weather.fromJson(json["weather"]),
      );
}
