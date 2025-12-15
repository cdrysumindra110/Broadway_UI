import 'package:broadway_example_ui/weather_service.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService service = WeatherService();
  double temp = 0.0;
  int humidity = 0;
  double speed = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final data = await service.getWeather();
              // temp= data
              print(data);

              temp = data.temp;
              humidity = data.humidity;
              speed = data.speed;
              print(temp);
            },
            child: Text("Get Weather"),
          ),
        ],
      ),
    );
  }
}
