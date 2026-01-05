import 'package:broadway_example_ui/weather/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  WeatherLoaded(this.weather);
}

class WeatherError extends WeatherState {
  String message;
  WeatherError(this.message);
}

class LoadTextIcon extends WeatherState {
  String textIcon;
  LoadTextIcon(this.textIcon);
}
