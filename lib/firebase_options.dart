import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          're-run the FlutterFire CLI.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA3ze4j6ReX2oGKaSVHBl7UEfgAK8-EltY',
    appId: '1:1086781934007:web:dade6060d4f62cb7458032',
    messagingSenderId: '1086781934007',
    projectId: 'madd-947ac',
    authDomain: 'madd-947ac.firebaseapp.com',
    storageBucket: 'madd-947ac.appspot.com',
    measurementId: 'G-3J1NXKTBLJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUGMchoBS5diRVnNGwYVVWIBStn8H3CjA',
    appId: '1:1086781934007:android:656197f1029f86bc458032',
    messagingSenderId: '1086781934007',
    projectId: 'madd-947ac',
    storageBucket: 'madd-947ac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOcBDevsOFsUSBkTIsGRZoJp6rjbp0s70',
    appId: '1:1086781934007:ios:df94f23f2b492e2c458032',
    messagingSenderId: '1086781934007',
    projectId: 'madd-947ac',
    storageBucket: 'madd-947ac.appspot.com',
    iosBundleId: 'com.example.firebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOcBDevsOFsUSBkTIsGRZoJp6rjbp0s70',
    appId: '1:1086781934007:ios:df94f23f2b492e2c458032',
    messagingSenderId: '1086781934007',
    projectId: 'madd-947ac',
    storageBucket: 'madd-947ac.appspot.com',
    iosBundleId: 'com.example.firebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA3ze4j6ReX2oGKaSVHBl7UEfgAK8-EltY',
    appId: '1:1086781934007:web:69a44f23747dc5e5458032',
    messagingSenderId: '1086781934007',
    projectId: 'madd-947ac',
    authDomain: 'madd-947ac.firebaseapp.com',
    storageBucket: 'madd-947ac.appspot.com',
    measurementId: 'G-LEY45ECZ5R',
  );
}