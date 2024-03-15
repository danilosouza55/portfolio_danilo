import 'package:flutter/material.dart';
import 'package:portfolio_danilo/src/core/ui/landing_page_icons_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'widget/card_link_social.dart';

class HomePageScreen extends StatelessWidget {
  final String title;

  const HomePageScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 77, 64, 255),
              Color.fromARGB(255, 170, 122, 18)
            ],
          ),
        ),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/img/logo.png"),
              ),
              const Text(
                'Hi my name is Danilo Araújo de Souza',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                "I'm a software developer",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  double screenWidth = sizingInformation.screenSize.width;
                  if (screenWidth <= const RefinedBreakpoints().tabletSmall) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CardLinkSocialWidget(
                            title: 'GITHUB',
                            icon: LandingPageIcons.github,
                            width: double.infinity,
                            link: 'https://github.com/danilosouza55',
                          ),
                          SizedBox(height: 10),
                          CardLinkSocialWidget(
                            title: 'LINKEDIN',
                            icon: LandingPageIcons.linkedin,
                            width: double.infinity,
                            link:
                                'https://linkedin.com/in/danilo-araújo-de-souza-081b7398',
                          ),
                          SizedBox(height: 10),
                          CardLinkSocialWidget(
                            title: 'INSTAGRAM',
                            icon: LandingPageIcons.instagram,
                            width: double.infinity,
                            link: 'https://www.instagram.com/danilo_asouza',
                          ),
                          SizedBox(height: 10),
                          CardLinkSocialWidget(
                            title: 'TWITTER',
                            icon: LandingPageIcons.twitter,
                            width: double.infinity,
                            link: 'https://twitter.com/danilo_asouza',
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CardLinkSocialWidget(
                          title: 'GITHUB',
                          icon: LandingPageIcons.github,
                          link: 'https://github.com/danilosouza55',
                        ),
                        CardLinkSocialWidget(
                          title: 'LINKEDIN',
                          icon: LandingPageIcons.linkedin,
                          link:
                              'https://linkedin.com/in/danilo-araújo-de-souza-081b7398',
                        ),
                        CardLinkSocialWidget(
                          title: 'INSTAGRAM',
                          icon: LandingPageIcons.instagram,
                          link: 'https://www.instagram.com/danilo_asouza',
                        ),
                        CardLinkSocialWidget(
                          title: 'TWITTER',
                          icon: LandingPageIcons.twitter,
                          link: 'https://twitter.com/danilo_asouza',
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
