// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAdlZN9Fz-cD7-KG7NYGom4g4DDOwabKKQ',
    appId: '1:1076846971874:web:79afadd2164c7d5a0d47bb',
    messagingSenderId: '1076846971874',
    projectId: 'every-calendar-2cc3e',
    authDomain: 'every-calendar-2cc3e.firebaseapp.com',
    storageBucket: 'every-calendar-2cc3e.appspot.com',
    measurementId: 'G-FB39VSE32C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzm1URteaNkhjuE-32DAx1c7Hyovg6Kiw',
    appId: '1:1076846971874:android:6b3909705aa9b9220d47bb',
    messagingSenderId: '1076846971874',
    projectId: 'every-calendar-2cc3e',
    storageBucket: 'every-calendar-2cc3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2nh4rYzoSERpoHCfrLzlyaB2FB1_yY4o',
    appId: '1:1076846971874:ios:4e71dc399a591c360d47bb',
    messagingSenderId: '1076846971874',
    projectId: 'every-calendar-2cc3e',
    storageBucket: 'every-calendar-2cc3e.appspot.com',
    iosBundleId: 'com.example.calendarEvery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2nh4rYzoSERpoHCfrLzlyaB2FB1_yY4o',
    appId: '1:1076846971874:ios:3a5ab36687aad5000d47bb',
    messagingSenderId: '1076846971874',
    projectId: 'every-calendar-2cc3e',
    storageBucket: 'every-calendar-2cc3e.appspot.com',
    iosBundleId: 'com.example.calendarEvery.RunnerTests',
  );
}
