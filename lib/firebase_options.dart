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
    apiKey: 'AIzaSyDypqTnInU0XjkX5F8xt3x9Ou2hDtT38QI',
    appId: '1:95085555633:web:1b9b4d38a1e98b2a359790',
    messagingSenderId: '95085555633',
    projectId: 'rednotes-app',
    authDomain: 'rednotes-app.firebaseapp.com',
    databaseURL: 'https://rednotes-app-default-rtdb.firebaseio.com',
    storageBucket: 'rednotes-app.appspot.com',
    measurementId: 'G-ZFPDJBWZNQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnYo1LubaneTXgVX9ZhUW7BC4A8FrnNt8',
    appId: '1:95085555633:android:8141ff99d2c69c4e359790',
    messagingSenderId: '95085555633',
    projectId: 'rednotes-app',
    databaseURL: 'https://rednotes-app-default-rtdb.firebaseio.com',
    storageBucket: 'rednotes-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKqdt31Z_L81AwmmO99bWGYNhCF8sZo-8',
    appId: '1:95085555633:ios:d644f3fa38fe28c0359790',
    messagingSenderId: '95085555633',
    projectId: 'rednotes-app',
    databaseURL: 'https://rednotes-app-default-rtdb.firebaseio.com',
    storageBucket: 'rednotes-app.appspot.com',
    iosClientId: '95085555633-t565dcm8ppq30rgj48839dflqnqs14gv.apps.googleusercontent.com',
    iosBundleId: 'com.example.redNoteAdminPannel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKqdt31Z_L81AwmmO99bWGYNhCF8sZo-8',
    appId: '1:95085555633:ios:d644f3fa38fe28c0359790',
    messagingSenderId: '95085555633',
    projectId: 'rednotes-app',
    databaseURL: 'https://rednotes-app-default-rtdb.firebaseio.com',
    storageBucket: 'rednotes-app.appspot.com',
    iosClientId: '95085555633-t565dcm8ppq30rgj48839dflqnqs14gv.apps.googleusercontent.com',
    iosBundleId: 'com.example.redNoteAdminPannel',
  );
}