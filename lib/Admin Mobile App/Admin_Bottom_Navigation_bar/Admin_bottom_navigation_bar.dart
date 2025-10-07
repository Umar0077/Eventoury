import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

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
            child: Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    EventouryColors.tangerine,
                    EventouryColors.persimmon,
                    EventouryColors.electric_orange,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: RawMaterialButton(
                shape: const CircleBorder(),
                elevation: 2,
                onPressed: () => onTap(2),
                child: const Icon(Icons.search, color: Colors.white, size: 30),
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
                _buildNavItem(Icons.people_outline_rounded, 1, context),
                SizedBox(width: 88), // Space for center button
                _buildNavItem(Icons.analytics_outlined, 3, context),
                _buildNavItem(Icons.settings_outlined, 4, context),
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
        return 'Users';
      case 3:
        return 'Analytics';
      case 4:
        return 'Settings';
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
    final double notchRadius = 38.0;
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
    final bg = isDark ? Theme.of(context).cardColor : Colors.white;
    Paint fillPaint = Paint()..color = bg..style = PaintingStyle.fill;

    // draw subtle shadow for the curved bar
    canvas.drawShadow(path, Colors.black.withOpacity(isDark ? 0.6 : 0.12), 8.0, true);
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
