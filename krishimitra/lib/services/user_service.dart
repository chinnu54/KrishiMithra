// services/user_preferences.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPreferences {
  static const String KEY_USER_DETAILS = 'user_details';

  // Save user details
  static Future<bool> saveUserDetails(UserDetails userDetails) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String userJson = json.encode(userDetails.toJson()); // Using toJson
      return await prefs.setString(KEY_USER_DETAILS, userJson);
    } catch (e) {
      print('Error saving user details: $e');
      return false;
    }
  }

  // Get user details
  static Future<UserDetails?> getUserDetails() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userJson = prefs.getString(KEY_USER_DETAILS);

      if (userJson != null) {
        final Map<String, dynamic> userMap = json.decode(userJson);
        return UserDetails.fromJson(userMap); // Using fromJson
      }
      return null;
    } catch (e) {
      print('Error getting user details: $e');
      return null;
    }
  }

  // Clear user details
  static Future<bool> clearUserDetails() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.remove(KEY_USER_DETAILS);
    } catch (e) {
      print('Error clearing user details: $e');
      return false;
    }
  }

  // Check if user details exist
  static Future<bool> hasUserDetails() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(KEY_USER_DETAILS);
    } catch (e) {
      print('Error checking user details: $e');
      return false;
    }
  }


  Future<void> logout() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      print("User successfully logged out");
      // You can navigate to the login page or perform other actions here
    } catch (e) {
      print("Error while logging out: ${e.toString()}");
    }
  }

}
