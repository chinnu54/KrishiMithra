import 'dart:convert';
import '../Constants/contants.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

class NewsService {
  // Replace YOUR_NEWSAPI_KEY with your News API key
  // final String newsAPIKey = "345ec4ee0a6047ec96a200c295c6dcb2";
  // final String newsAPIBaseURL = "https://newsapi.org/v2/";
  // final String newsAPIEndPoint = "everything";

  // Method to fetch news from News API
  Future<Map<String, dynamic>> fetchNews(int page) async {
    try {
      final Uri url = Uri.parse(
          '$newsAPIBaseURL$newsAPIEndPoint?q=farmers&sortBy=popularity&apiKey=$newsAPIKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 502) {
        throw Exception('No Internet Connection');
      } else {
        throw Exception('Failed to load latest news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}