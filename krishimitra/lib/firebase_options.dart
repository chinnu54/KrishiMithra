import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5nMv2BiENC5qU1qip2_spb-dkojP81gk',
    appId: '1:387445354998:android:265f0e64828ee6aa0a57d7',
    messagingSenderId: '387445354998',
    projectId: 'krishmitra-1de83',
    storageBucket: 'krishmitra-1de83.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA5nMv2BiENC5qU1qip2_spb-dkojP81gk',
    appId: '1:387445354998:web:YOUR_WEB_APP_ID', // You'll need to add your web app ID
    messagingSenderId: '387445354998',
    projectId: 'krishmitra-1de83',
    storageBucket: 'krishmitra-1de83.firebasestorage.app',
    authDomain: 'krishmitra-1de83.firebaseapp.com',
  );
}
