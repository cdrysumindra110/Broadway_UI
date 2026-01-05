import 'package:broadway_example_ui/weather/weather_brain.dart';
import 'package:broadway_example_ui/weather/weather_event.dart';
import 'package:broadway_example_ui/weather/weather_model.dart';
import 'package:broadway_example_ui/weather/weather_service.dart';
import 'package:broadway_example_ui/weather/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherService service;
  WeatherBrain brain;
  String textIcon = '';
  WeatherModel? data;

  WeatherBloc(this.service, this.brain) : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      emit(WeatherLoading());
      data = await service.getWeather(event.cityName);

      textIcon = brain.getWeatherIcon(data!.cod);
      emit(WeatherLoaded(data!));
    });
    on<GetTextIcon>((event, emit) async {
      emit(WeatherLoading());

      textIcon = brain.getWeatherIcon(data!.cod);
      // emit(WeatherLoaded(data));
      emit(LoadTextIcon(textIcon));
      ;
    });
  }
}
