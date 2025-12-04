import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/favourite_title.dart';
import 'weather_details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: provider.favorites.isEmpty
          ? const Center(child: Text('No favorite cities added'))
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final city = provider.favorites[index];
                return FavoriteTile(
                  city: city,
                  onDelete: () => provider.removeFavorite(city),
                  onTap: () async {
                    provider.setLoading(true);
                    await provider.getWeather(city);
                    provider.setLoading(false);

                    if (provider.weather != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => WeatherDetailsPage(weather: provider.weather!)),
                      );
                    } else if (provider.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.error!)));
                    }
                  },
                );
              },
           ),
);
}
}