import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/sixteen_day_forcast_model.dart';
import 'package:weather_app/models/today_forcast_model.dart';
import 'package:weather_app/models/tomorrow_forcast_model.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  String weatherURL = 'https://weatherbit-v1-mashape.p.rapidapi.com';
  String apiKey = '0b919726f7mshe1be7ef9c3806aap172a51jsn9f08cfad1e92';
  String apiHost = 'weatherbit-v1-mashape.p.rapidapi.com';

  TodayForcast todayForcast = TodayForcast(
    countryCode: '',
    cityName: '',
    temperature: 0.0,
    date: DateTime.now(),
    weather: Weather(
      icon: '',
      code: 0,
      description: '',
    ),
  );

  TomorrowForcast tomorrowForcast = TomorrowForcast(
    countryCode: '',
    cityName: '',
    temperature: 0.0,
    date: DateTime.now(),
    weather: Weather(
      icon: '',
      code: 0,
      description: '',
    ),
  );

  List<SixteenDayForecast> sixteenDayForecastList = [];

  String? checkForcastMode(int weatherCode) {
    if (weatherCode < 250) {
      // Storm
      return 'Stormy';
    } else if (250 < weatherCode && weatherCode < 550) {
      // Rain
      return 'Rainy';
    } else if (550 < weatherCode && weatherCode < 611) {
      // Snow
      return 'Snowy';
    } else if (550 < weatherCode && weatherCode < 613) {
      // Wind
      return 'Windy';
    } else if (613 < weatherCode && weatherCode < 760) {
      // Snow
      return 'Snowy';
    } else if (weatherCode == 800) {
      // Sunny
      return 'Sunny';
    } else if (800 < weatherCode) {
      // Cloudy
      return 'Cloudy';
    }
    return null;
  }

  Future<void> getTodayWeatherForcast(
    BuildContext context,
    double? longitude,
    double? latitude,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$weatherURL/current?lon=$longitude&lat=$latitude'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': apiHost,
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body)['data'][0];
          todayForcast = TodayForcast.fromJson(json);
          todayForcast.weather.description = checkForcastMode(todayForcast.weather.code)!;
          break;
        case 404:
          break;
        case 500:
          break;
        default:
      }
    } on SocketException {
      throw Constants.connectionError;
    } on TimeoutException {
      throw Constants.timeout;
    } catch (e) {
      throw Constants.serverError;
    }
  }

  Future<void> getTomorrowWeatherForcast(
    BuildContext context,
    double? longitude,
    double? latitude,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$weatherURL/forecast/daily?lon=$longitude&lat=$latitude'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': apiHost,
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body)['data'][1];
          tomorrowForcast = TomorrowForcast.fromJson(json);
          tomorrowForcast.weather.description = checkForcastMode(tomorrowForcast.weather.code)!;
          tomorrowForcast.date = todayForcast.date.add(const Duration(days: 1));
          tomorrowForcast.countryCode = todayForcast.countryCode;
          tomorrowForcast.cityName = todayForcast.cityName;
          break;
        case 404:
          break;
        case 500:
          break;
        default:
      }
    } on SocketException {
      throw Constants.connectionError;
    } on TimeoutException {
      throw Constants.timeout;
    } catch (e) {
      throw Constants.serverError;
    }
  }

  Future<void> getSixteenDayWeatherForcast(
    BuildContext context,
    double? longitude,
    double? latitude,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$weatherURL/forecast/daily?lon=$longitude&lat=$latitude'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': apiHost,
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final json = jsonDecode(response.body)['data'];
          for (Map<String, dynamic> forcast in json) {
            sixteenDayForecastList.add(SixteenDayForecast.fromJson(forcast));
          }
          for (var dayForcast in sixteenDayForecastList) {
            dayForcast.weather.description = checkForcastMode(dayForcast.weather.code)!;
          }
          break;
        case 404:
          break;
        case 500:
          break;
        default:
      }
    } on SocketException {
      throw Constants.connectionError;
    } on TimeoutException {
      throw Constants.timeout;
    } catch (e) {
      print(e);
      // throw Constants.serverError;
    }
  }

  Future<void> getSevereWeatherAlerts(
    BuildContext context,
    double? longitude,
    double? latitude,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$weatherURL/alerts?lon=$longitude&lat=$latitude'),
        headers: {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': apiHost,
        },
      );
      switch (response.statusCode) {
        case 200:
          break;
        case 404:
          break;
        case 500:
          break;
        default:
      }
    } on SocketException {
      throw Constants.connectionError;
    } on TimeoutException {
      throw Constants.timeout;
    } catch (e) {
      throw Constants.serverError;
    }
  }
}
