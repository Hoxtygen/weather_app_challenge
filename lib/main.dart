import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_challenge/screens/loading_screen.dart';
import 'package:weather_app_challenge/widgets/dismiss_keyboard.dart';
import 'controller/city_notifier.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future main() async {
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CityNotifier>(create: (_) => CityNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const WeatherApp(),
      ),
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: LoadingScreen(),
      ),
    );
  }
}
