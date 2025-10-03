import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      colors: [
        EventouryColors.electric_orange,
        EventouryColors.persimmon,
        EventouryColors.tangerine,
        EventouryColors.tangerine,
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                const TextSpan(text: "Your concierge to\ncultures & "),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ShaderMask(
                      shaderCallback: (bounds) => gradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "celebrations",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image(image: AssetImage("assets/home_screen/line.png")),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),
        ],
      ),
    );
  }
}