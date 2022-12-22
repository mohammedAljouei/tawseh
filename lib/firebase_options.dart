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
    apiKey: 'AIzaSyCV-SST0hlZZGmkXgTei47hTIRviOlFoVM',
    appId: '1:898390061928:web:2f7583f624a20545405cdd',
    messagingSenderId: '898390061928',
    projectId: 'tawseh-1',
    authDomain: 'tawseh-1.firebaseapp.com',
    storageBucket: 'tawseh-1.appspot.com',
    measurementId: 'G-RTRFG1SEEH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRktTEMIvqqb6hUxuSHx-uE1_MOS5dk6w',
    appId: '1:898390061928:android:98ea588003adafd6405cdd',
    messagingSenderId: '898390061928',
    projectId: 'tawseh-1',
    storageBucket: 'tawseh-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6IBh0t0jf5W50xof0KAHoq-UYFVeBPAY',
    appId: '1:898390061928:ios:57c15e69ca730298405cdd',
    messagingSenderId: '898390061928',
    projectId: 'tawseh-1',
    storageBucket: 'tawseh-1.appspot.com',
    iosClientId: '898390061928-crs5luoi4acqfv7dgkjv6uhpreo6dl0g.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6IBh0t0jf5W50xof0KAHoq-UYFVeBPAY',
    appId: '1:898390061928:ios:57c15e69ca730298405cdd',
    messagingSenderId: '898390061928',
    projectId: 'tawseh-1',
    storageBucket: 'tawseh-1.appspot.com',
    iosClientId: '898390061928-crs5luoi4acqfv7dgkjv6uhpreo6dl0g.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
