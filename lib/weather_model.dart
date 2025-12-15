class WeatherModel {
  final double temp;
  final int humidity;
  final double speed;
  WeatherModel({
    required this.temp,
    required this.humidity,
    required this.speed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp'],
      humidity: json['main']['humidity'],
      speed: json['wind']['speed'],
    );
  }
}
