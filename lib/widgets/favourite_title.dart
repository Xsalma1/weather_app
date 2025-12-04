import 'package:flutter/material.dart';

class FavoriteTile extends StatelessWidget {
  final String city;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const FavoriteTile({
    super.key,
    required this.city,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        title: Text(city, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
     ),
);
}
}