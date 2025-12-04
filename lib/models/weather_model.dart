// Simple model mapping fields we need from OpenWeatherMap current weather response.
class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int sunrise; // unix UTC
  final int sunset;  // unix UTC
  final String icon;
  final int timezone; // offset in seconds

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.icon,
    required this.timezone,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      temperature: (json['main']?['temp'] ?? 0).toDouble(),
      description: (json['weather'] != null && json['weather'].isNotEmpty)
          ? json['weather'][0]['description']
          : 'No description',
      feelsLike: (json['main']?['feels_like'] ?? 0).toDouble(),
      humidity: (json['main']?['humidity'] ?? 0).toInt(),
      windSpeed: (json['wind']?['speed'] ?? 0).toDouble(),
      sunrise: (json['sys']?['sunrise'] ?? 0).toInt(),
      sunset: (json['sys']?['sunset'] ?? 0).toInt(),
      icon: (json['weather'] != null && json['weather'].isNotEmpty)
          ? json['weather'][0]['icon']
          : '01d',
      timezone: (json['timezone'] ?? 0).toInt(),
);
}
}