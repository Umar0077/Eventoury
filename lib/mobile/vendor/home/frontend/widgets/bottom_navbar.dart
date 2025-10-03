import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';

class VendorBottomNavigation extends StatelessWidget {
  const VendorBottomNavigation({
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
            painter: MyCustomPainter(context),
          ),
          Center(
            heightFactor: 0.6,
            child: Container(
              width: 56, // default FAB size
              height: 56,
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
              ),
              child: RawMaterialButton(
                shape: const CircleBorder(),
                elevation: 1,
                onPressed: () => onTap(2),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home_outlined, 0, context),
                _buildNavItem(Icons.bar_chart_rounded, 1, context),
                SizedBox(width: 60), // Space for center button
                _buildNavItem(Icons.calendar_month_outlined, 3, context),
                _buildNavItem(Icons.person_outline_rounded, 4, context),
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
        return 'Home';
      case 1:
        return 'Insights';
      case 3:
        return 'Booking';
      case 4:
        return 'Profile';
      default:
        return '';
    }
  }
}

class MyCustomPainter extends CustomPainter {
  final BuildContext context;
  MyCustomPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Create the main path
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(
      Offset(size.width * 0.60, 20),
      radius: Radius.circular(10.0),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Draw solid black fill inside the arc
    Paint fillPaint = Paint()
      ..color = isDark ? Colors.black : Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
