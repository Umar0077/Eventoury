import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Simple, reusable bottom bar for web screens.
class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < 720;

  // Use theme colors so the bottom bar adapts to light/dark themes.
  // Use scaffoldBackgroundColor so the footer blends with page background.
  final bgColor = theme.scaffoldBackgroundColor; // background of the footer
    final primaryTextColor = theme.colorScheme.onSurface; // main text/icons
  final secondaryTextColor = theme.colorScheme.onSurface.withOpacity(0.75);

    final leftLinks = Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      children: [
        _linkText(context, 'Privacy Policy', onTap: () {}),
        _linkText(context, 'Terms and Conditions', onTap: () {}),
      ],
    );

    final center = Text(
      '© ${DateTime.now().year} Eventoury. All Rights Reserved.',
      style: theme.textTheme.bodyMedium?.copyWith(color: primaryTextColor, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );

    final right = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _iconCircle(FontAwesomeIcons.linkedin, onTap: () {}),
            const SizedBox(width: 8),
            _iconCircle(FontAwesomeIcons.instagram, onTap: () {}),
            const SizedBox(width: 8),
            _iconCircle(FontAwesomeIcons.tiktok, onTap: () {}),
          ],
        ),
        const SizedBox(height: 6),
        Text('info@eventoury.com', style: theme.textTheme.bodySmall?.copyWith(color: secondaryTextColor)),
      ],
    );

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: isNarrow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Links
                leftLinks,
                const SizedBox(height: 12),
                // Center copyright
                center,
                const SizedBox(height: 12),
                // Icons centered
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _iconCircle(FontAwesomeIcons.linkedin, onTap: () {}),
                  const SizedBox(width: 8),
                  _iconCircle(FontAwesomeIcons.instagram, onTap: () {}),
                  const SizedBox(width: 8),
                  _iconCircle(FontAwesomeIcons.tiktok, onTap: () {}),
                ]),
                const SizedBox(height: 8),
                Text('info@eventoury.com', style: theme.textTheme.bodySmall?.copyWith(color: secondaryTextColor)),
              ],
            )
          : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [leftLinks, center, right]),
    );
  }

  Widget _linkText(BuildContext context, String text, {VoidCallback? onTap}) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurface.withOpacity(0.75);
    return InkWell(
      onTap: onTap,
      child: Text(text, style: TextStyle(color: color, decoration: TextDecoration.underline)),
    );
  }

  static Widget _iconCircle(IconData icon, {VoidCallback? onTap}) {
    return Builder(builder: (context) {
      final theme = Theme.of(context);
      final iconBg = theme.colorScheme.onSurface.withOpacity(0.06);
      final iconColor = theme.colorScheme.onSurface;
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(shape: BoxShape.circle, color: iconBg),
          child: FaIcon(icon, color: iconColor, size: 16),
        ),
      );
    });
  }
}
 
