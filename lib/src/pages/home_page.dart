import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_danilo/src/core/ui/landing_page_icons_icons.dart';
import 'package:portfolio_danilo/src/core/widgets/modern_components.dart';
import 'package:portfolio_danilo/src/core/theme/app_colors.dart';
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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String version = 'v0.0.0';
  late AnimationController _heroController;
  late Animation<double> _heroFadeAnimation;
  late Animation<Offset> _heroSlideAnimation;

  @override
  void initState() {
    super.initState();
    getVersion();
    _setupHeroAnimations();
  }

  void _setupHeroAnimations() {
    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _heroFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeOut),
    );

    _heroSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeOut),
    );

    _heroController.forward();
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  Future<void> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = 'v${packageInfo.version}';
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Não foi possível abrir: $url'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: isMobile ? 40 : 60,
            ),
            child: Column(
              children: [
                // Hero Section
                _buildHeroSection(context, isMobile),
                SizedBox(height: isMobile ? 60 : 80),

                // Featured Projects
                // SizedBox(height: isMobile ? 60 : 80),

                // About Section
                // SizedBox(height: isMobile ? 60 : 80),

                // CTA Section
                _buildCTASection(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: FadeTransition(
            opacity: _heroFadeAnimation,
            child: SlideTransition(
              position: _heroSlideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Animated gradient text
                  GradientText(
                    'Olá, eu sou Danilo',
                    gradient: AppColors.primaryGradient,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 16 : 20),

                  Text(
                    'Flutter Developer & Backend Developer',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 20 : 28),

                  Text(
                    'Desenvolvedor experiente em Flutter especializado em criar aplicações móveis inovadoras, responsivas e de alta performance.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.8,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 48 : 56),

                  // Social icons
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    children: [
                      IconBox(
                        icon: LandingPageIcons.github,
                        backgroundColor: AppColors.darkCard,
                        onTap: () =>
                            _launchURL('https://github.com/danilosouza55'),
                      ),
                      IconBox(
                        icon: LandingPageIcons.linkedin,
                        backgroundColor: AppColors.darkCard,
                        onTap: () => _launchURL(
                            'https://linkedin.com/in/danilo-araújo-de-souza-081b7398'),
                      ),
                      IconBox(
                        icon: LandingPageIcons.instagram,
                        backgroundColor: AppColors.darkCard,
                        onTap: () => _launchURL(
                            'https://www.instagram.com/danilo_asouza'),
                      ),
                      IconBox(
                        icon: LandingPageIcons.twitter,
                        backgroundColor: AppColors.darkCard,
                        onTap: () =>
                            _launchURL('https://twitter.com/danilo_asouza'),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 48 : 60),

                  // Stats Section
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: isMobile ? 40 : 60,
                    runSpacing: isMobile ? 24 : 0,
                    children: [
                      _buildStatItem('5+', 'Anos de\nExperiência'),
                      // _buildStatItem('50+', 'Projetos\nConcluídos'),
                      // _buildStatItem('100%', 'Satisfação de\nClientes'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.accent,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return GradientCard(
      gradient: AppColors.primaryGradient,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      child: Column(
        children: [
          Text(
            'Entre em Contato',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Conecte-se comigo pelas redes sociais ou envie uma mensagem direta',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              ModernButton(
                label: 'Enviar Email',
                onPressed: () => _launchURL('mailto:danilo.souza@hotmail.com'),
                icon: Icons.mail_rounded,
              ),
              ModernButton(
                label: 'WhatsApp',
                onPressed: () => _launchURL('https://wa.me/5585988256820'),
                icon: Icons.chat_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
