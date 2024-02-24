import 'package:flutter/material.dart';
import 'package:portfolio_danilo/src/core/ui/app_config_ui.dart';
import 'package:portfolio_danilo/src/screens/home_screen.dart';
import 'package:portfolio_danilo/src/screens/politica_privacidade_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danilo A. Souza',
      theme: AppConfigUi.theme,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePageScreen(title: 'Home Page'),
        '/politica-privacidade': (_) => const PoliticaPrivacidadeScreen(),
      },
    );
  }
}
