abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {
  String cityName;
  GetWeather(this.cityName);
}

class GetTextIcon extends WeatherEvent {
  GetTextIcon();
}
