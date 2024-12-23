import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/weather_data.dart';
// Model for weather data

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMotorOn = false; // Motor control state
  bool isLoading = true; // Loading indicator for weather data
  List<WeatherData> weatherDataList = []; // List of weather data

  @override
  void initState() {
    super.initState();
    fetchWeatherData(); // Fetch weather data when widget loads
  }

  // Fetch weather data from API
  Future<void> fetchWeatherData() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(
        Uri.parse('https://7-days-weather-forecast-imd-production.up.railway.app/43181'),
      );
      print(response.body); // Log the raw response for debugging
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        // print(response.body);
        setState(() {
          weatherDataList = jsonData
              .map((data) => WeatherData.fromJson(data))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load weather data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Irrigation Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchWeatherData, // Refresh weather data on pull
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildControlCard(),
              SizedBox(height: 16),
              _buildWeatherCard(),
              SizedBox(height: 16),
              _buildCropCard(),
              SizedBox(height: 16),
              _buildDiseaseCard(),
              SizedBox(height: 16),
              _buildMarketCard(),
              SizedBox(height: 16),
              _buildSchemesCard(),
            ],
          ),
        ),
      ),
    );
  }

  // Motor Control Card
  Widget _buildControlCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Motor Control',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Motor Status: ${isMotorOn ? "ON" : "OFF"}'),
                Switch(
                  value: isMotorOn,
                  onChanged: (value) => setState(() => isMotorOn = value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Weather Forecast Card
  Widget _buildWeatherCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: fetchWeatherData,
                ),
              ],
            ),
            SizedBox(height: 10),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (weatherDataList.isEmpty)
              Center(child: Text('No weather data available'))
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: weatherDataList.map((weather) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: WeatherDayCard(weather: weather),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Weather Day Card Widget
  Widget WeatherDayCard({required WeatherData weather}) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            weather.date,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.thermostat, size: 16),
              SizedBox(width: 4),
              Text('${weather.maxTemp}° / ${weather.minTemp}°'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.cloud, size: 16),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  weather.weatherDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Crop Recommendations Card
  Widget _buildCropCard() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.agriculture),
        title: Text('Recommended Crops'),
        subtitle: Text('Based on soil and weather conditions'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to crop recommendation details
        },
      ),
    );
  }

  // Disease Detection Card
  Widget _buildDiseaseCard() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.bug_report),
        title: Text('Disease Detection'),
        subtitle: Text('Detect plant diseases using camera'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to disease detection feature
        },
      ),
    );
  }

  // Market Prices Card
  Widget _buildMarketCard() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text('Market Prices'),
        subtitle: Text('View live crop market rates'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to market price details
        },
      ),
    );
  }

  // Government Schemes Card
  Widget _buildSchemesCard() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.policy),
        title: Text('Government Schemes'),
        subtitle: Text('Explore government benefits and programs'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to schemes information details
        },
      ),
    );
  }
}
