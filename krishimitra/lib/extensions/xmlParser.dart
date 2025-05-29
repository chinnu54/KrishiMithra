// import 'package:xml/xml.dart';
//
// Map<String, String> parseCityCodes(String xmlString) {
//   final document = XmlDocument.parse(xmlString);
//   final cities = document.findAllElements('city');
//   Map<String, String> districtCityCodes = {};
//
//   for (final city in cities) {
//     final district = city.findElements('district').single.text;
//     final code = city.findElements('code').single.text;
//     districtCityCodes[district] = code;
//   }
//   return districtCityCodes;
// }


import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart' as xml;

Future<String?> getCityCode(String district, String cityName) async {
  try {
    // Load the XML string from the assets
    final xmlString = await rootBundle.loadString('lib/data/cityCodes.xml');

    // Parse the XML
    final document = xml.XmlDocument.parse(xmlString);

    // Search for the city node matching the district and city name
    final cityElements = document.findAllElements('city');

    for (var city in cityElements) {
      final cityDistrict = city.findElements('district').single.text;
      final cityNameValue = city.findElements('name').single.text;

      if (cityDistrict == district ){//&& cityNameValue == cityName) {
        return city.findElements('code').single.text; // Return the city code
      }
    }

    // If no match found, return null
    return null;

  } catch (e) {
    print('Error loading city codes: $e');
    return null;
  }
}
