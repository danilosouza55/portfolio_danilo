import 'package:flutter/material.dart';
import 'package:portfolio_danilo/src/core/theme/app_theme.dart';
import 'package:portfolio_danilo/src/pages/home_page.dart';
import 'package:portfolio_danilo/src/pages/contact_page.dart';
import 'package:portfolio_danilo/src/pages/politica_privacidade_page.dart';
import 'package:portfolio_danilo/src/pages/skills_page.dart';
import 'package:portfolio_danilo/src/core/widgets/modern_menu.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danilo A. Souza',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const ModernApp(),
    );
  }
}

class ModernApp extends StatefulWidget {
  const ModernApp({super.key});

  @override
  State<ModernApp> createState() => _ModernAppState();
}

class _ModernAppState extends State<ModernApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(title: 'Home Page'),
    const SkillsPage(),
    const PoliticaPrivacidadePage(),
    const ContactPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final menu = ModernMenu(
      name: 'Danilo A. Souza',
      role: 'Flutter Developer',
      profileImage: 'assets/img/logo.png',
      navItems: [
        _NavBarButton(
            label: 'Home',
            index: 0,
            selected: _selectedIndex == 0,
            onTap: _onItemTapped),
        _NavBarButton(
            label: 'Skills',
            index: 1,
            selected: _selectedIndex == 1,
            onTap: _onItemTapped),
        _NavBarButton(
            label: 'Política de privacidade',
            index: 2,
            selected: _selectedIndex == 2,
            onTap: _onItemTapped),
        _NavBarButton(
            label: 'Contato',
            index: 3,
            selected: _selectedIndex == 3,
            onTap: _onItemTapped),
      ],
      socialIcons: const [],
    );

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0F2027),
                      Color(0xFF2C5364),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              title: const Text('Portfólio Danilo'),
            )
          : AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 84,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: menu,
            ),
      drawer: isMobile ? menu : null,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  final String label;
  final int index;
  final bool selected;
  final void Function(int) onTap;

  const _NavBarButton(
      {required this.label,
      required this.index,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(index),
      child: Text(
        label,
        style: TextStyle(
          color:
              selected ? Theme.of(context).colorScheme.secondary : Colors.white,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
