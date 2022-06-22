part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherDataFaced extends WeatherEvent {
  // const WeatherDataFaced(this.otpCode);
  //
  // final String otpCode;
  //
  // @override
  // List<Object> get props => [otpCode];
}
