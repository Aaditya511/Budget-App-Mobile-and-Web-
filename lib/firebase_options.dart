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
    apiKey: 'AIzaSyAKWayk7nc65lAzqRo2V64R6ZHU2xESnks',
    appId: '1:754843817487:web:eeaa639b004b482b40f57a',
    messagingSenderId: '754843817487',
    projectId: 'my-project-budget-app-dd902',
    authDomain: 'my-project-budget-app-dd902.firebaseapp.com',
    storageBucket: 'my-project-budget-app-dd902.appspot.com',
    measurementId: 'G-0VRJHQXMCV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVDO_geDyICu4Kx6WLFBNUr4E6P1Sp_m0',
    appId: '1:754843817487:android:741480f6fa0444c140f57a',
    messagingSenderId: '754843817487',
    projectId: 'my-project-budget-app-dd902',
    storageBucket: 'my-project-budget-app-dd902.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdajQk0MkhHec6R_Q3cdQvsJa5yKfG_Tw',
    appId: '1:754843817487:ios:2812730a341e491840f57a',
    messagingSenderId: '754843817487',
    projectId: 'my-project-budget-app-dd902',
    storageBucket: 'my-project-budget-app-dd902.appspot.com',
    androidClientId:
        '754843817487-a72hq8753o29rqtv0jni7m9hhrcfb0al.apps.googleusercontent.com',
    iosClientId:
        '754843817487-6d9qh5hn5a1uhbbbokqglnupkd94tenl.apps.googleusercontent.com',
    iosBundleId: 'com.example.checkUrBudget',
  );
}
