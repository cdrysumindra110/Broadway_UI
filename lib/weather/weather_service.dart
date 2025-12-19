import 'dart:convert';

import 'package:broadway_example_ui/weather/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "0b10461d5a30e6612ce19d84c97ef651";
  //city name --string
  Future<WeatherModel> getWeather(String cityName) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey",
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
        return weatherModel;
      } else {
        throw Exception("Failed to load weather");
      }

      // return weatherModel;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<WeatherModel> getCurrentLocationWeather(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey",
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
        return weatherModel;
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
