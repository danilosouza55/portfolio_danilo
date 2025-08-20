import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:portfolio_danilo/src/core/ui/landing_page_icons_icons.dart';
import 'package:portfolio_danilo/src/core/widgets/social_card.dart';
import 'package:portfolio_danilo/src/core/widgets/hero_section.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String version = 'v0.0.0';

  @override
  void initState() {
    getVersion();
    super.initState();
  }

  Future<void> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = 'v${packageInfo.version}';
    });
  }

  List<Widget> _buildSocialCards({bool fullWidth = false}) {
    final double iconSize = fullWidth ? 70 : 60;
    final double spacing = fullWidth ? 8 : 12;

    return [
      SocialCard(
        title: 'GITHUB',
        icon: LandingPageIcons.github,
        size: iconSize,
        link: 'https://github.com/danilosouza55',
      ),
      SizedBox(height: fullWidth ? spacing : 0, width: fullWidth ? 0 : spacing),
      SocialCard(
        title: 'LINKEDIN',
        icon: LandingPageIcons.linkedin,
        size: iconSize,
        link: 'www.linkedin.com/in/danilo-araújo-de-souza-081b7398/',
      ),
      SizedBox(height: fullWidth ? spacing : 0, width: fullWidth ? 0 : spacing),
      SocialCard(
        title: 'INSTAGRAM',
        icon: LandingPageIcons.instagram,
        size: iconSize,
        link: 'https://www.instagram.com/danilo_asouza',
      ),
      SizedBox(height: fullWidth ? spacing : 0, width: fullWidth ? 0 : spacing),
      SocialCard(
        title: 'TWITTER',
        icon: LandingPageIcons.twitter,
        size: iconSize,
        link: 'https://twitter.com/danilo_asouza',
      ),
    ];
  }

  // Removido PageController e scrollOffset, pois não haverá mais PageView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027), // azul escuro
              Color(0xFF2C5364), // azul
              Color(0xFF6A82FB), // azul claro
              Color(0xFFB06AB3), // roxo
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
                constraints: const BoxConstraints(
                  maxWidth: 900,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeroSection(),
                    const SizedBox(height: 32),
                    ResponsiveBuilder(
                      builder: (context, sizingInformation) {
                        final isSmallScreen =
                            sizingInformation.screenSize.width <=
                                const RefinedBreakpoints().tabletSmall;
                        final socialCards =
                            _buildSocialCards(fullWidth: isSmallScreen);
                        return AnimationLimiter(
                          child: isSmallScreen
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    socialCards.length,
                                    (index) =>
                                        AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        horizontalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: socialCards[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: List.generate(
                                    socialCards.length,
                                    (index) =>
                                        AnimationConfiguration.staggeredGrid(
                                      columnCount: 4,
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      child: SlideAnimation(
                                        horizontalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: socialCards[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Text(
                      version,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
