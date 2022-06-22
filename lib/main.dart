import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_test/screens/bloc/weather_bloc.dart';
import 'package:open_weather_test/screens/ui/weather.dart';

import 'dao/local_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Weather(),
        routes: {
          // '/weather': (context) => Weather(),
        },
      ),
    );
  }
}
