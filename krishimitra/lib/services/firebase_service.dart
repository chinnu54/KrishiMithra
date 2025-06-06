import 'package:firebase_core/firebase_core.dart';
import 'app_check_service.dart';
import '../firebase_options.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await AppCheckService.initialize();
  }
}
