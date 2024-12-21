import 'package:flutter/material.dart';

class MarketPricesScreen extends StatelessWidget {
  final List<Map<String, String>> marketPrices = [
    {'Crop': 'Wheat', 'Price': '₹20/kg'},
    {'Crop': 'Rice', 'Price': '₹25/kg'},
    {'Crop': 'Tomatoes', 'Price': '₹30/kg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Market Prices')),
      body: ListView.builder(
        itemCount: marketPrices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(marketPrices[index]['Crop']!),
            subtitle: Text(marketPrices[index]['Price']!),
          );
        },
      ),
    );
  }
}
