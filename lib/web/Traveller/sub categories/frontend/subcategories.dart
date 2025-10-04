import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/top%20and%20Bottom%20bar/top%20bar%20web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';
import 'package:eventoury/web/Traveller/sub%20categories/backend/subcategories_controller.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';

class SubcategoriesScreen extends StatelessWidget {
  final String categoryTitle;

  const SubcategoriesScreen({super.key, this.categoryTitle = 'Event'});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubcategoriesController());
    controller.setCategoryTitle(categoryTitle);
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    // Improved responsive padding
    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : screenWidth > 600 ? 24.0 : 16.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          TopBarWidget(onMenuToggle: controller.toggleMobileMenu, isMobileMenuOpen: controller.isMobileMenuOpen),

          if (screenWidth <= 768)
            Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: controller.isMobileMenuOpen.value ? null : 0,
                  child: controller.isMobileMenuOpen.value ? _buildMobileMenu(theme, controller) : const SizedBox.shrink(),
                )),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, theme, screenWidth, controller),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),
                  _buildEventsGrid(controller, theme, screenWidth),
                  SizedBox(height: isDesktop ? 60 : isTablet ? 40 : 30),
                  const BottomBarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsGrid(SubcategoriesController controller, ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    // Improved responsive grid configuration - Always 2 cards per row
    int crossAxisCount;
    double spacing;
    double aspectRatio;
    
    if (isDesktop) {
      crossAxisCount = 4;
      spacing = 20;
      aspectRatio = 0.9; // Adjusted for taller content with bigger buttons
    } else if (isTablet) {
      crossAxisCount = 3;
      spacing = 16;
      aspectRatio = 0.85; // Adjusted for taller content
    } else {
      crossAxisCount = 2; // Always 2 cards per row on mobile
      spacing = 12;
      aspectRatio = 0.75; // Taller cards for mobile with bigger buttons
    }

  return Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: controller.events.length,
            itemBuilder: (context, index) {
            final event = controller.events[index];
            return _buildEventCard(event, index, controller, theme, screenWidth);
          },
        ));
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, double screenWidth, SubcategoriesController controller) {
    return Row(
      children: [
        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: theme.iconTheme.color)),
        const SizedBox(width: 12),
        Text(controller.categoryTitle.value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _buildMobileMenu(ThemeData theme, SubcategoriesController controller) {
    return Container(
      color: theme.cardColor,
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextButton(onPressed: () {}, child: const Text('Home')),
        TextButton(onPressed: () {}, child: const Text('Profile')),
        TextButton(onPressed: () {}, child: const Text('Settings')),
      ]),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event, int index, SubcategoriesController controller, ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDarkTheme ? [
          // White shadows for dark theme
          BoxShadow(color: Colors.white.withOpacity(0.1), blurRadius: 18, offset: const Offset(0, 12)),
          BoxShadow(color: Colors.white.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 6)),
          BoxShadow(color: Colors.white.withOpacity(0.03), blurRadius: 3, offset: const Offset(0, 3)),
        ] : [
          // Default black shadows for light theme
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 12)),
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 6)),
        ],
      ),
      child: Card(
        color: theme.scaffoldBackgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section - more compact
            Expanded(
              flex: 7, // More space for image, less for content
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  width: double.infinity,
                  child: Image.asset(
                    event['image'], 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // Content section - increased height for new button layout
            Container(
              height: isDesktop ? 150 : isTablet ? 140 : 130, // Increased height for new layout
              padding: EdgeInsets.all(isDesktop ? 12 : isTablet ? 10 : 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Prevent column from expanding
                children: [
                  // Title - more compact
                  Text(
                    event['title'],
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isDesktop ? 15 : isTablet ? 13 : 12, // Even smaller fonts
                    ),
                    maxLines: 1, // Single line to save space
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isDesktop ? 4 : 3), // Minimal spacing
                  
                  // Subtitle - more compact
                  Text(
                    event['subtitle'],
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                      fontSize: isDesktop ? 11 : isTablet ? 10 : 9, // Smaller subtitle fonts
                    ),
                    maxLines: 1, // Single line for compact layout
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isDesktop ? 6 : 4), // Minimal spacing
                  
                  // Rating section
                  Row(
                    children: [
                      ...List.generate(5, (i) => Icon(
                        i < (event['rating'] as double).floor() ? Icons.star : Icons.star_border, 
                        color: Colors.amber, 
                        size: isDesktop ? 14 : isTablet ? 13 : 12 // Slightly bigger stars
                      )),
                      const SizedBox(width: 4),
                      Text(
                        (event['rating'] as double).toString(), 
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600, 
                          fontSize: isDesktop ? 12 : isTablet ? 11 : 10 // Bigger rating text
                        )
                      ),
                    ],
                  ),
                  
                  SizedBox(height: isDesktop ? 8 : 6),
                  
                  // Price button - bigger and positioned at right bottom
                  Align(
                    alignment: Alignment.centerRight,
                    child: EventouryElevatedButton(
                      onPressed: () => controller.onEventTap(event['title']),
                      borderRadius: BorderRadius.circular(20),
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 16 : isTablet ? 14 : 12,
                        vertical: isDesktop ? 10 : isTablet ? 8 : 6
                      ),
                      child: Text(
                        // Show full "Price / Person" on desktop/tablet, just price on mobile
                        isDesktop || isTablet ? '${event['price']} / Person' : event['price'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isDesktop ? 14 : isTablet ? 12 : 10, // Bigger button text
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
