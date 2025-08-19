import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bem-vindo ao meu portfólio!',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
