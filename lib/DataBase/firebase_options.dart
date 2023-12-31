
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyA_hBl6b2NHKoevO4zIO3ORjhWCngkq3xc',
    appId: '1:600708835126:web:f322679484b4951c5d7597',
    messagingSenderId: '600708835126',
    projectId: 'e-shop-73f16',
    authDomain: 'e-shop-73f16.firebaseapp.com',
    storageBucket: 'e-shop-73f16.appspot.com',
    measurementId: 'G-3VFFT6K344',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS_DABvYc3g2xVqEFezJcwT47mBYhXJUI',
    appId: '1:600708835126:android:b5d23850ffddf6595d7597',
    messagingSenderId: '600708835126',
    projectId: 'e-shop-73f16',
    storageBucket: 'e-shop-73f16.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDe5_GIGxCv7QkWpipQcMxMnaDzZEC2-yo',
    appId: '1:600708835126:ios:091c1c77add43bbd5d7597',
    messagingSenderId: '600708835126',
    projectId: 'e-shop-73f16',
    storageBucket: 'e-shop-73f16.appspot.com',
    iosClientId: '600708835126-412p2brvs4bo2s09vmj8j4olc7dl28h3.apps.googleusercontent.com',
    iosBundleId: 'com.example.eShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDe5_GIGxCv7QkWpipQcMxMnaDzZEC2-yo',
    appId: '1:600708835126:ios:2e738f0c90e4e52e5d7597',
    messagingSenderId: '600708835126',
    projectId: 'e-shop-73f16',
    storageBucket: 'e-shop-73f16.appspot.com',
    iosClientId: '600708835126-r55vf4087mdo3udnibd53t6e0utd653r.apps.googleusercontent.com',
    iosBundleId: 'com.example.eShop.RunnerTests',
  );
}
