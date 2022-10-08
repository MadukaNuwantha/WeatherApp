import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

Widget todayTabWidget(BuildContext context) {
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
                  DateFormat('EEEE, d MMM').format(weatherProvider.todayForcast.date).toLowerCase(),
                  style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline3),
                ),
                Text(
                  weatherProvider.todayForcast.cityName,
                  style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline4),
                ),
                Text(
                  weatherProvider.todayForcast.countryCode,
                  style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline3),
                ),
              ],
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Text(
                weatherProvider.todayForcast.weather.description,
                style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline2),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              weatherProvider.todayForcast.weather.description == 'Sunny'
                  ? 'assets/images/sunny.png'
                  : weatherProvider.todayForcast.weather.description == 'Stormy'
                      ? 'assets/images/storm.png'
                      : weatherProvider.todayForcast.weather.description == 'Rainy'
                          ? 'assets/images/rain.png'
                          : weatherProvider.todayForcast.weather.description == 'Cloudy'
                              ? 'assets/images/cloudy.png'
                              : weatherProvider.todayForcast.weather.description == 'Snowy'
                                  ? 'assets/images/snowy.png'
                                  : 'assets/images/stormy.png',
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weatherProvider.todayForcast.temperature.toString(),
              style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline1),
            ),
            Text(
              '\u2103',
              style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6),
            ),
          ],
        )
      ],
    ),
  );
}
