# Weather App (Flutter)

## Description
Multi-page Flutter app using OpenWeatherMap Current Weather API. Search cities, view details, save favorites, change units.

## Features
- Search by city
- Weather details: temp, description, feels like, humidity, wind, sunrise/sunset, local time
- Favorites (persistent with shared_preferences)
- Settings: metric / imperial
- Search history
- Error handling (invalid city, API errors, no internet)

## Setup
1. Clone repository:
   ```bash
   git clone https://github.com/your-username/weather_app.git
   cd weather_app

 2. Install packeges
 flutter pub get

 3.	Add API key:
	•	Copy lib/config/constants.example.dart → lib/config/constants.dart
	•	Edit lib/config/constants.dart and set:
    class AppConfig {
  static const String weatherApiKey = "YOUR_REAL_API_KEY";
}

4. Run app :
flutter run

5. Build APK
flutter build apk --release
# APK at build/app/outputs/flutter-apk/app-release.apk