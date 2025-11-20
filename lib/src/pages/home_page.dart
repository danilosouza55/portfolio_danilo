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
                // _buildFeaturedProjects(context, isMobile),
                // SizedBox(height: isMobile ? 60 : 80),

                // About Section
                // _buildAboutSection(context, isMobile),
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

  Widget _buildFeaturedProjects(BuildContext context, bool isMobile) {
    final projects = [
      {
        'title': 'App de Mobilidade Urbana',
        'description':
            'Aplicativo com geolocalização em tempo real, rastreamento de rotas e integração com Google Maps para navegação inteligente.',
        'tech': ['Flutter', 'Firebase', 'Google Maps', 'Real-time'],
        'icon': Icons.location_on,
        'color': const Color(0xFF667eea),
      },
      {
        'title': 'Plataforma E-commerce',
        'description':
            'Loja virtual com carrinho de compras, integração de pagamentos seguros via Stripe e sistema de notificações.',
        'tech': ['Flutter', 'Stripe', 'Node.js', 'REST API'],
        'icon': Icons.shopping_cart,
        'color': const Color(0xFF764ba2),
      },
      {
        'title': 'App Social Media',
        'description':
            'Rede social com feed dinâmico, notificações em tempo real via WebSocket e compartilhamento de mídia.',
        'tech': ['Flutter', 'Firebase', 'WebSocket', 'Cloud Storage'],
        'icon': Icons.share,
        'color': const Color(0xFFf093fb),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Projetos em Destaque',
          subtitle: 'Trabalhos recentes que demonstram minha expertise',
        ),
        const SizedBox(height: 40),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 3,
            crossAxisSpacing: isMobile ? 0 : 20,
            mainAxisSpacing: 20,
            childAspectRatio: isMobile ? 1 : 1.1,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return _buildProjectCard(context, project, isMobile);
          },
        ),
      ],
    );
  }

  Widget _buildProjectCard(
      BuildContext context, Map<String, dynamic> project, bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Projeto: ${project['title']}'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: GradientCard(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (project['color'] as Color).withValues(alpha: 0.15),
              AppColors.darkBgTertiary,
            ],
          ),
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (project['color'] as Color),
                      (project['color'] as Color).withValues(alpha: 0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(project['icon'], color: Colors.white, size: 28),
              ),
              SizedBox(height: isMobile ? 20 : 24),
              Text(
                project['title'],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(height: 8),
              Text(
                project['description'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isMobile ? 16 : 20),
              Wrap(
                spacing: 8,
                children: (project['tech'] as List<String>)
                    .map((tech) => ModernChip(
                          label: tech,
                          backgroundColor: (project['color'] as Color)
                              .withValues(alpha: 0.2),
                          foregroundColor: project['color'] as Color,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, bool isMobile) {
    final skills = [
      {'skill': 'Desenvolvimento Flutter', 'level': 0.95},
      {'skill': 'UI/UX Design', 'level': 0.85},
      {'skill': 'Firebase', 'level': 0.9},
      {'skill': 'State Management', 'level': 0.88},
      {'skill': 'API Integration', 'level': 0.92},
      {'skill': 'Performance', 'level': 0.87},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Sobre Mim',
          subtitle:
              'Desenvolvedor apaixonado por criar experiências digitais incríveis',
        ),
        const SizedBox(height: 40),
        GlassCard(
          padding: EdgeInsets.all(isMobile ? 24 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Com mais de 5 anos de experiência em desenvolvimento mobile, tenho paixão por criar aplicações que combinam design inovador com funcionalidade robusta.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.8,
                    ),
              ),
              const SizedBox(height: 32),
              Text(
                'Habilidades Principais',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              ...skills.map((skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              skill['skill'].toString(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Text(
                              '${((skill['level'] as double) * 100).toInt()}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: skill['level'] as double,
                            minHeight: 6,
                            backgroundColor: AppColors.darkCard,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryGradient.colors.first,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
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
