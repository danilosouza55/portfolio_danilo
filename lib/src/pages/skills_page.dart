import 'package:flutter/material.dart';
import 'package:portfolio_danilo/src/core/theme/app_colors.dart';
import 'package:portfolio_danilo/src/core/widgets/modern_components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Minhas Habilidades',
                  subtitle: 'Tecnologias e ferramentas que domino',
                ),
                SizedBox(height: isMobile ? 40 : 60),
                
                // Linguagens
                _buildSkillCategory(
                  context,
                  'Linguagens de Programação',
                  ['Dart', 'Flutter', 'C#', '.NET', 'PHP', 'JavaScript', 'TypeScript', 'SQL'],
                  Icons.code,
                  isMobile,
                ),
                SizedBox(height: isMobile ? 40 : 60),
                
                // Frontend
                _buildSkillCategory(
                  context,
                  'Development Frontend',
                  ['Flutter', 'Responsive Design', 'Material Design', 'Cupertino', 'Animation', 'State Management'],
                  Icons.palette,
                  isMobile,
                ),
                SizedBox(height: isMobile ? 40 : 60),
                
                // Backend
                _buildSkillCategory(
                  context,
                  'Development Backend',
                  ['Firebase', 'REST API', 'WebSocket', 'Node.js', 'Express', 'Database Design'],
                  Icons.storage,
                  isMobile,
                ),
                SizedBox(height: isMobile ? 40 : 60),
                
                // Tools
                _buildSkillCategory(
                  context,
                  'Ferramentas & DevOps',
                  ['Git', 'GitHub', 'Docker', 'VS Code', 'Android Studio', 'Firebase Console', 'CI/CD'],
                  Icons.build,
                  isMobile,
                ),
                SizedBox(height: isMobile ? 40 : 60),
                
                // Soft Skills
                _buildSoftSkills(context, isMobile),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String title,
    List<String> skills,
    IconData icon,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
        Wrap(
          spacing: isMobile ? 8 : 12,
          runSpacing: isMobile ? 8 : 12,
          children: skills
              .map((skill) => ModernChip(
                    label: skill,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    foregroundColor: AppColors.accent,
                    selected: true,
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSoftSkills(BuildContext context, bool isMobile) {
    final softSkills = [
      {'title': 'Problem Solving', 'icon': Icons.lightbulb, 'level': 95},
      {'title': 'Communication', 'icon': Icons.chat, 'level': 88},
      {'title': 'Leadership', 'icon': Icons.people, 'level': 82},
      {'title': 'Time Management', 'icon': Icons.schedule, 'level': 90},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Text(
                'Soft Skills',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: isMobile ? 0 : 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.5,
          ),
          itemCount: softSkills.length,
          itemBuilder: (context, index) {
            final skill = softSkills[index];
            return _buildSkillProgressCard(
              context,
              skill['title'] as String,
              skill['level'] as int,
              skill['icon'] as IconData,
            );
          },
        ),
      ],
    );
  }

  Widget _buildSkillProgressCard(
    BuildContext context,
    String title,
    int level,
    IconData icon,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.accent, size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              Text(
                '$level%',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: level / 100,
              minHeight: 6,
              backgroundColor: AppColors.darkBgTertiary,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.lerp(AppColors.primary, AppColors.accent, 0.5) ??
                    AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
