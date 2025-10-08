import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/theme/elevated_button_theme.dart';

class AdminCustomBottomNavigation extends StatelessWidget {
  const AdminCustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      color: Colors.transparent,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: AdminCustomPainter(context),
          ),
          Center(
            heightFactor: 0.45,
            child: SizedBox(
              width: 60,
              height: 60,
              child: EventouryElevatedButton(
                onPressed: () => onTap(99), // special action for add
                borderRadius: BorderRadius.circular(30),
                padding: const EdgeInsets.all(0),
                child: const Icon(Icons.add, color: Colors.white, size: 26),
              ),
            ),
          ),
          SizedBox(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.dashboard_outlined, 0, context),
                _buildNavItem(Icons.manage_accounts_outlined, 1, context),
                SizedBox(width: 72), // Space for center button
                _buildNavItem(Icons.analytics_outlined, 2, context),
                _buildNavItem(Icons.person_outline, 3, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, BuildContext context) {
    final isSelected = selectedIndex == index;
    final brightness = Theme.of(context).brightness;
    final color = brightness == Brightness.dark ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return isSelected
                  ? const LinearGradient(
                      colors: [
                        EventouryColors.tangerine,
                        EventouryColors.tangerine,
                        EventouryColors.persimmon,
                        EventouryColors.electric_orange,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds)
                  : LinearGradient(colors: [color, color]).createShader(bounds);
            },
            child: Icon(
              icon,
              color: Colors.white, // base color for ShaderMask
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return isSelected
                  ? const LinearGradient(
                      colors: [
                        EventouryColors.tangerine,
                        EventouryColors.tangerine,
                        EventouryColors.persimmon,
                        EventouryColors.electric_orange,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds)
                  : LinearGradient(colors: [color, color]).createShader(bounds);
            },
            child: Text(
              _getLabel(index),
              style: TextStyle(
                color: Colors.white, // base color, overridden by ShaderMask
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Manage';
      case 2:
        return 'Insights';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }
}

class AdminCustomPainter extends CustomPainter {
  final BuildContext context;
  AdminCustomPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Create the main path (rounded top with a center notch)
  final double notchRadius = 34.0;
    final double centerStart = size.width * 0.40;
    final double centerEnd = size.width * 0.60;

    Path path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, centerStart - 10, 0);
    // left arc into notch
    path.arcToPoint(Offset(centerStart + 6, notchRadius * 0.18), radius: Radius.circular(8), clockwise: false);
    // notch (approx)
    path.arcToPoint(Offset(centerEnd - 6, notchRadius * 0.18), radius: Radius.circular(notchRadius), clockwise: true);
    // right arc out of notch
    path.arcToPoint(Offset(centerEnd + 10, 0), radius: Radius.circular(8), clockwise: false);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

  // fill with theme-aware background
  final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;
  // In light theme make the bar a touch different from the scaffold so it stands out slightly.
  final bg = isDark
    ? Theme.of(context).cardColor
    : Color.lerp(scaffoldBg, Colors.grey.shade100, 0.06)!;
  Paint fillPaint = Paint()..color = bg..style = PaintingStyle.fill;

    // draw subtle shadow for the curved bar
    canvas.drawShadow(path, Colors.black.withOpacity(isDark ? 0.6 : 0.12), 8.0, true);
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// A simplified bottom navigation shown on pushed admin pages.
/// Shows only a Home icon and the center add button. Home pops back to the dashboard root.
class AdminChildBottomNavigation extends StatelessWidget {
  const AdminChildBottomNavigation({super.key, required this.selectedIndex, required this.onTap});

  final int selectedIndex;
  final Function(int) onTap; // 0..3 select tabs, 99 = add

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      color: Colors.transparent,
      child: Stack(
        children: [
          CustomPaint(size: Size(size.width, 80), painter: AdminCustomPainter(context)),
          Center(
            heightFactor: 0.45,
            child: SizedBox(
              width: 60,
              height: 60,
              child: EventouryElevatedButton(
                onPressed: () => onTap(99),
                borderRadius: BorderRadius.circular(30),
                padding: const EdgeInsets.all(0),
                child: const Icon(Icons.add, color: Colors.white, size: 26),
              ),
            ),
          ),
          SizedBox(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _childNavItem(context, Icons.dashboard_outlined, 0),
                _childNavItem(context, Icons.manage_accounts_outlined, 1),
                SizedBox(width: 72),
                _childNavItem(context, Icons.analytics_outlined, 2),
                _childNavItem(context, Icons.person_outline, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _childNavItem(BuildContext context, IconData icon, int idx) {
    final isSelected = selectedIndex == idx;
    final color = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    return GestureDetector(
      onTap: () => onTap(idx),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) => LinearGradient(colors: [isSelected ? EventouryColors.tangerine : color, isSelected ? EventouryColors.persimmon : color]).createShader(bounds),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            idx == 0 ? 'Dashboard' : idx == 1 ? 'Manage' : idx == 2 ? 'Insights' : 'Profile',
            style: TextStyle(color: color, fontSize: 12, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
