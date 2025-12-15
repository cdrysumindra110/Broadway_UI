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
  String cityName = '';
  //searchController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Column(
        children: [
          //TextFormField
          //controller: searchController
          ElevatedButton(
            onPressed: () async {
              //String cityname =controller
              if (cityName.isNotEmpty) {
                final data = await service.getWeather(cityName);
                print(data);

                setState(() {
                  temp = data.main.temp;
                  humidity = data.main.humidity;
                  speed = data.wind.speed;
                });
                print(temp);
              }

              // temp= data
            },
            child: Text("Get Weather"),
          ),
          Text("Your Temperature is $temp"),
          Text("Your Humidity is $humidity"),
          Text("Your Speed is $speed"),
        ],
      ),
    );
  }
}
