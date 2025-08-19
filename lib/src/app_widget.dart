import 'package:flutter/material.dart';
import 'package:portfolio_danilo/src/core/theme/app_theme.dart';
import 'package:portfolio_danilo/modern_web_app.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danilo A. Souza',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const ModernWebApp(),
    );
  }
}
