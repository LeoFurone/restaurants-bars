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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC25Mox7hz9cKpFfPrUPSOrINBOKfi263M',
    appId: '1:870232728617:web:89923daf5c4d6e309a6838',
    messagingSenderId: '870232728617',
    projectId: 'restaurants-bars',
    authDomain: 'restaurants-bars.firebaseapp.com',
    storageBucket: 'restaurants-bars.appspot.com',
    measurementId: 'G-45B2SMD595',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChrU_iZU9TQ3UxwkjgGyUPwPj6A4YaAZs',
    appId: '1:870232728617:android:b55d0bd1674c41c69a6838',
    messagingSenderId: '870232728617',
    projectId: 'restaurants-bars',
    storageBucket: 'restaurants-bars.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyOiBp0b3fwYoOUhlgmv_mW-iXW2GZdP8',
    appId: '1:870232728617:ios:bb01b9382e9e84df9a6838',
    messagingSenderId: '870232728617',
    projectId: 'restaurants-bars',
    storageBucket: 'restaurants-bars.appspot.com',
    iosClientId: '870232728617-4mrclhcc2h2kvv9k7jao845395b9rb3h.apps.googleusercontent.com',
    iosBundleId: 'br.com.taquainfo',
  );
}
