import 'package:broadway_example_ui/next_screen.dart';
import 'package:broadway_example_ui/weather/weather_bloc.dart';
import 'package:broadway_example_ui/weather/weather_brain.dart';
import 'package:broadway_example_ui/weather/weather_event.dart';
import 'package:broadway_example_ui/weather/weather_provider.dart';
import 'package:broadway_example_ui/weather/weather_service.dart';
import 'package:broadway_example_ui/weather/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = "";
  final searchController = TextEditingController();
  String selectValue = 'kathmandu';

  // #003D73
  // #1B1E48
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<WeatherProvider>(context);
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
              final val = value ?? "";
              print(value);
              // provider.getSearchData(val);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // provider.getCurrentData();
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
                context.read<WeatherBloc>().add(GetWeather(cityname));
                // provider.getSearchData(cityname);
              } else {
                print("Enter City Name");
              }

              // temp= data
            },
            child: Text("Get Weather"),
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<WeatherBloc>().add(GetTextIcon());
              // temp= data
            },
            child: Text("Get textIcon"),
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherError) {
                return Center(child: Text(state.message));
              }
              if (state is LoadTextIcon) {
                return Center(child: Text(state.textIcon));
              }
              if (state is WeatherLoaded) {
                return Column(
                  children: [
                    Text(
                      (state.weather?.main.temp ?? 1.0).toStringAsFixed(0),
                      // "${provider.temp.toStringAsFixed(0)}°C",
                      style: TextStyle(color: Colors.white, fontSize: 80),
                    ),
                    Text(
                      "${state.weather?.name}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                );
              }
              return Center(child: Text("Load data"));
            },
          ),

          // Text(provider.textIcon, style: TextStyle(fontSize: 120)),
          // Text(data)
          // Text(provider.weatherText, style: TextStyle(color: Colors.white)),
          // SizedBox(height: 120),
          // Row(
          //   children: [
          //     CustomWidget(icon: '🌧️', value: '90%', name: 'Rain'),
          //     CustomWidget(
          //       icon: '🌫',
          //       value: '${provider.speed} km/h',
          //       // value: '${provider.weather?.wind.speed ?? 0.0} km/h',
          //       name: 'wind',
          //     ),
          //     CustomWidget(
          //       icon: '🌧',
          //       value: '${provider.humidity}%',
          //       name: 'Humidity',
          //     ),
          //   ],
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => AnimationScreen()),
          //     );
          //   },
          //   child: Text("Next Screen"),
          // ),
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
