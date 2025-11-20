import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
                _buildFeaturedProjects(context, isMobile),
                SizedBox(height: isMobile ? 60 : 80),
                
                // About Section
                _buildAboutSection(context, isMobile),
                SizedBox(height: isMobile ? 60 : 80),
                
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
          constraints: const BoxConstraints(maxWidth: 800),
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
                'Flutter Developer & UI/UX Enthusiast',
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
              SizedBox(height: isMobile ? 32 : 40),
              
              // CTA Buttons
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 12 : 16,
                runSpacing: isMobile ? 12 : 16,
                children: [
                  ModernButton(
                    label: 'Ver Meu Trabalho',
                    onPressed: () {},
                    isGradient: true,
                    width: isMobile ? null : 180,
                    icon: Icons.arrow_forward_rounded,
                  ),
                  ModernButton(
                    label: 'Entrar em Contato',
                    onPressed: () {},
                    isOutlined: true,
                    width: isMobile ? null : 180,
                    icon: Icons.mail_rounded,
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 40 : 48),
              
              // Social icons
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                children: [
                  IconBox(
                    icon: LandingPageIcons.github,
                    backgroundColor: AppColors.darkCard,
                    onTap: () {},
                  ),
                  IconBox(
                    icon: LandingPageIcons.linkedin,
                    backgroundColor: AppColors.darkCard,
                    onTap: () {},
                  ),
                  IconBox(
                    icon: LandingPageIcons.instagram,
                    backgroundColor: AppColors.darkCard,
                    onTap: () {},
                  ),
                  IconBox(
                    icon: LandingPageIcons.twitter,
                    backgroundColor: AppColors.darkCard,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProjects(BuildContext context, bool isMobile) {
    final projects = [
      {
        'title': 'Project Alpha',
        'description': 'App de mobilidade urbana com geolocalização em tempo real',
        'tech': ['Flutter', 'Firebase', 'Google Maps'],
        'icon': Icons.local_taxi,
      },
      {
        'title': 'Project Beta',
        'description': 'Plataforma de e-commerce com integração de pagamentos',
        'tech': ['Flutter', 'Stripe', 'Node.js'],
        'icon': Icons.shopping_bag,
      },
      {
        'title': 'Project Gamma',
        'description': 'Social media app com sistema de notificações avançado',
        'tech': ['Flutter', 'Firebase', 'WebSocket'],
        'icon': Icons.people,
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

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project, bool isMobile) {
    return GradientCard(
      gradient: LinearGradient(
        colors: [
          AppColors.darkCard,
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
              gradient: AppColors.primaryGradient,
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
                      backgroundColor: AppColors.primary.withOpacity(0.2),
                      foregroundColor: AppColors.primary,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Sobre Mim',
          subtitle: 'Desenvolvedor apaixonado por criar experiências digitais incríveis',
        ),
        const SizedBox(height: 40),
        GlassCard(
          padding: const EdgeInsets.all(32),
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
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  'Desenvolvimento Flutter',
                  'UI/UX Design',
                  'Firebase',
                  'State Management',
                  'API Integration',
                  'Performance Optimization',
                ]
                    .map((skill) => ModernChip(
                          label: skill,
                          backgroundColor: AppColors.primary.withOpacity(0.15),
                          foregroundColor: AppColors.accent,
                          icon: Icons.check_circle,
                        ))
                    .toList(),
              ),
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
            'Pronto para começar um projeto?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Entre em contato comigo para discutir como posso ajudar seu próximo projeto',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ModernButton(
            label: 'Enviar Email',
            onPressed: () {},
            icon: Icons.mail_rounded,
          ),
        ],
      ),
    );
  }
}
