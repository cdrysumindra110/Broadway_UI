abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {
  String cityName;
  GetWeather(this.cityName);
}

class GetCurrentWeather extends WeatherEvent {}

class GetTextIcon extends WeatherEvent {
  GetTextIcon();
}
