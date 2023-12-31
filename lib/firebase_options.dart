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
    apiKey: 'AIzaSyDBmQACqKskbugYfqPA42Sq4hI_9wvS2NE',
    appId: '1:521345155135:web:fb7d3b6ca49f6ace31b88a',
    messagingSenderId: '521345155135',
    projectId: 'loggin-1d263',
    authDomain: 'loggin-1d263.firebaseapp.com',
    storageBucket: 'loggin-1d263.appspot.com',
    measurementId: 'G-NZDZ4EFZVG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjB-uZmyJd5s43DzJBbDZr9sH-C1So1Ys',
    appId: '1:521345155135:android:36ff5eb05a5aaf8431b88a',
    messagingSenderId: '521345155135',
    projectId: 'loggin-1d263',
    storageBucket: 'loggin-1d263.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOw4hVyoBXRfAgjB3r4Q3PxYJjUqgkf_w',
    appId: '1:521345155135:ios:307ec5332efdf89e31b88a',
    messagingSenderId: '521345155135',
    projectId: 'loggin-1d263',
    storageBucket: 'loggin-1d263.appspot.com',
    iosBundleId: 'com.example.proyectoChistes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOw4hVyoBXRfAgjB3r4Q3PxYJjUqgkf_w',
    appId: '1:521345155135:ios:541347d1bf13427431b88a',
    messagingSenderId: '521345155135',
    projectId: 'loggin-1d263',
    storageBucket: 'loggin-1d263.appspot.com',
    iosBundleId: 'com.example.proyectoChistes.RunnerTests',
  );
}
