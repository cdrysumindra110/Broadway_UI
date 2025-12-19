class WeatherBrain {
  String getWeatherIcon(int cod) {
    if (cod == 200 || cod == 201) {
      return '⛈️'; // Thunderstorm
    } else if (cod == 800) {
      return '🌞'; // Clear sky
    } else if (cod == 801 || cod == 802) {
      return '🌤️'; // Few clouds
    } else if (cod == 803 || cod == 804) {
      return '☁️'; // Cloudy
    } else if (cod == 500 || cod == 501) {
      return '🌧️'; // Light rain
    } else if (cod == 502 || cod == 503) {
      return '🌧️'; // Heavy rain
    } else if (cod == 300 || cod == 301) {
      return '🌦️'; // Drizzle
    } else if (cod == 600 || cod == 601) {
      return '❄️'; // Snow
    } else {
      return '🌫️';
    }
  }

  String getWeatherText(int cod) {
    if (cod == 200 || cod == 201) {
      return 'There is a thunderstorm!';
    } else if (cod == 800) {
      return 'Clear sky!';
    } else if (cod == 801 || cod == 802) {
      return 'A few clouds.';
    } else if (cod == 803 || cod == 804) {
      return 'It\'s cloudy.';
    } else if (cod == 500 || cod == 501) {
      return 'It\'s raining lightly.';
    } else if (cod == 502 || cod == 503) {
      return 'It\'s raining heavily!';
    } else if (cod == 300 || cod == 301) {
      return 'It\'s drizzling.';
    } else if (cod == 600 || cod == 601) {
      return 'It\'s snowing!';
    } else {
      return 'Weather condition unknown.';
    }
  }
}
