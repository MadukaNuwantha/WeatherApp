import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:weather_app/widgets/six_days_tab_widget.dart';
import 'package:weather_app/widgets/today_tab_widget.dart';
import 'package:weather_app/widgets/tomorrow_tab_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final searchController = TextEditingController();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    String apiKEY = "AIzaSyAl_ny0bbRV4cGnh4n5s1CuMB-YmK49SIs";
    googlePlace = GooglePlace(apiKEY);
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                Positioned(
                  top: 70,
                  width: MediaQuery.of(context).size.width,
                  child: DefaultTabController(
                    length: 3, // length of tabs
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TabBar(
                          indicatorColor: Theme.of(context).hintColor,
                          tabs: [
                            Tab(
                              child: Text(
                                'Today',
                                style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline5),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Tomorrow',
                                style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline5),
                              ),
                            ),
                            Tab(
                              child: Text(
                                '6 Days',
                                style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                            children: <Widget>[
                              todayTabWidget(context),
                              tomorrowTabWidget(context),
                              sixDaysTabWidget(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    elevation: 4.0,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: searchController,
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                              size: 30,
                              color: Theme.of(context).hintColor,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (debounce?.isActive ?? false) debounce!.cancel();
                            debounce = Timer(
                              const Duration(microseconds: 20000),
                              () {
                                if (value.isNotEmpty) {
                                  autoCompleteSearch(value);
                                } else {
                                  setState(() {
                                    predictions = [];
                                  });
                                }
                              },
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: predictions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    width: 0.1,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.location_pin,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(
                                  predictions[index].description.toString(),
                                  style: GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.headline6, fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
