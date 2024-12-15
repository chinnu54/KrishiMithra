import 'package:flutter/material.dart';
import 'irrigation_screen.dart';
import 'disease_detection_screen.dart';
import 'market_prices_screen.dart';
import 'schemes_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Irrigation System')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildFeatureButton(
            context,
            'Irrigation',
            Icons.water_drop,
            IrrigationScreen(),
          ),
          _buildFeatureButton(
            context,
            'Disease Detection',
            Icons.bug_report,
            DiseaseDetectionScreen(),
          ),
          _buildFeatureButton(
            context,
            'Market Prices',
            Icons.attach_money,
            MarketPricesScreen(),
          ),
          _buildFeatureButton(
            context,
            'Schemes',
            Icons.account_balance,
            SchemesScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureButton(BuildContext context, String title, IconData icon, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
