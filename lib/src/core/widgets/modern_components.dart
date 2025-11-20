import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Botão moderno com gradiente e efeitos
class ModernButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isOutlined;
  final bool isGradient;
  final IconData? icon;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  const ModernButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.isGradient = false,
    this.icon,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 8),
        ],
        Text(label),
      ],
    );

    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        child: SizedBox(
          width: width,
          height: height,
          child: Center(child: buttonContent),
        ),
      );
    }

    if (isGradient) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Center(child: buttonContent),
          ),
        ),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(child: buttonContent),
      ),
    );
  }
}

/// Card moderno com efeito glassmorphism
class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool hasBorder;

  const GlassCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(24),
    this.onTap,
    this.borderRadius = 16,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.darkCard.withOpacity(0.7),
          borderRadius: BorderRadius.circular(borderRadius),
          border: hasBorder
              ? Border.all(
                  color: AppColors.border.withOpacity(0.5),
                  width: 1.5,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// Card com gradiente de fundo
class GradientCard extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final double borderRadius;

  const GradientCard({
    Key? key,
    required this.child,
    required this.gradient,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(24),
    this.onTap,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 24,
              spreadRadius: 0,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

/// Seção com título e descrição
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showLine;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.showLine = true,
    this.alignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          children: [
            if (showLine)
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        if (showLine) ...[
          const SizedBox(height: 24),
          Container(
            height: 1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.accent,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Chip moderno com ícone
class ModernChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final bool selected;

  const ModernChip({
    Key? key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? (selected ? AppColors.primary : AppColors.darkCard);
    final fgColor = foregroundColor ?? (selected ? Colors.white : AppColors.textSecondary);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: fgColor),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: fgColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Texto com gradiente
class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle? style;
  final TextAlign textAlign;

  const GradientText(
    this.text, {
    Key? key,
    required this.gradient,
    this.style,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        textAlign: textAlign,
        style: (style ?? const TextStyle()).copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Ícone com fundo arredondado
class IconBox extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final double iconSize;
  final VoidCallback? onTap;

  const IconBox({
    Key? key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.iconSize = 24,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boxSize = size ?? 48;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.darkCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.border.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? AppColors.primary,
        ),
      ),
    );
  }
}

/// Divider com label no centro
class LabeledDivider extends StatelessWidget {
  final String label;
  final double height;
  final Color? color;

  const LabeledDivider({
    Key? key,
    required this.label,
    this.height = 1,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: height,
            color: color ?? AppColors.divider,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: Container(
            height: height,
            color: color ?? AppColors.divider,
          ),
        ),
      ],
    );
  }
}
