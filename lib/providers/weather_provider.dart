import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';
import '../services/api_services.dart';

class WeatherProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  Weather? _weather;
  bool _isLoading = false;
  String? _error;
  List<String> _favorites = [];
  List<String> _searchHistory = [];
  String _unit = 'metric'; // default metric (°C)

  // Getters
  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get favorites => List.unmodifiable(_favorites);
  List<String> get searchHistory => List.unmodifiable(_searchHistory);
  String get unit => _unit;

  WeatherProvider() {
    _loadFavorites();
    _loadHistory();
  }

  // set loading and notify
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // change unit and notify
  void changeUnit(String newUnit) {
    if (newUnit == 'metric' || newUnit == 'imperial') {
      _unit = newUnit;
      notifyListeners();
    }
  }

  // add to search history (avoid duplicates)
  Future<void> addToHistory(String city) async {
    city = city.trim();
    if (city.isEmpty) return;
    _searchHistory.remove(city);
    _searchHistory.insert(0, city);
    if (_searchHistory.length > 10) _searchHistory = _searchHistory.sublist(0, 10);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', _searchHistory);
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory = prefs.getStringList('searchHistory') ?? [];
    notifyListeners();
  }

  // fetch weather, update state
  Future<void> getWeather(String city) async {
    city = city.trim();
    if (city.isEmpty) {
      _error = "Please enter a city";
      notifyListeners();
      return;
    }

    setLoading(true);
    _error = null;

    try {
      await addToHistory(city);
      final result = await _apiService.fetchWeatherByCity(city, _unit);
      _weather = result;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _weather = null;
    } finally {
      setLoading(false);
    }
  }

  // Favorites (persist using SharedPreferences)
  Future<void> addFavorite(String city) async {
    city = city.trim();
    if (city.isEmpty) return;
    if (!_favorites.contains(city)) {
      _favorites.add(city);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('favorites', _favorites);
    }
  }

  Future<void> removeFavorite(String city) async {
    _favorites.remove(city);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
}
}