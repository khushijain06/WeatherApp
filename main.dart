import 'package:flutter/material.dart';
import 'package:mausam/mausam_model.dart';
import 'package:mausam/mausam_service.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();
  MausamModel? mausammodel;
  String getdescription() {
    return mausammodel?.weather?[0].description ?? "unknown";
  }

  String formatTemp(double kelvin) {
    double cel = kelvin - 273.15;
    return cel.toStringAsFixed(3);
  }

  Widget animation() {
    final description = getdescription();

    if (description == "haze" ||
        description == "few clouds" ||
        description == "scattered clouds" ||
        description == 'broken clouds' ||
        description == "overcast clouds" ||
        description == "mist" ||
        description == "broken clouds") {
      return LottieBuilder.asset(
        'assets/rain_weather_animation.json',
        height: 200,
        width: 200,
      );
    } else if (description == 'rain') {
      return LottieBuilder.asset('assets/rain_weather_animation.json',
          height: 200, width: 200);
    } else if (description == "clear sky") {
      return LottieBuilder.asset(
        'assets/sunny_weather_animation.json',
        height: 200,
        width: 200,
      );
    } else if (description == "thunderstorm") {
      return LottieBuilder.asset('assets/thunder_weather_animation.json',
          height: 200, width: 2000);
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:Color.fromARGB(255, 213, 241, 249),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animation(),
            Text('weather : ${getdescription()}'),
            Text(
                'Temperature : ${formatTemp((mausammodel?.main?.temp ?? 0))} °C'),
            Padding(
              padding: const EdgeInsets.fromLTRB(45, 16, 45, 16),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(26.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 150,right: 150,top: 15),
            child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 166, 198, 224)),
                  minimumSize: MaterialStatePropertyAll(Size(double.infinity, 50))
                ),
                onPressed: () async {
                  mausammodel =
                      await WeatherService().getWeather(controller.text);
                  //print(mausammodel?.main?.temp);
                  setState(() {});
                },
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.black),
                ))),
          ],
        ),
      ),
    );
  }
}
