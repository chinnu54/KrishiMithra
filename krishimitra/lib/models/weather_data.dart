// class WeatherData {
//   final String date;
//   final String minTemp;
//   final String maxTemp;
//   final String weatherDescription;
//
//   WeatherData({
//     required this.date,
//     required this.minTemp,
//     required this.maxTemp,
//     required this.weatherDescription,
//   });
//
//   // Map the JSON response keys to match the model properties
//   factory WeatherData.fromJson(Map<String, dynamic> json) {
//     return WeatherData(
//       date: json['Date'] ?? '',
//       minTemp: json['Minimum Temperature']?.toString() ?? '',
//       maxTemp: json['Maximum Temperature']?.toString() ?? '',
//       weatherDescription: json['Weather Description'] ?? '',
//     );
//   }
// }
class WeatherForecast {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String description;

  WeatherForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: json['Date'],
      minTemp: json['Minimum Temperature'],
      maxTemp: json['Maximum Temperature'],
      description: json['Weather Description'],
    );
  }
}