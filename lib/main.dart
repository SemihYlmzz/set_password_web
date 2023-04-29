import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAS2qzORqTsuc4JVY31eDSn66AKKZ8lN58",
        authDomain: "chess-mastermind.firebaseapp.com",
        projectId: "chess-mastermind",
        storageBucket: "chess-mastermind.appspot.com",
        messagingSenderId: "817443687517",
        appId: "1:817443687517:web:01b039a1b62a4eef4591b4",
        measurementId: "G-LBJ4WHCNLZ",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
