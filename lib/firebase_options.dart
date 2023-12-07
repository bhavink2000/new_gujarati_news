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
    apiKey: 'AIzaSyCFA3c-r97JMB3gP2m9LqVuCffHJB7iQc0',
    appId: '1:148030468037:web:174b7de39c9927d74a65ac',
    messagingSenderId: '148030468037',
    projectId: 'new-gujarati-news',
    authDomain: 'new-gujarati-news.firebaseapp.com',
    storageBucket: 'new-gujarati-news.appspot.com',
    measurementId: 'G-WD67D3CHS8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIDaDW_r0_P_b09kTQKYNICtY0WyVUa18',
    appId: '1:148030468037:android:92f071abc6fc2ff24a65ac',
    messagingSenderId: '148030468037',
    projectId: 'new-gujarati-news',
    storageBucket: 'new-gujarati-news.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDq8NqNl-Uu9IeinnNcqtZA1Bjjr4z3oFs',
    appId: '1:148030468037:ios:79bda9c320af01044a65ac',
    messagingSenderId: '148030468037',
    projectId: 'new-gujarati-news',
    storageBucket: 'new-gujarati-news.appspot.com',
    iosBundleId: 'com.example.newGujaratiNews',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDq8NqNl-Uu9IeinnNcqtZA1Bjjr4z3oFs',
    appId: '1:148030468037:ios:79bda9c320af01044a65ac',
    messagingSenderId: '148030468037',
    projectId: 'new-gujarati-news',
    storageBucket: 'new-gujarati-news.appspot.com',
    iosBundleId: 'com.example.newGujaratiNews',
  );
}
