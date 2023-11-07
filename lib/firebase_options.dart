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
    apiKey: 'AIzaSyD0kuosyiiQpmXP3XH-LmmQIHwdkbt0g4A',
    appId: '1:1068985836820:web:385807541cf0cffd550e01',
    messagingSenderId: '1068985836820',
    projectId: 'unifind-83bba',
    authDomain: 'unifind-83bba.firebaseapp.com',
    storageBucket: 'unifind-83bba.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD63uo5aslxa_tTUJ3jl_7G9srPswqCFq8',
    appId: '1:1068985836820:android:4de838599b2ba05c550e01',
    messagingSenderId: '1068985836820',
    projectId: 'unifind-83bba',
    storageBucket: 'unifind-83bba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYEuJKOrsJoJsrR4q1fPXYQKYLDGcja7U',
    appId: '1:1068985836820:ios:4a36e990d23eb61f550e01',
    messagingSenderId: '1068985836820',
    projectId: 'unifind-83bba',
    storageBucket: 'unifind-83bba.appspot.com',
    iosBundleId: 'com.example.unifind',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYEuJKOrsJoJsrR4q1fPXYQKYLDGcja7U',
    appId: '1:1068985836820:ios:8920339f46a37754550e01',
    messagingSenderId: '1068985836820',
    projectId: 'unifind-83bba',
    storageBucket: 'unifind-83bba.appspot.com',
    iosBundleId: 'com.example.unifind.RunnerTests',
  );
}
