import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTexts.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: LandingPage(),  // ← Agora o LandingPage existe!
    );
  }
}