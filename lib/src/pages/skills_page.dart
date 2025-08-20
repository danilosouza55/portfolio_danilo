import 'package:flutter/material.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

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
                  Text('Skills',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  const Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      // Linguagens
                      Chip(label: Text('Flutter')),
                      Chip(label: Text('Dart')),
                      Chip(label: Text('C#')),
                      Chip(label: Text('.NET')),
                      Chip(label: Text('PHP')),
                      Chip(label: Text('JavaScript')),

                      // Banco de Dados
                      Chip(label: Text('MySQL')),
                      Chip(label: Text('PostgreSQL')),
                      Chip(label: Text('SQLite')),
                      Chip(label: Text('Firebase')),

                      // Ferramentas
                      Chip(label: Text('Git')),
                      Chip(label: Text('Docker')),
                      Chip(label: Text('CI/CD')),
                      Chip(label: Text('Linux')),

                      // Metodologias / Gestão
                      Chip(label: Text('Scrum')),
                      Chip(label: Text('Kanban')),
                      Chip(label: Text('DevOps')),

                      // Outras áreas
                      Chip(label: Text('UI/UX')),
                      Chip(label: Text('Design Patterns')),
                      Chip(label: Text('Arquitetura de Software')),
                      Chip(label: Text('Gestão de Projetos')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
