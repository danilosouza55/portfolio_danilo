import 'package:flutter/material.dart';
import 'package:portfolio_danilo/src/core/theme/app_colors.dart';

class ModernMenu extends StatefulWidget {
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
  State<ModernMenu> createState() => _ModernMenuState();
}

class _ModernMenuState extends State<ModernMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    if (isMobile) {
      return _buildMobileMenu();
    } else {
      return _buildDesktopMenu();
    }
  }

  Widget _buildMobileMenu() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.darkBg,
              AppColors.darkBg.withOpacity(0.8),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          children: [
            // Close Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: AppColors.textPrimary),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Fechar menu',
              ),
            ),
            const SizedBox(height: 20),

            // Profile Section
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                    parent: _animationController, curve: Curves.easeOut),
              ),
              child: Center(
                child: Column(
                  children: [
                    // Avatar with Border
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage: AssetImage(widget.profileImage),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.name,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.role,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Divider
            Divider(color: AppColors.textSecondary.withOpacity(0.2)),
            const SizedBox(height: 16),

            // Navigation Items
            ...List.generate(
              widget.navItems.length,
              (index) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(
                      0.2 + (index * 0.1),
                      0.6 + (index * 0.1),
                      curve: Curves.easeOut,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: AnimatedMenuItem(child: widget.navItems[index]),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Social Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.socialIcons.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimatedSocialIcon(child: widget.socialIcons[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopMenu() {
    return Container(
      height: 84,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkBg.withOpacity(0.95),
            AppColors.darkBg.withOpacity(0.85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 32),

          // Profile Section
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                  parent: _animationController, curve: Curves.easeOut),
            ),
            child: Row(
              children: [
                // Avatar with Border
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage(widget.profileImage),
                  ),
                ),
                const SizedBox(width: 16),

                // Name and Role
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    Text(
                      widget.role,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // Navigation Items
          ...List.generate(
            widget.navItems.length,
            (index) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                    0.2 + (index * 0.1),
                    0.6 + (index * 0.1),
                    curve: Curves.easeOut,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedMenuItem(child: widget.navItems[index]),
              ),
            ),
          ),

          const SizedBox(width: 32),

          // Social Icons
          if (widget.socialIcons.isNotEmpty)
            Row(
              children: List.generate(
                widget.socialIcons.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimatedSocialIcon(child: widget.socialIcons[index]),
                ),
              ),
            ),

          const SizedBox(width: 24),
        ],
      ),
    );
  }
}

// Animated Menu Item with Enhanced Effects
class AnimatedMenuItem extends StatefulWidget {
  final Widget child;

  const AnimatedMenuItem({required this.child, Key? key}) : super(key: key);

  @override
  State<AnimatedMenuItem> createState() => _AnimatedMenuItemState();
}

class _AnimatedMenuItemState extends State<AnimatedMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: AppColors.primary.withOpacity(0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

// Animated Social Icon with Enhanced Effects
class AnimatedSocialIcon extends StatefulWidget {
  final Widget child;

  const AnimatedSocialIcon({required this.child, Key? key}) : super(key: key);

  @override
  State<AnimatedSocialIcon> createState() => _AnimatedSocialIconState();
}

class _AnimatedSocialIconState extends State<AnimatedSocialIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotateAnimation.value,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class Skill {
  final String name;
  final IconData icon;

  Skill({required this.name, required this.icon});
}
