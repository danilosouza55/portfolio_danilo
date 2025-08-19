import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_danilo/src/core/widgets/gradient_border_painter.dart';

class SocialCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String link;
  final double size;

  const SocialCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.link,
    this.size = 60,
  }) : super(key: key);

  @override
  State<SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<SocialCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.link);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotateAnimation.value,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CustomPaint(
                    painter: GradientBorderPainter(),
                    child: Center(
                      child: Container(
                        width: widget.size - 8,
                        height: widget.size - 8,
                        decoration: BoxDecoration(
                          color: isHovered
                              ? Theme.of(context).primaryColor
                              : Colors.white.withOpacity(0.85),
                          shape: BoxShape.circle,
                          boxShadow: isHovered
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    blurRadius: 12,
                                    spreadRadius: 4,
                                  ),
                                ]
                              : [],
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isHovered
                              ? Icon(
                                  widget.icon,
                                  size: (widget.size - 8) * 0.5,
                                  color: Colors.white,
                                )
                              : ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 152, 1, 240),
                                        Color.fromARGB(255, 72, 48, 138),
                                      ],
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    widget.icon,
                                    size: (widget.size - 8) * 0.5,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
