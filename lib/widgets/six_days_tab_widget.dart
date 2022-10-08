import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

Widget sixDaysTabWidget(BuildContext context) {
  final weatherProvider = Provider.of<WeatherProvider>(context);
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weatherProvider.sixteenDayForecastList[index].temperature}\u00B0',
                      style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6, fontSize: 35),
                    ),
                    Text(
                      DateFormat('EEEE, d MMM').format(weatherProvider.sixteenDayForecastList[index].date).toLowerCase(),
                      style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6, fontSize: 12),
                    ),
                  ],
                ),
                trailing: Image.asset(
                  weatherProvider.sixteenDayForecastList[index].weather.description == 'Sunny'
                      ? 'assets/images/sunny.png'
                      : weatherProvider.sixteenDayForecastList[index].weather.description == 'Stormy'
                          ? 'assets/images/storm.png'
                          : weatherProvider.sixteenDayForecastList[index].weather.description == 'Rainy'
                              ? 'assets/images/rain.png'
                              : weatherProvider.sixteenDayForecastList[index].weather.description == 'Cloudy'
                                  ? 'assets/images/cloudy.png'
                                  : weatherProvider.sixteenDayForecastList[index].weather.description == 'Snowy'
                                      ? 'assets/images/snowy.png'
                                      : 'assets/images/stormy.png',
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wind Direction',
                              style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6, fontSize: 12),
                            ),
                            Text(
                              'Wind Speed',
                              style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6, fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weatherProvider.sixteenDayForecastList[index].windDirection,
                              style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6, fontSize: 12),
                            ),
                            Text(
                              weatherProvider.sixteenDayForecastList[index].windSpeed.toString(),
                              style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      )
    ],
  );
}
