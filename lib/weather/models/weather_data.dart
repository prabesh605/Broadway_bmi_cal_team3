class WeatherModel {
  final String city;
  final String country;
  final String description;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final int visibility;
  final int cloudCover;
  final double windSpeed;
  final int windDeg;
  final String icon;

  WeatherModel({
    required this.city,
    required this.country,
    required this.description,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.cloudCover,
    required this.windSpeed,
    required this.windDeg,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] as String,
      country: json['sys']['country'] as String,
      description: json['weather'][0]['description'] as String,
      temp: (json['main']['temp']).toDouble() - 273.15,
      feelsLike: (json['main']['feels_like']).toDouble() - 273.15,
      tempMin: (json['main']['temp_min']).toDouble() - 273.15,
      tempMax: (json['main']['temp_max']).toDouble() - 273.15,
      humidity: json['main']['humidity'] as int,
      pressure: json['main']['pressure'] as int,
      visibility: json['visibility'] as int,
      cloudCover: json['clouds']['all'] as int,
      windSpeed: (json['wind']['speed']).toDouble(),
      windDeg: json['wind']['deg'] as int,
      icon: json['weather'][0]['icon'] as String,
    );
  }
}
