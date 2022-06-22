class WeatherModel {
  String? condition;
  dynamic temperature;
  dynamic feelsLike;
  dynamic pressure;
  dynamic visibility;
  String? humidity;
  dynamic windSpeed;
  String? country;
  String? name;
  String? icon;

  WeatherModel({
    this.condition,
    this.temperature,
    this.feelsLike,
    this.pressure,
    this.visibility,
    this.humidity,
    this.windSpeed,
    this.country,
    this.name,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'condition': condition,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'pressure': pressure,
      'visibility': visibility,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'country': country,
      'name': name,
      'icon': icon,
    };
    return map;
  }

  WeatherModel.fromMap(Map<String, dynamic> map) {
    condition = map['condition'];
    temperature = map['temperature'];
    feelsLike = map['feelsLike'];
    pressure = map['pressure'];
    visibility = map['visibility'];
    humidity = map['humidity'];
    windSpeed = map['windSpeed'];
    country = map['country'];
    name = map['name'];
    icon = map['icon'];
  }

  String toJson() {
    String str = '{';
    //str += '"id" : "$id",';
    if (condition != null) str += '"condition" : "$condition",';

    if (temperature != null) str += '"temperature" : "$temperature",';

    if (feelsLike != null) str += '"feelsLike" : "$feelsLike",';

    if (pressure != null) str += '"pressure" : "$pressure",';

    if (visibility != null) str += '"visibility" : "$visibility",';

    if (humidity != null) str += '"humidity" : "$humidity",';

    if (windSpeed != null) str += '"windSpeed" : "$windSpeed",';

    if (country != null) str += '"country" : "$country",';

    if (name != null) str += '"name" : "$name",';

    if (icon != null) str += '"icon" : "$icon",';
    str += '}';
    return str;
  }

  WeatherModel.fromJson(Map<dynamic, dynamic> map) {
    condition = map['weather'][0]['main'];
    temperature = (map['main']['temp']).round();
    feelsLike = (map['main']['feels_like']).round();
    pressure = (map['main']['pressure']);
    visibility = (map['visibility'] / 1000).round();
    humidity = map['main']['humidity'].toString();
    windSpeed = (map['wind']['speed'] * 3.6);
    country = map['sys']['country'];
    name = map['name'];
    icon = map['weather'][0]['icon'];
  }
}
