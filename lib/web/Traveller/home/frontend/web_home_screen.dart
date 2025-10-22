import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/web/Traveller/explore%20categories/frontend/explore_categories.dart';
import 'package:eventoury/web/Traveller/home/backend/web_home_controller.dart';
import 'package:eventoury/web/Traveller/settings/frontend/settingsweb.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eventoury/utils/theme/elevated_button_theme.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  late final WebHomeController controller;
  late final ScrollController scrollController;

  // Per-instance GlobalKeys to avoid reusing the same GlobalKey across
  // multiple widget instances (which causes the 'Multiple widgets used the same GlobalKey' error).
  final GlobalKey _exploreKey = GlobalKey();
  final GlobalKey _hotDealsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = Get.put(WebHomeController());
    scrollController = ScrollController();

    // Register local keys with controller so scroll helpers still work.
    controller.registerExploreKey(_exploreKey);
    controller.registerHotDealsKey(_hotDealsKey);
    controller.registerAboutKey(_aboutKey);
    controller.registerFooterKey(_footerKey);

    // Handle incoming arguments requesting a post-navigation scroll.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Get.arguments;
      if (args is Map) {
        if (args['scrollToContact'] == true) {
          controller.scrollToContact();
        } else if (args['scrollToHotDeals'] == true) {
          controller.scrollToHotDeals();
        } else if (args['scrollToAbout'] == true) {
          controller.scrollToAbout();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark; // unused
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
          // Top Navigation Bar
          TopBarWidget(activeItem: 'Home'),

          // Mobile Menu (appears when menu is open on mobile)
          if (isMobile)
            Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: controller.isMobileMenuOpen.value ? null : 0,
                  child: controller.isMobileMenuOpen.value ? _buildMobileMenu(theme, controller) : const SizedBox.shrink(),
                )),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Section
                  _buildHeroSection(controller, theme, screenWidth),
                  SizedBox(height: isDesktop ? 80 : isTablet ? 60 : 40),

                  // Explore Section
                  Container(key: _exploreKey, child: _buildExploreSection(controller, theme, screenWidth, context)),
                  SizedBox(height: isDesktop ? 80 : isTablet ? 60 : 40),

                  // Hot Deals Section
                  Container(key: _hotDealsKey, child: _buildHotDealsSection(controller, theme, screenWidth)),
                  SizedBox(height: isDesktop ? 60 : isTablet ? 40 : 30),

                  // About Section (placed under Hot Deals)
                  Container(key: _aboutKey, child: _buildAboutSection(theme, screenWidth)),
                  SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),

                  // Footer
                  Container(key: _footerKey, child: const BottomBarWidget()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  

  

  Widget _buildMobileMenu(ThemeData theme, WebHomeController controller) {
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
          final isActive = index == 0; // Home is active
          
          return InkWell(
            onTap: () {
              controller.toggleMobileMenu(); // Close menu when item is tapped
              // Set active nav immediately
              controller.setActiveNav(item);

              switch (item) {
                case 'Home':
                  // navigate to home (if already on home, this is a no-op)
                  Get.to(() => const WebHomeScreen());
                  break;
                case 'Explore':
                  Get.to(() => const ExploreCategoriesScreen());
                  break;
                case 'Hot Deals':
                  // If we're on Home, just scroll; otherwise navigate to Home and request scroll
                  controller.scrollToHotDeals();
                  Get.to(() => const WebHomeScreen(), arguments: {'scrollToHotDeals': true});
                  break;
                case 'Settings':
                  Get.to(() => const SettingsWeb());
                  break;
                case 'About':
                  Get.to(() => const WebHomeScreen(), arguments: {'scrollToAbout': true});
                  break;
                case 'Contact':
                  Get.to(() => const WebHomeScreen(), arguments: {'scrollToContact': true});
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

  

  Widget _heroImage(String imagePath, double height, double borderRadius) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(WebHomeController controller, ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;
    
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Mobile title
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                  height: 1.1,
                ),
                children: [
                  const TextSpan(text: 'Your concierge to\ncultures & '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            EventouryColors.electric_orange,
                            EventouryColors.persimmon,
                            EventouryColors.tangerine,
                            EventouryColors.tangerine,
                          ],
                        ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "celebrations",
                              style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Image(image: AssetImage("assets/home_screen/line.png")),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Mobile images grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _heroImage('assets/onboarding_images/onboarding_1.jpeg', 120, 12),
              _heroImage('assets/onboarding_images/onboarding_2.jpeg', 120, 12),
              _heroImage('assets/onboarding_images/onboarding_3.jpeg', 120, 12),
              _heroImage('assets/onboarding_images/onboarding_4.jpeg', 120, 12),
            ],
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Content
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: isDesktop ? 60 : isTablet ? 48 : 36,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.titleLarge?.color,
                    height: 1.1,
                  ),
                  children: [
                    const TextSpan(text: 'Your concierge to\ncultures & '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              EventouryColors.electric_orange,
                              EventouryColors.persimmon,
                              EventouryColors.tangerine,
                              EventouryColors.tangerine,
                            ],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "celebrations",
                                style: theme.textTheme.titleLarge?.copyWith(
                                    fontSize: isDesktop ? 60 : isTablet ? 48 : 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Image(image: AssetImage("assets/home_screen/line.png")),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        
        // Right Images
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _heroImage('assets/onboarding_images/onboarding_1.jpeg', isDesktop ? 200 : 150, 16),
                    const SizedBox(height: 16),
                    _heroImage('assets/onboarding_images/onboarding_2.jpeg', isDesktop ? 140 : 100, 16),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    _heroImage('assets/onboarding_images/onboarding_3.jpeg', isDesktop ? 140 : 100, 16),
                    const SizedBox(height: 16),
                    _heroImage('assets/onboarding_images/onboarding_4.jpeg', isDesktop ? 200 : 150, 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExploreSection(WebHomeController controller, ThemeData theme, double screenWidth, BuildContext context) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Explore',
              style: TextStyle(
                fontSize: isDesktop ? 32 : isTablet ? 28 : 24,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => const ExploreCategoriesScreen());
              },
              child: Text(
                'View all',
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 14,
                  color: EventouryColors.persimmon,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),
        // Show all 13 categories in horizontal scroll
        Container(
          height: isDesktop ? 240 : isTablet ? 220 : 200,
          child: Stack(
            children: [
              ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth > 1200 ? 220 : screenWidth > 768 ? 200 : 180,
                    margin: const EdgeInsets.only(right: 16),
                    child: _buildCategoryCard(controller.categories[index], index, controller, theme, false, context),
                  );
                },
              ),
              // Right fade indicator for scrolling
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        theme.scaffoldBackgroundColor.withOpacity(0),
                        theme.scaffoldBackgroundColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String category, int index, WebHomeController controller, ThemeData theme, bool isMobile, BuildContext context) {
    // Map categories to their respective images
    final categoryImages = {
      'Activities': 'assets/onboarding_images/onboarding_1.jpeg',
      'Lessons/Classes': 'assets/onboarding_images/onboarding_2.jpeg',
      'Transportation': 'assets/home_screen/transport.jpg',
      'Guide': 'assets/onboarding_images/onboarding_3.jpeg',
      'Accommodation': 'assets/onboarding_images/onboarding_4.jpeg',
      'Entertainment': 'assets/onboarding_images/onboarding_5.jpeg',
      'Tourist Attraction Spots': 'assets/onboarding_images/onboarding_6.jpeg',
      'Fitness and Wellbeing': 'assets/onboarding_images/onboarding_1.jpeg',
      'Cultural, Heritage, and History': 'assets/onboarding_images/onboarding_2.jpeg',
      'Tickets': 'assets/onboarding_images/onboarding_3.jpeg',
      'Events': 'assets/home_screen/events.jpg',
      'Tour Packages': 'assets/home_screen/tour_packages.jpeg',
      'VIP Protocol': 'assets/onboarding_images/onboarding_4.jpeg',
    };

    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamic padding based on screen width
    double cardPadding;
    if (screenWidth <= 480) {
      cardPadding = 8; // Small phones
    } else if (screenWidth <= 768) {
      cardPadding = 10; // Large phones/small tablets
    } else if (screenWidth <= 1024) {
      cardPadding = 12; // Tablets
    } else if (screenWidth <= 1440) {
      cardPadding = 16; // Small desktop
    } else {
      cardPadding = 20; // Large desktop
    }

    return GestureDetector(
      onTap: () {
        // Handle navigation or other actions here
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 8),
        height: isMobile ? 180 : double.infinity,
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.15) : Colors.black.withOpacity(0.15),
              blurRadius: 16,
              spreadRadius: 2,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image container - takes most of the space
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(categoryImages[category] ?? 'assets/onboarding_images/onboarding_1.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),
            // Text section - fixed height for text
            SizedBox(
              height: isMobile ? 40 : 44,
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotDealsSection(WebHomeController controller, ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hot Deals',
              style: TextStyle(
                fontSize: isDesktop ? 32 : isTablet ? 28 : 24,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 14,
                  color: EventouryColors.persimmon,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),
        Obx(() {
          if (isMobile) {
            return Column(
              children: List.generate(controller.hotDeals.length, (index) {
                final deal = controller.hotDeals[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: _buildDealCard(deal, index, controller, theme, true),
                );
              }),
            );
          }
          
          return Row(
            children: List.generate(controller.hotDeals.length, (index) {
              final deal = controller.hotDeals[index];
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildDealCard(deal, index, controller, theme, false),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildAboutSection(ThemeData theme, double screenWidth) {
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;

    final horizontalPadding = isDesktop ? 0.0 : 0.0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 40 : isTablet ? 30 : 20, horizontal: horizontalPadding),
      child: isMobile
          ? Column(
              children: [
                Text(
                  'About Us',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color),
                ),
                const SizedBox(height: 12),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse a sapien justo. Nulla facilisi tristique imperdiet. Nullam a placerat odio. Sed in ex augue. Aliquam porta consectetur lorem sit amet ultrices. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
                  style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color, height: 1.6),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                EventouryElevatedButton(onPressed: () {}, child: const Text('Read more →')),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 18, offset: Offset(0, 8)),
                    ],
                  ),
                  child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset('assets/onboarding_images/onboarding_4.jpeg')),
                ),
              ],
            )
          : Row(
              children: [
                // Left text
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Us',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color),
                      ),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 560),
                        child: Text(
                          'At Eventoury, we believe travel is more than just visiting new places — it is about creating lasting memories. Our platform connects travelers with trusted vendors, offering curated packages that include breathtaking destinations, comfortable stays, and unforgettable experiences. We are dedicated to making trip planning simple, transparent, and stress-free. With easy booking, clear pricing, and detailed itineraries, travelers can focus on enjoying their journey while we handle the rest. Whether it’s a city tour, a cultural escape, or an adventure in the mountains, Eventoury is here to bring your dream trips to life.',
                          style: TextStyle(fontSize: 16, color: theme.textTheme.bodyMedium?.color, height: 1.6),
                        ),
                      ),
                      const SizedBox(height: 20),
                      EventouryElevatedButton(onPressed: () {}, child: const Text('Read more →')),
                    ],
                  ),
                ),

                const SizedBox(width: 40),

                // Right image
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 22, offset: Offset(0, 12)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/onboarding_images/onboarding_4.jpeg', fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildDealCard(Map<String, dynamic> deal, int index, WebHomeController controller, ThemeData theme, bool isMobile) {
    // Card background: white for light theme, dark grey for dark theme
    final bool isDark = theme.brightness == Brightness.dark;
    final Color cardBg = isDark ? const Color(0xFF2D2D2D) : Colors.white;
    final Color contentText = isDark ? Colors.white : Colors.black;
    final Color contentSubText = isDark ? Colors.white70 : Colors.black54;

    // Add a surrounding container with layered shadows to give a stronger 3D effect.
    final Color shadowPrimary = isDark ? Colors.black.withOpacity(0.6) : Colors.black.withOpacity(0.12);
    final Color shadowSecondary = isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.06);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: shadowPrimary, blurRadius: 20, offset: const Offset(0, 12)),
          BoxShadow(color: shadowSecondary, blurRadius: 8, offset: const Offset(0, 6)),
        ],
      ),
      child: Card(
        color: cardBg,
        elevation: 6,
        shadowColor: isDark ? Colors.black : Colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: isMobile ? 180 : 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(deal['image']),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () => controller.toggleFavorite(index),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Icon(
                        deal['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                        color: deal['isFavorite'] ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Container(
            padding: EdgeInsets.all(isMobile ? 16 : 20),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deal['title'],
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: contentText,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${deal['beach']} • ',
                        style: TextStyle(
                          fontSize: 14,
                          color: contentSubText,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (deal['wifi'])
                      Text(
                        'Free WiFi',
                        style: TextStyle(
                          fontSize: 14,
                          color: contentSubText,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ...List.generate(5, (starIndex) {
                      return Icon(
                        starIndex < deal['rating'].floor() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        deal['rating'].toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: contentText,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.location_on, color: contentSubText, size: 16),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        deal['location'],
                        style: TextStyle(
                          fontSize: 14,
                          color: contentSubText,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }

  // Footer removed; replaced by BottomBarWidget
}