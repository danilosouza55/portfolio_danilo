import 'package:flutter/material.dart';
import 'dart:ui';

class ModernMenu extends StatelessWidget {
  final String name;
  final String role;
  final String profileImage;
  final List<Widget> navItems;
  final List<Widget> socialIcons;
  final VoidCallback? onMenuTap;

  const ModernMenu({
    super.key,
    required this.name,
    required this.role,
    required this.profileImage,
    required this.navItems,
    required this.socialIcons,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF0F2027),
        Color(0xFF2C5364),
        Color(0xFF6A82FB),
        Color(0xFFB06AB3),
      ],
      stops: [0.0, 0.4, 0.7, 1.0],
    );

    if (isMobile) {
      return Drawer(
        child: Container(
          decoration: BoxDecoration(gradient: gradient),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Fechar menu',
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutExpo,
                child: Center(
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: AssetImage(profileImage),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 8, color: Colors.black45)],
                  ),
                  child: Text(name),
                ),
              ),
              Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                  child: Text(role),
                ),
              ),
              const SizedBox(height: 28),
              ...navItems.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: AnimatedMenuItem(child: item),
                  )),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: socialIcons
                    .map((icon) => AnimatedSocialIcon(child: icon))
                    .toList(),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 84,
        decoration: const BoxDecoration(
          gradient: gradient,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 32),
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutExpo,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage(profileImage),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 8, color: Colors.black45)],
                  ),
                  child: Text(name),
                ),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                  child: Text(role),
                ),
              ],
            ),
            const Spacer(),
            ...navItems.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimatedMenuItem(child: item),
                )),
            const SizedBox(width: 32),
            Row(
              children: socialIcons
                  .map((icon) => AnimatedSocialIcon(child: icon))
                  .toList(),
            ),
            const SizedBox(width: 24),
          ],
        ),
      );
    }
  }
}

class AnimatedMenuItem extends StatefulWidget {
  final Widget child;
  const AnimatedMenuItem({required this.child, Key? key}) : super(key: key);

  @override
  State<AnimatedMenuItem> createState() => _AnimatedMenuItemState();
}

class _AnimatedMenuItemState extends State<AnimatedMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 1.0,
      upperBound: 1.12,
    );
    _scale = _controller.drive(Tween(begin: 1.0, end: 1.12));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _controller.value > 1.0 ? 0.85 : 1.0,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class AnimatedSocialIcon extends StatefulWidget {
  final Widget child;
  const AnimatedSocialIcon({required this.child, Key? key}) : super(key: key);

  @override
  State<AnimatedSocialIcon> createState() => _AnimatedSocialIconState();
}

class _AnimatedSocialIconState extends State<AnimatedSocialIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 1.0,
      upperBound: 1.18,
    );
    _scale = _controller.drive(Tween(begin: 1.0, end: 1.18));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _controller.value > 1.0 ? 0.7 : 1.0,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class Skill {
  final String name;
  final IconData icon;
  Skill({required this.name, required this.icon});
}
