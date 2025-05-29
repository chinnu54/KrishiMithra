// lib/services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseWeatherUrl = 'https://7-days-weather-forecast-imd-production.up.railway.app';
  static const String baseMarketUrl = 'http://real-time-market-prices-production.up.railway.app';

  static Future<List<dynamic>> getWeatherForecast(String id) async {
    final response = await http.get(Uri.parse('$baseWeatherUrl/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load weather data');
  }

  static Future<List<dynamic>> getMarketPrices(String state, String cropName) async {
    final response = await http.get(Uri.parse('$baseMarketUrl/$state/$cropName'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load market prices');
  }

  static Future<bool> login(String email, String password) async {
    // Implement your login API call here
    return true; // Temporary return for demonstration
  }

  static Future<bool> signup(Map<String, String> userData) async {
    // Implement your signup API call here
    return true; // Temporary return for demonstration
  }
}
