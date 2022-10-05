import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/location_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    locationProvider
        .getCurrentLocation()
        .then(
          (value) => weatherProvider.getTodayWeatherForcast(
            context,
            locationProvider.locationData.longitude,
            locationProvider.locationData.latitude,
          ),
        )
        .then(
          (value) => weatherProvider
              .getTomorrowWeatherForcast(
                context,
                locationProvider.locationData.longitude,
                locationProvider.locationData.latitude,
              )
              .then(
                (value) => weatherProvider
                    .getSixteenDayWeatherForcast(
                  context,
                  locationProvider.locationData.longitude,
                  locationProvider.locationData.latitude,
                )
                    .then(
                  (value) {
                    themeProvider.setWeatherTheme(weatherProvider.todayForcast.weather.code);
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),
    );
  }
}
