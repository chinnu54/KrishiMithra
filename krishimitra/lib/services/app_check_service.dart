import 'package:firebase_app_check/firebase_app_check.dart';

class AppCheckService {
  static Future<void> initialize() async {
    await FirebaseAppCheck.instance.activate(
      // webRecaptchaSiteKey: 'your-recaptcha-key', // for web
    );

    // For debug mode
    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  }
}
