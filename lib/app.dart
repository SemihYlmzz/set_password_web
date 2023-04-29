import 'package:flutter/material.dart';
import 'package:set_new_password/screen/set_new_password_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SetNewPasswordScreen(),
    );
  }
}
