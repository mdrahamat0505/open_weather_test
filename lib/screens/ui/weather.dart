import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../bloc/weather_bloc.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<WeatherBloc>().add(WeatherDataFaced());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: BlocListener<WeatherBloc, WeatherState>(
        listenWhen: (p, c) => p.status != c.status,
        listener: (BuildContext context, state) async {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Scaffold(
              appBar: AppBar(
                title: const Text("Show Successfully"),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Scaffold(
              appBar: AppBar(
                title: const Text("Show failed"),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Submitting...')));
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          buildWhen: (previous, current) =>
              previous.weatherModel != current.weatherModel,
          builder: (BuildContext context, state) {
            return state.weatherModel != null
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: ListView(
                        children: [
                          ClipPath(
                            // clipper: OvalBottomBorderClipper(),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              color: Colors.indigo,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.weatherModel?.name != null
                                                ? state.weatherModel?.name
                                                    as String
                                                : '',
                                            style: GoogleFonts.lato(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            DateFormat("EEE, d LLL")
                                                .format(DateTime.now()),
                                            style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const IconButton(
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                        onPressed: null,
                                        // onPressed: () {
                                        //   double latitude = selectedLocation != null
                                        //       ? selectedLocation.latitude
                                        //       : 31.5925;
                                        //   double longitude = selectedLocation != null
                                        //       ? selectedLocation.longitude
                                        //       : 74.3095;
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               SimpleLocationPicker(
                                        //                 initialLatitude: latitude,
                                        //                 initialLongitude: longitude,
                                        //                 appBarTitle:
                                        //                     "Select Location",
                                        //                 zoomLevel: 8,
                                        //                 appBarColor: Colors.indigo,
                                        //                 markerColor: Colors.indigo,
                                        //               ))).then((value) {
                                        //     if (value != null) {
                                        //       setState(() {
                                        //         selectedLocation = value;
                                        //         Navigator.pushReplacementNamed(
                                        //             context, "/loading",
                                        //             arguments: selectedLocation);
                                        //       });
                                        //     }
                                        //   });
                                        // },
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                    child: Column(
                                      children: [
                                        Transform.scale(
                                            scale: 1.6,
                                            child: SvgPicture.asset(state
                                                        .weatherModel?.icon !=
                                                    null
                                                ? "assets/svgs/${state.weatherModel?.icon}.svg"
                                                : '')),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.weatherModel?.temperature !=
                                                      null
                                                  ? state
                                                      .weatherModel?.temperature
                                                      .toString() as String
                                                  : '',
                                              // ' weather.temperature.toString()',
                                              style: GoogleFonts.lato(
                                                fontSize: 65,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "°C",
                                              style: GoogleFonts.lato(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          state.weatherModel?.condition != null
                                              ? state.weatherModel?.condition
                                                  .toString() as String
                                              : '',
                                          style: GoogleFonts.lato(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          state.weatherModel?.feelsLike != null
                                              ? "Feels like ${state.weatherModel?.feelsLike}°C"
                                              : '',
                                          style: GoogleFonts.lato(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.indigo,
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.white),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: const Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Colors.indigo,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text("Visibility",
                                                style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              state.weatherModel?.visibility !=
                                                      null
                                                  ? "${state.weatherModel?.visibility} km"
                                                  : '',
                                              style: GoogleFonts.lato(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.indigo,
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.white),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: const Icon(
                                                // Ionicons.ios_water,
                                                Icons.water,
                                                color: Colors.indigo,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              "Humidity",
                                              style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              state.weatherModel?.humidity !=
                                                      null
                                                  ? "${state.weatherModel?.humidity}%"
                                                  : '',
                                              style: GoogleFonts.lato(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.indigo,
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.white),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: const Icon(
                                                Icons.wind_power,
                                                color: Colors.indigo,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              "Wind Speed",
                                              style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              state.weatherModel?.windSpeed !=
                                                      null
                                                  ? "${state.weatherModel?.windSpeed.floor()} km/hr"
                                                  : '',
                                              style: GoogleFonts.lato(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
