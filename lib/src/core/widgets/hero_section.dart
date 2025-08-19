import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_danilo/src/core/widgets/animated_slide_fade.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AnimatedSlideFade(
            delay: Duration(milliseconds: 200),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/img/logo.png'),
            ),
          ),
          const SizedBox(height: 24),
          AnimatedSlideFade(
            delay: const Duration(milliseconds: 400),
            child: Text(
              'Olá, me chamo',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSlideFade(
            delay: const Duration(milliseconds: 600),
            child: Text(
              'Danilo Araújo de Souza',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 24 : 32,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          AnimatedSlideFade(
            delay: const Duration(milliseconds: 800),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 20 : 24,
                  ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Software Developer',
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Flutter, .NET e PHP',
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Mobile Developer',
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                repeatForever: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
