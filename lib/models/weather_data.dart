class WeatherData {
  final String date;
  final String minTemp;
  final String maxTemp;
  final String weatherDescription;

  WeatherData({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.weatherDescription,
  });

  // Map the JSON response keys to match the model properties
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: json['Date'] ?? '',
      minTemp: json['Minimum Temperature']?.toString() ?? '',
      maxTemp: json['Maximum Temperature']?.toString() ?? '',
      weatherDescription: json['Weather Description'] ?? '',
    );
  }
}
