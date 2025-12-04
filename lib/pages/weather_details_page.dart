import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';

class WeatherDetailsPage extends StatelessWidget {
  final Weather weather;
  const WeatherDetailsPage({super.key, required this.weather});

  String _formatTime(int timestamp, int offset) {
    final date = DateTime.fromMillisecondsSinceEpoch((timestamp + offset) * 1000, isUtc: true);
    return DateFormat.jm().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final isFavorite = provider.favorites.contains(weather.cityName);

    // handle error states (example)
    if (provider.error != null && provider.error!.contains("No Internet")) {
      return Scaffold(
        appBar: AppBar(title: Text(weather.cityName)),
        body: const Center(child: Text('No Internet Connection', style: TextStyle(color: Colors.red, fontSize: 18))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(weather.cityName),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              if (isFavorite) {
                provider.removeFavorite(weather.cityName);
              } else {
                provider.addFavorite(weather.cityName);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Center(
              child: Image.network(
                'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
                width: 120,
                height: 120,
                errorBuilder: (_, __, ___) => const Icon(Icons.cloud, size: 80),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '${weather.temperature.toStringAsFixed(1)} °${provider.unit == 'metric' ? 'C' : 'F'}',
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 6),
            Center(child: Text(weather.description, style: const TextStyle(fontSize: 20))),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoTile('Feels like', '${weather.feelsLike.toStringAsFixed(1)}°'),
                _infoTile('Humidity', '${weather.humidity}%'),
                _infoTile('Wind', '${weather.windSpeed} m/s'),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoTile('Sunrise', _formatTime(weather.sunrise, weather.timezone)),
                _infoTile('Sunset', _formatTime(weather.sunset, weather.timezone)),
              ],
            ),
            const SizedBox(height: 12),
            Center(child: Text('Local time: ${DateFormat.jm().format(DateTime.now().toUtc().add(Duration(seconds: weather.timezone)))}')),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(value),
     ],
);
}
}