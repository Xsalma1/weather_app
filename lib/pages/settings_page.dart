import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Temperature Unit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RadioListTile(
              title: Text('Celsius (°C)'),
              value: 'metric',
              groupValue: provider.unit,
              onChanged: (value) => provider.changeUnit(value.toString()),
            ),
            RadioListTile(
              title: Text('Fahrenheit (°F)'),
              value: 'imperial',
              groupValue: provider.unit,
              onChanged: (value) => provider.changeUnit(value.toString()),
            ),
            SizedBox(height: 20),
            Text('Other Settings (Optional)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: Text('Use GPS Location (Not Implemented)'),
              value: false,
              onChanged: (value) {
                // هنا ممكن تضيفي GPS لاحقاً
              },
            ),
          ],
        ),
     ),
);
}
}