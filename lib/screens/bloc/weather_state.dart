part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final FormzStatus status;
  final WeatherModel? weatherModel;

  const WeatherState({
    this.weatherModel,
    this.status = FormzStatus.pure,
  });

  WeatherState copyWith({
    WeatherModel? weatherModel,
    FormzStatus? status,
  }) {
    return WeatherState(
      weatherModel: weatherModel ?? this.weatherModel,
      status: status ?? this.status,
    );
  }

  @override
  List<dynamic> get props => [
        weatherModel,
        status,
      ];
}
