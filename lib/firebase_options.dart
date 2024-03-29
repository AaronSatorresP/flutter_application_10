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
    apiKey: 'AIzaSyDQBNlB7fPGBJZPce2Bdp7hNvN5Q49UFjc',
    appId: '1:315043670750:web:37b506805f0291bb6af04f',
    messagingSenderId: '315043670750',
    projectId: 'fir-flutter-7407b',
    authDomain: 'fir-flutter-7407b.firebaseapp.com',
    storageBucket: 'fir-flutter-7407b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUUIPcVef-g3rzqNZFSTKPPhiN2-PdiFk',
    appId: '1:315043670750:android:4697950a8f37b9de6af04f',
    messagingSenderId: '315043670750',
    projectId: 'fir-flutter-7407b',
    storageBucket: 'fir-flutter-7407b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfRw56u4VqSLR2-KBteZkXCKXcXJ8SOVs',
    appId: '1:315043670750:ios:32164268f95755b56af04f',
    messagingSenderId: '315043670750',
    projectId: 'fir-flutter-7407b',
    storageBucket: 'fir-flutter-7407b.appspot.com',
    iosBundleId: 'com.example.flutterApplication10',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfRw56u4VqSLR2-KBteZkXCKXcXJ8SOVs',
    appId: '1:315043670750:ios:0c847e3259c3ff8b6af04f',
    messagingSenderId: '315043670750',
    projectId: 'fir-flutter-7407b',
    storageBucket: 'fir-flutter-7407b.appspot.com',
    iosBundleId: 'com.example.flutterApplication10.RunnerTests',
  );
}
