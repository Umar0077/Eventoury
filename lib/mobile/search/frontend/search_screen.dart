import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final cardColor = theme.cardColor;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Search', style: textTheme.titleLarge),
                SizedBox(height: 20,),
                // Search Bar
                TextField(
                  style: textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Search events, places, activities...',
                    hintStyle: textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                    prefixIcon: Icon(Icons.search, color: EventouryColors.tangerine),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: primaryColor.withOpacity(0.1)),
                    ),
                    filled: true,
                    fillColor: cardColor.withOpacity(0.08),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  ),
                ),
                const SizedBox(height: 20),
      
                // Search Categories
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildSearchCategory(
                        icon: Icons.event,
                        title: 'Events',
                        color: EventouryColors.tangerine,
                        textTheme: textTheme,
                        cardColor: cardColor,
                        context: context,
                      ),
                      _buildSearchCategory(
                        icon: Icons.place,
                        title: 'Places',
                        color: EventouryColors.tangerine,
                        textTheme: textTheme,
                        cardColor: cardColor,
                        context: context,
                      ),
                      _buildSearchCategory(
                        icon: Icons.restaurant,
                        title: 'Restaurants',
                        color: EventouryColors.tangerine,
                        textTheme: textTheme,
                        cardColor: cardColor,
                        context: context,
                      ),
                      _buildSearchCategory(
                        icon: Icons.hotel,
                        title: 'Hotels',
                        color: EventouryColors.tangerine,
                        textTheme: textTheme,
                        cardColor: cardColor,
                        context: context,
                      ),
                      _buildSearchCategory(
                        icon: Icons.local_activity,
                        title: 'Activities',
                        color: EventouryColors.tangerine,
                        textTheme: textTheme,
                        cardColor: cardColor,
                        context: context,
                      ),
                      _buildSearchCategory(
                        icon: Icons.directions_car,
                        title: 'Transport',
                        color: EventouryColors.tangerine,
                        textTheme: textTheme,
                        cardColor: cardColor,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchCategory({
    required IconData icon,
    required String title,
    required Color color,
    required TextTheme textTheme,
    required Color cardColor,
    required BuildContext context,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        elevation: 1,
        shadowColor: isDarkMode ? Colors.white : Colors.black,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 38, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
