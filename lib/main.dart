import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'pages/home_page.dart';
import 'pages/favorite_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/favorites': (context) => const FavoritesPage(),
        '/settings': (context) =>  SettingsPage(),
     },
);
}
}