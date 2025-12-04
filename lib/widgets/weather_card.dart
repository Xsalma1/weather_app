import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final VoidCallback onTap;
  final String unit;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.onTap,
    this.unit = 'metric',
  });

  String _formatTime(int timestamp, int offset) {
    final date = DateTime.fromMillisecondsSinceEpoch((timestamp + offset) * 1000, isUtc: true);
    return DateFormat.jm().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        onTap: onTap,
        leading: Image.network(
          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
          width: 56,
          height: 56,
          errorBuilder: (_, __, ___) => const Icon(Icons.cloud, size: 48, color: Colors.grey),
        ),
        title: Text(weather.cityName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text('${weather.description} • ${weather.temperature.toStringAsFixed(1)} °${unit == 'metric' ? 'C' : 'F'}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Feels: ${weather.feelsLike.toStringAsFixed(1)}°'),
            const SizedBox(height: 4),
            Text('Hum: ${weather.humidity}%'),
          ],
        ),
     ),
);
}
}