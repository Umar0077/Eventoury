import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:eventoury/web/Traveller/explore%20categories/backend/explore_categories_controller.dart';
import 'package:eventoury/web/Traveller/home/backend/web_home_controller.dart';
import 'package:eventoury/web/Traveller/settings/frontend/settingsweb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/top%20and%20Bottom%20bar/top%20bar%20web/topbarwidget.dart';
import 'package:eventoury/web/top%20and%20Bottom%20bar/bottom%20bar%20web/bottombarwidget.dart';


class ExploreCategoriesScreen extends StatelessWidget {
  const ExploreCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExploreCategoriesController());
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
  // Responsive breakpoints
  final isDesktop = screenWidth > 1200;
  final isTablet = screenWidth > 768 && screenWidth <= 1200;
  final isMobile = screenWidth <= 768;
    
    // Responsive padding
    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Top Navigation Bar (shared)
          TopBarWidget(activeItem: 'Explore'),
          
          // Mobile Menu (appears when menu is open on mobile)
          if (isMobile)
            Obx(() => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: controller.isMobileMenuOpen.value ? null : 0,
              child: controller.isMobileMenuOpen.value 
                ? _buildMobileMenu(theme, controller)
                : const SizedBox.shrink(),
            )),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button and Title
                  _buildHeader(theme, screenWidth),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),
                  
                  // Categories Grid
                  _buildCategoriesGrid(controller, theme, screenWidth),
                  SizedBox(height: isDesktop ? 60 : isTablet ? 40 : 30),
                  
                  // Footer
                  const BottomBarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Top nav replaced by shared TopBarWidget

  Widget _buildMobileMenu(ThemeData theme, ExploreCategoriesController controller) {
    final menuItems = ['Home', 'Explore', 'Hot Deals', 'Settings', 'About', 'Contact'];
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isActive = index == 1; // Explore is active
          
          return InkWell(
            onTap: () {
              controller.toggleMobileMenu(); // Close menu when item is tapped
              // If a WebHomeController exists, update its active nav so the top bar highlights correctly
              try {
                final homeCtrl = Get.find<WebHomeController>();
                homeCtrl.setActiveNav(item);
              } catch (_) {}
              switch (item) {
                case 'Home':
                  if (Get.currentRoute != '/WebHomeScreen') Get.offAllNamed('/WebHomeScreen');
                  break;
                case 'Explore':
                  // already on explore
                  break;
                case 'Hot Deals':
                  if (Get.currentRoute != '/WebHomeScreen') Get.offAllNamed('/WebHomeScreen', arguments: {'scrollToHotDeals': true});
                  break;
                case 'Settings':
                  Get.to(() => const SettingsWeb());
                  break;
                case 'About':
                  if (Get.currentRoute != '/WebHomeScreen') Get.offAllNamed('/WebHomeScreen', arguments: {'scrollToAbout': true});
                  break;
                case 'Contact':
                  if (Get.currentRoute != '/WebHomeScreen') Get.offAllNamed('/WebHomeScreen', arguments: {'scrollToContact': true});
                  break;
                default:
                  break;
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? EventouryColors.persimmon : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, double screenWidth) {
  final isDesktop = screenWidth > 1200;
  final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: theme.iconTheme.color,
            size: isDesktop ? 24 : 20,
          ),
          padding: EdgeInsets.zero,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categorize',
              style: TextStyle(
                fontSize: isDesktop ? 32 : isTablet ? 28 : 24,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.headlineLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Explore All Categorize',
              style: TextStyle(
                fontSize: isDesktop ? 18 : isTablet ? 16 : 14,
                fontWeight: FontWeight.w500,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid(ExploreCategoriesController controller, ThemeData theme, double screenWidth) {
  final isDesktop = screenWidth > 1200;
  final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    // Responsive grid configuration
    int crossAxisCount;
    double childAspectRatio;
    double spacing;
    
    if (isDesktop) {
      crossAxisCount = 3;
      childAspectRatio = 1.8;
      spacing = 24;
    } else if (isTablet) {
      crossAxisCount = 2;
      childAspectRatio = 1.6;
      spacing = 20;
    } else {
      crossAxisCount = 1;
      childAspectRatio = 2.2;
      spacing = 16;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: controller.categories.length,
      itemBuilder: (context, index) {
        final category = controller.categories[index];
        return _buildCategoryCard(category, controller, theme, screenWidth);
      },
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, ExploreCategoriesController controller, ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background Image
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(category['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Dark overlay
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: EdgeInsets.all(isDesktop ? 24 : isTablet ? 20 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    category['title'],
                    style: TextStyle(
                      fontSize: isDesktop ? 24 : isTablet ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 12 : 8),
                  
                  // Description
                  Expanded(
                    child: Text(
                      category['description'],
                      style: TextStyle(
                        fontSize: isDesktop ? 16 : isTablet ? 14 : 13,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: isDesktop ? 20 : 16),
                  
                  // Explore Button
                  SizedBox(
                    width: isDesktop ? 110 : isTablet ? 100 : 90,
                    height: isDesktop ? 40 : isTablet ? 36 : 32,
                    child: EventouryElevatedButton(
                      onPressed: () => controller.onCategoryTap(category['title']),
                      borderRadius: BorderRadius.circular(isDesktop ? 20 : 18),
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 16 : 12,
                        vertical: isDesktop ? 8 : 6,
                      ),
                      child: Text(
                        'Explore →',
                        style: TextStyle(
                          fontSize: isDesktop ? 12 : isTablet ? 11 : 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
