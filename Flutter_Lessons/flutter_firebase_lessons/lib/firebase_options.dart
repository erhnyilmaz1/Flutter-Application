// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBfb6C2JEzogtOsXBpUIA360wWNWBngwR4',
    appId: '1:769146809044:web:8de15a09629f71a6046941',
    messagingSenderId: '769146809044',
    projectId: 'flutter-firebase-lessons-fa3e4',
    authDomain: 'flutter-firebase-lessons-fa3e4.firebaseapp.com',
    storageBucket: 'flutter-firebase-lessons-fa3e4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbX8_2F6GndJBjG1Xwal7PpHbp6pqxYYI',
    appId: '1:769146809044:android:a1a407d5fd6fc11d046941',
    messagingSenderId: '769146809044',
    projectId: 'flutter-firebase-lessons-fa3e4',
    storageBucket: 'flutter-firebase-lessons-fa3e4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEzGrv8yNrHiCHUe7Hs9e5WvnNuTyzxyc',
    appId: '1:769146809044:ios:f194aefedb1c40ca046941',
    messagingSenderId: '769146809044',
    projectId: 'flutter-firebase-lessons-fa3e4',
    storageBucket: 'flutter-firebase-lessons-fa3e4.appspot.com',
    iosClientId: '769146809044-ed63oek5cunjcivbvqt5j4eadb7qivsf.apps.googleusercontent.com',
    iosBundleId: 'com.erhanyilmaz.flutter',
  );
}
