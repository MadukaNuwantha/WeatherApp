import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

Widget tomorrowTabWidget(BuildContext context) {
  final weatherProvider = Provider.of<WeatherProvider>(context);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, d MMM').format(weatherProvider.tomorrowForcast.date).toLowerCase(),
                  style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline3),
                ),
                Text(
                  weatherProvider.tomorrowForcast.cityName,
                  style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline4),
                ),
                Text(
                  weatherProvider.tomorrowForcast.countryCode,
                  style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline3),
                ),
              ],
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Text(
                weatherProvider.tomorrowForcast.weather.description,
                style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline2),
              ),
            ),
          ],
        ),
        Image.asset(
          weatherProvider.tomorrowForcast.weather.description == 'Sunny'
              ? 'assets/images/sunny.png'
              : weatherProvider.tomorrowForcast.weather.description == 'Stormy'
                  ? 'assets/images/storm.png'
                  : weatherProvider.tomorrowForcast.weather.description == 'Rainy'
                      ? 'assets/images/rain.png'
                      : weatherProvider.tomorrowForcast.weather.description == 'Cloudy'
                          ? 'assets/images/cloudy.png'
                          : weatherProvider.tomorrowForcast.weather.description == 'Snowy'
                              ? 'assets/images/snowy.png'
                              : 'assets/images/stormy.png',
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weatherProvider.tomorrowForcast.temperature.toString(),
                style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline1),
              ),
              Text(
                '\u2103',
                style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
