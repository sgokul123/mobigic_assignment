import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_assignment/src/splash_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(platform: TargetPlatform.android),
      home:  SplashScreen(),
    );
  }
}
