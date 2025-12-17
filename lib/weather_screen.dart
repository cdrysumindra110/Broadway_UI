import 'package:broadway_example_ui/weather_brain.dart';
import 'package:broadway_example_ui/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService service = WeatherService();
  WeatherBrain weatherBrain = WeatherBrain();
  String selectValue = "Kathmandu";
  double temp = 0.0;
  int humidity = 0;
  double speed = 0.0;
  // String cityName = '';
  String city = "";
  final searchController = TextEditingController();
  String textIcon = "🌫️";
  String weatherText = "Search to get data";

  Future<Position> determinePosition() async {
    bool serviceEnabled; //hamro loction is enable or not
    LocationPermission permission; // hamile permission diyeko xa ki xaina

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (!serviceEnabled) {
      return Future.error("Location is not enable");
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition();

    // location is on or off
    //user le permission diyeko xa ki xaina
  }

  // #003D73
  // #1B1E48
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF06092F),
      appBar: AppBar(
        backgroundColor: Color(0xFF06092F),
        title: Text("Weather App", style: TextStyle(color: Colors.white)),
        actions: [
          DropdownButton(
            focusColor: Colors.black,
            dropdownColor: Colors.green,
            value: selectValue,
            style: TextStyle(color: Colors.white),
            items: [
              DropdownMenuItem(
                value: "kathmandu",
                child: Text("Kathmandu", style: TextStyle(color: Colors.black)),
              ),
              DropdownMenuItem(
                value: "India",
                child: Text("India", style: TextStyle(color: Colors.black)),
              ),
              DropdownMenuItem(
                value: "China",
                child: Text("China", style: TextStyle(color: Colors.black)),
              ),
              DropdownMenuItem(
                value: "Uk",
                child: Text("Uk", style: TextStyle(color: Colors.black)),
              ),
              DropdownMenuItem(
                value: "USA",
                child: Text("USA", style: TextStyle(color: Colors.black)),
              ),
              DropdownMenuItem(
                value: "Austrila",
                child: Text("Austrila", style: TextStyle(color: Colors.black)),
              ),
            ],
            onChanged: (value) {
              selectValue = value ?? "";
              print(value);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Position position = await determinePosition();
          double latitude = position.latitude;
          double longitude = position.longitude;
          print("Latitude: ${position.latitude}");
          print("Longitude: ${position.longitude}");
          final data = await service.getCurrentLocationWeather(
            latitude,
            longitude,
          );
          print(data);
          setState(() {
            temp = data.main.temp;
            humidity = data.main.humidity;
            speed = data.wind.speed;
            city = data.name;
            textIcon = weatherBrain.getWeatherIcon(data.cod);
            weatherText = weatherBrain.getWeatherText(data.cod);
          });
        },
        child: Icon(Icons.my_location),
      ),
      body: Column(
        children: [
          //TextFormField
          //controller: searchController
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter city Name"),
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String cityname = searchController.text;
              if (cityname.isNotEmpty) {
                final data = await service.getWeather(cityname);
                print(data);

                setState(() {
                  temp = data.main.temp;
                  humidity = data.main.humidity;
                  speed = data.wind.speed;
                  city = data.name;
                  textIcon = weatherBrain.getWeatherIcon(data.cod);
                  weatherText = weatherBrain.getWeatherText(data.cod);
                });
                print(temp);
              } else {
                print("Enter City Name");
              }

              // temp= data
            },
            child: Text("Get Weather"),
          ),
          // Text("Your City is $city", style: TextStyle(color: Colors.white)),
          // Text(
          //   "Your Temperature is $temp",
          //   style: TextStyle(color: Colors.white),
          // ),
          // Text(
          //   "Your Humidity is $humidity",
          //   style: TextStyle(color: Colors.white),
          // ),
          // Text("Your Speed is $speed", style: TextStyle(color: Colors.white)),
          Text(textIcon, style: TextStyle(fontSize: 120)),
          // Text(data)
          Text(weatherText, style: TextStyle(color: Colors.white)),

          Text(
            "${temp.toStringAsFixed(0)}°C",
            style: TextStyle(color: Colors.white, fontSize: 80),
          ),

          SizedBox(height: 120),
          Row(
            children: [
              CustomWidget(icon: '🌧️', value: '90%', name: 'Rain'),
              CustomWidget(icon: '🌫', value: '$speed km/h', name: 'wind'),
              CustomWidget(icon: '🌧', value: '$humidity%', name: 'Humidity'),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.name,
  });
  final String icon;
  final String value;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xff1B1E48),
          borderRadius: BorderRadius.circular(12),
        ),
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(icon, style: TextStyle(fontSize: 54)),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(name, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
