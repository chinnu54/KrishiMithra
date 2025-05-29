import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherScreen extends StatefulWidget {
  final String cityCode;
  final String cityName;

  const WeatherScreen({
    Key? key,
    required this.cityCode,
    required this.cityName,
  }) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<WeatherForecast> _forecasts = [];
  bool _isLoading = true;
  String _error = '';
  Map<String, dynamic>? _currentWeather;

  final String openWeatherApiKey = '';

  @override
  void initState() {
    super.initState();
    _fetchBothWeatherData();
  }

  Future<void> _fetchBothWeatherData() async {
    await Future.wait([
      _fetchCurrentWeather(),
      _fetchWeatherData(),
    ]);
  }

  Future<void> _fetchCurrentWeather() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName},in&appid=$openWeatherApiKey&units=metric'
      ));

      if (response.statusCode == 200) {
        setState(() {
          _currentWeather = json.decode(response.body);
        });
      }
    } catch (e) {
      print('Error fetching current weather: $e');
    }
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final response = await http.get(Uri.parse(
          'https://7-days-weather-forecast-imd-production.up.railway.app/${widget.cityCode}'
      ));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          _forecasts = jsonData.map((data) => WeatherForecast.fromJson(data)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load weather data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Widget _buildCurrentWeather() {
    if (_currentWeather == null) return const SizedBox.shrink();

    final temp = _currentWeather!['main']['temp'].toStringAsFixed(1);
    final humidity = _currentWeather!['main']['humidity'];
    final description = _currentWeather!['weather'][0]['description'];
    final windSpeed = _currentWeather!['wind']['speed'];

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.cityName} లో ప్రస్తుత వాతావరణం',//\nCurrent Weather in ${widget.cityName}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$temp°C',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                _getWeatherIcon(description),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(Icons.water_drop, '$humidity%', 'Humidity'),
                _buildWeatherInfo(Icons.air, '${windSpeed} m/s', 'Wind'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.green),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _getWeatherIcon(String description) {
    String lowerDescription = description.toLowerCase();

    if (lowerDescription.contains('fog') || lowerDescription.contains('mist')) {
      return const Icon(FontAwesomeIcons.smog, size: 40, color: Colors.blueGrey); // For fog/mist
    } else if (lowerDescription.contains('haze')) {
      return const Icon(Icons.wb_cloudy_rounded, size: 40, color: Colors.orangeAccent); // For haze
    } else if (lowerDescription.contains('cloud') && lowerDescription.contains('partly')) {
      return const Icon(Icons.cloud_queue, size: 40, color: Colors.lightBlue); // For partly cloudy
    } else if (lowerDescription.contains('cloud')) {
      return const Icon(Icons.cloud, size: 40, color: Colors.blueGrey); // For general cloudy
    } else if (lowerDescription.contains('rain')) {
      return const Icon(FontAwesomeIcons.cloudShowersHeavy, size: 40, color: Colors.blue); // For rain
    } else if (lowerDescription.contains('snow') || lowerDescription.contains('snowy')) {
      return const Icon(Icons.ac_unit, size: 40, color: Colors.cyan); // For snow
    } else if (lowerDescription.contains('storm') || lowerDescription.contains('thunder') || lowerDescription.contains('lightning')) {
      return const Icon(FontAwesomeIcons.cloudBolt, size: 40, color: Colors.amber); // For storms or thunder
    } else if (lowerDescription.contains('sun') || lowerDescription.contains('clear')) {
      return const Icon(Icons.wb_sunny, size: 40, color: Colors.orangeAccent); // For sunny or clear
    } else if (lowerDescription.contains('cold') || lowerDescription.contains('freezing') || lowerDescription.contains('chilly')) {
      return const Icon(Icons.ac_unit, size: 40, color: Colors.lightBlue); // For cold/freezing conditions
    } else if (lowerDescription.contains('hot') || lowerDescription.contains('warm')) {
      return const Icon(Icons.wb_sunny, size: 40, color: Colors.yellow); // For hot or warm weather
    } else if (lowerDescription.contains('windy') || lowerDescription.contains('breeze')) {
      return const Icon(Icons.air, size: 40, color: Colors.green); // For windy or breezy conditions
    } else {
      return const Icon(Icons.help_outline, size: 40, color: Colors.grey); // Default icon for unrecognized weather
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'వాతావరణ సమాచారం',
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20,
            )),

        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
          ? Center(child: Text(_error))
          : SingleChildScrollView(
        child: Column(
          children: [
            _buildCurrentWeather(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '7-Day Forecast',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _forecasts.length,
              itemBuilder: (context, index) {
                final forecast = _forecasts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: _getWeatherIcon(forecast.description),
                    title: Text(forecast.date),
                    subtitle: Text(forecast.description),
                    trailing: Text(
                      '${forecast.minTemp}°C / ${forecast.maxTemp}°C',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
