import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2027),
            Color(0xFF2C5364),
            Color(0xFF6A82FB),
            Color(0xFFB06AB3),
          ],
          stops: [0.0, 0.4, 0.7, 1.0],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Contato',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  const Text('E-mail: danilo.souza@hotmail.com'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
