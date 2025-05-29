import 'package:flutter/material.dart';

class SchemesScreen extends StatelessWidget {
  final List<String> schemes = [
    'PM Kisan Samman Nidhi',
    'Soil Health Card Scheme',
    'Kisan Credit Card',
    'Crop Insurance Scheme',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Government Schemes')),
      body: ListView.builder(
        itemCount: schemes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(schemes[index]),
          );
        },
      ),
    );
  }
}
