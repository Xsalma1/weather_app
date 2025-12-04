import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';
import 'weather_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  void _search(WeatherProvider provider, String city) async {
    await provider.getWeather(city);
    if (provider.weather != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => WeatherDetailsPage(weather: provider.weather!)),
      );
    } else if (provider.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.error!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Field
            TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => _search(provider, value),
              decoration: InputDecoration(
                labelText: 'Search City',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _search(provider, _controller.text),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Search history chips
            if (provider.searchHistory.isNotEmpty) SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final c = provider.searchHistory[index];
                  return ActionChip(
                    label: Text(c),
                    onPressed: () {
                      _controller.text = c;
                      _search(provider, c);
                    },
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: provider.searchHistory.length,
              ),
            ),

            const SizedBox(height: 12),

            // Loading indicator or weather card preview
            if (provider.isLoading)
              const CircularProgressIndicator()
            else if (provider.weather != null)
              WeatherCard(
                weather: provider.weather!,
                unit: provider.unit,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WeatherDetailsPage(weather: provider.weather!)),
                  );
                },
              )
            else
              const Expanded(child: Center(child: Text('Search for a city to see weather', style: TextStyle(fontSize: 16)))),
          ],
        ),
     ),
);
}
}