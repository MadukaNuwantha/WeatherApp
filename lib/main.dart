import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/location_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/routes/screen_routes.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/theme_values.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(sunnyTheme)),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: themeProvider.getTheme(),
      home: const SplashScreen(),
      onGenerateRoute: ScreenRoutes.generateRoute,
    );
  }
}
