import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../utils/constants.dart';
import 'dart:async';

class ApiService {
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  /// Fetch current weather by city name.
  /// unit should be 'metric' or 'imperial'.
  Future<Weather> fetchWeatherByCity(String city, String unit) async {
    final url = Uri.parse("$baseUrl?q=$city&units=$unit&appid=${AppConfig.weatherApiKey}");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Weather.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception("City not found");
      } else if (response.statusCode == 401) {
        throw Exception("Invalid API key");
      } else {
        throw Exception("Failed to fetch weather (code: ${response.statusCode})");
      }
    } on SocketException {
      throw Exception("No Internet Connection");
    } on http.ClientException {
      throw Exception("Network error");
    } on FormatException {
      throw Exception("Bad response format");
    } on TimeoutException {
      throw Exception("Request timeout");
    } catch (e) {
      throw Exception(e.toString());
}
}
}