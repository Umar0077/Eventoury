import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/web/Traveller/explore%20categories/frontend/explore_categories.dart';
import 'package:eventoury/web/Traveller/HotDeals/frontendHotDeals.dart';
import 'package:eventoury/web/Traveller/Details/frontend/Details.dart';
import 'package:eventoury/web/Traveller/sub categories/frontend/subcategories.dart';
import 'package:eventoury/web/Traveller/home/backend/web_home_controller.dart';
import 'package:eventoury/web/Traveller/settings/frontend/settingsweb.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';
import 'package:eventoury/web/Traveller/AboutusSection/frontendAbout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eventoury/utils/theme/elevated_button_theme.dart';

// Small helper that scales its child slightly on mouse hover (web)
class _HoverScale extends StatefulWidget {
  final Widget child;
  const _HoverScale({Key? key, required this.child}) : super(key: key);

  @override
  State<_HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<_HoverScale> {
  bool _hover = false;
  static const double _scale = 1.04;
  static const Duration _duration = Duration(milliseconds: 150);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_hover ? _scale : 1.0),
        child: widget.child,
      ),
    );
  }
}

// Shared card decoration used across home screen cards to provide a consistent
// shadow and rounded corner appearance similar to the Subcategories card style.
BoxDecoration _sharedCardDecoration(ThemeData theme, {double radius = 16.0}) {
  final isDark = theme.brightness == Brightness.dark;
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: isDark ? Colors.black.withOpacity(0.65) : Colors.black.withOpacity(0.12),
        blurRadius: 28,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: isDark ? Colors.black.withOpacity(0.35) : Colors.black.withOpacity(0.06),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
      BoxShadow(
        color: isDark ? Colors.black.withOpacity(0.18) : Colors.black.withOpacity(0.03),
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> with TickerProviderStateMixin {
  late final WebHomeController controller;
  late final ScrollController scrollController;
  late final ScrollController _exploreScrollController;
  AnimationController? _animController;
  AnimationController? _hotDealsAnimController;
  AnimationController? _aboutAnimController;

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
  _exploreScrollController = ScrollController();

  // Initialize animation controllers (use helper to make hot-reload safe)
  _ensureAnimController();
  _ensureSectionControllers();

  // listen for scroll to trigger appear animations when sections enter viewport
  scrollController.addListener(_onScroll);

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
    _exploreScrollController.dispose();
    _animController?.dispose();
    super.dispose();
  }

  void _ensureAnimController() {
    if (_animController == null) {
      _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          _animController?.forward();
        } catch (_) {}
      });
    }
  }

  void _ensureSectionControllers() {
    if (_hotDealsAnimController == null) {
      _hotDealsAnimController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    }
    if (_aboutAnimController == null) {
      _aboutAnimController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    }
    // check visibility once after init
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkSectionVisibility());
  }

  void _onScroll() {
    _checkSectionVisibility();
  }

  void _checkSectionVisibility() {
    try {
      final RenderBox? hotBox = _hotDealsKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? aboutBox = _aboutKey.currentContext?.findRenderObject() as RenderBox?;
      final viewportHeight = MediaQuery.of(context).size.height;
      if (hotBox != null && _hotDealsAnimController != null && _hotDealsAnimController!.status == AnimationStatus.dismissed) {
        final hotDy = hotBox.localToGlobal(Offset.zero).dy;
        if (hotDy < viewportHeight * 0.85) {
          _hotDealsAnimController?.forward();
        }
      }
      if (aboutBox != null && _aboutAnimController != null && _aboutAnimController!.status == AnimationStatus.dismissed) {
        final aboutDy = aboutBox.localToGlobal(Offset.zero).dy;
        if (aboutDy < viewportHeight * 0.85) {
          _aboutAnimController?.forward();
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    // Ensure animation controller exists (hot-reload safe)
    _ensureAnimController();
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark; // unused
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive breakpoints
  // Treat small laptops (>= 992px) as desktop for a consistent layout
  final isDesktop = screenWidth >= 992;
  final isTablet = screenWidth > 768 && screenWidth < 992;
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
                  // Slightly increased gap after Hero for improved separation
                  SizedBox(height: isDesktop ? 100 : isTablet ? 80 : 50),

                  // Explore Section
                  Container(key: _exploreKey, child: _buildExploreSection(controller, theme, screenWidth, context)),
                  // Slightly increased gap after Explore
                  SizedBox(height: isDesktop ? 100 : isTablet ? 80 : 50),

                  // Hot Deals Section
                  Container(key: _hotDealsKey, child: _buildHotDealsSection(controller, theme, screenWidth)),
                  // Increased gap after Hot Deals
                  SizedBox(height: isDesktop ? 80 : isTablet ? 60 : 40),

                  // About Section (placed under Hot Deals)
                  Container(key: _aboutKey, child: _buildAboutSection(theme, screenWidth)),
                  // Small gap after About before footer
                  SizedBox(height: isDesktop ? 60 : isTablet ? 40 : 30),

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
  final isDesktop = screenWidth >= 992;
  final isTablet = screenWidth > 768 && screenWidth < 992;
  final isMobile = screenWidth <= 768;
    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;

    if (isMobile) {
      // Keep previous compact mobile layout
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 28,
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
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'celebrations',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Image(image: AssetImage('assets/home_screen/line.png')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
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

    // Desktop/tablet: full-width hero with background image.
    // Translate left and up and expand size to cover parent padding so the
    // image reaches the page edges (top/right/left/bottom).
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;
  // Add a small buffer to fullWidth so the image definitely reaches the right
  // edge on different browsers / scrollbars. This avoids any visible white gap.
    final extraBuffer = isDesktop ? 240.0 : isTablet ? 200.0 : 100.0;
    final heroHeight = isDesktop ? 420.0 : isTablet ? 360.0 : 520.0;

    return SizedBox(
      width: double.infinity,
      height: heroHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background image positioned with negative offsets so it
          // overflows the hero on left/top/right/bottom and guarantees
          // there is no white gap on the right.
          Positioned(
            left: -horizontalPadding,
            top: -verticalPadding,
            right: -extraBuffer,
            bottom: -verticalPadding,
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width + horizontalPadding * 2 + extraBuffer,
                  height: heroHeight + verticalPadding * 2,
                  child: Image.asset('assets/home_screen/BBali.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
          ),

          // Gradient overlay removed to avoid a heavy black background behind the hero text.
          // Keeping an empty Positioned.fill preserves stacking order for the text.
          Positioned.fill(child: Container()),

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isDesktop ? 700 : isTablet ? 600 : 340),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: isDesktop ? 52 : isTablet ? 42 : 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'celebrations',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontSize: isDesktop ? 52 : isTablet ? 42 : 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Image(image: AssetImage('assets/home_screen/line.png')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreSection(WebHomeController controller, ThemeData theme, double screenWidth, BuildContext context) {
  final isDesktop = screenWidth >= 992;
  final isTablet = screenWidth > 768 && screenWidth < 992;
  final isMobile = screenWidth <= 768;
    
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
        // Show all 13 categories in horizontal scroll with overlay arrows
        Container(
          height: isDesktop ? 240 : isTablet ? 220 : 200,
          child: Stack(
            children: [
              ListView.builder(
                controller: _exploreScrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth >= 992 ? 220 : screenWidth > 768 ? 200 : 180,
                    margin: const EdgeInsets.only(right: 16),
                    child: _buildCategoryCard(controller.categories[index], index, controller, theme, false, context),
                  );
                },
              ),

              // Left/Right arrow controls for desktop/tablet
              if (!isMobile) ...[
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      final viewport = MediaQuery.of(context).size.width * 0.6;
                      _exploreScrollController.animateTo(
                        (_exploreScrollController.offset - viewport).clamp(0.0, _exploreScrollController.position.maxScrollExtent),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      );
                    },
                    child: Container(
                      width: 48,
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Icon(Icons.chevron_left, size: 40, color: theme.iconTheme.color),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      final viewport = MediaQuery.of(context).size.width * 0.6;
                      _exploreScrollController.animateTo(
                        (_exploreScrollController.offset + viewport).clamp(0.0, _exploreScrollController.position.maxScrollExtent),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      );
                    },
                    child: Container(
                      width: 48,
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Icon(Icons.chevron_right, size: 40, color: theme.iconTheme.color),
                    ),
                  ),
                ),
              ],

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

    // Responsive flags
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isSmallMobile = screenWidth <= 480;

  // Card shadow/colors are handled by shared decoration

    final imagePath = categoryImages[category] ?? 'assets/onboarding_images/onboarding_1.jpeg';

    return GestureDetector(
      onTap: () {
        // Navigate directly to the Subcategories screen for this category
        Get.to(() => SubcategoriesScreen(categoryTitle: category));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 8),
        height: isMobile ? 180 : double.infinity,
        decoration: _sharedCardDecoration(theme, radius: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              // Dark gradient to improve text contrast
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.45),
                        Colors.black.withOpacity(0.18),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),

              // Title & subtitle (top-left)
              Positioned(
                left: 16,
                top: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        color: Colors.white,
                        // Slightly reduced and made more responsive so long names wrap/fit better
                        fontSize: isDesktop ? 18 : isTablet ? 16 : isSmallMobile ? 13 : 14,
                        fontWeight: FontWeight.w700,
                        shadows: [const Shadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 4)],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Subtitle removed per design — keep title only on Explore cards
                  ],
                ),
              ),

              // (Removed) per design: no action button on card — title should be prominent and responsive
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHotDealsSection(WebHomeController controller, ThemeData theme, double screenWidth) {
  final isDesktop = screenWidth >= 992;
  final isTablet = screenWidth > 768 && screenWidth < 992;
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
            _HoverScale(
              child: TextButton(
                onPressed: () {
                  // Navigate to the full Hot Deals listing
                  Get.to(() => const AllHotDealsScreen());
                },
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontSize: isDesktop ? 16 : 14,
                    color: EventouryColors.persimmon,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isDesktop ? 40 : isTablet ? 30 : 20),
        Obx(() {
          // Only show a preview of hot deals on the home page. Full list is available
          // via the 'See All' link which navigates to AllHotDealsScreen.
          final total = controller.hotDeals.length;
          final displayCount = total > 3 ? 3 : total;

          if (isMobile) {
            return Column(
              children: List.generate(displayCount, (index) {
                final deal = controller.hotDeals[index];
                final anim = CurvedAnimation(parent: _hotDealsAnimController!, curve: Interval((index * 0.08).clamp(0.0, 0.9), ((index * 0.08) + 0.45).clamp(0.0, 1.0), curve: Curves.easeOut));
                return FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(anim),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: _buildDealCard(deal, index, controller, theme, true),
                    ),
                  ),
                );
              }),
            );
          }

          return Row(
            children: List.generate(displayCount, (index) {
              final deal = controller.hotDeals[index];
              final anim = CurvedAnimation(parent: _hotDealsAnimController!, curve: Interval((index * 0.08).clamp(0.0, 0.9), ((index * 0.08) + 0.45).clamp(0.0, 1.0), curve: Curves.easeOut));
              return Expanded(
                child: FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(anim),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: _buildDealCard(deal, index, controller, theme, false),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildAboutSection(ThemeData theme, double screenWidth) {
  final isDesktop = screenWidth >= 992;
  final isTablet = screenWidth > 768 && screenWidth < 992;
  final isMobile = screenWidth <= 768;

    final horizontalPadding = isDesktop ? 0.0 : 0.0;

  final aboutAnim = CurvedAnimation(parent: _aboutAnimController!, curve: const Interval(0.6, 1.0, curve: Curves.easeOut));

    final aboutChild = Container(
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
                  '''Welcome to Eventoury—your premier concierge for culture and celebrations in the heart of Bali! With our motto, "Your Concierge to Culture & Celebrations," we strive to make every moment of your travel unforgettable.

At Eventoury, we go beyond traditional tourism and event management. We are committed to connecting you with a wide range of verified and secure service providers, ensuring a seamless and enjoyable experience during your stay. Whether you're looking to book tours, explore local attractions, hire guides, arrange transportation, or create special moments, we are your dedicated marketplace for all travel needs.''',
                  style: TextStyle(fontSize: 14, color: theme.textTheme.bodyMedium?.color, height: 1.6),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _HoverScale(child: EventouryElevatedButton(onPressed: () => Get.to(() => const AboutUsWebScreen()), child: const Text('Read more →'))),
                const SizedBox(height: 20),
                Container(
                  decoration: _sharedCardDecoration(theme, radius: 12),
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
                          '''Welcome to Eventoury—your premier concierge for culture and celebrations in the heart of Bali! With our motto, "Your Concierge to Culture & Celebrations," we strive to make every moment of your travel unforgettable. At Eventoury, we go beyond traditional tourism and event management. We are committed to connecting you with a wide range of verified and secure service providers, ensuring a seamless and enjoyable experience during your stay. Whether you're looking to book tours, explore local attractions, hire guides, arrange transportation, or create special moments, we are your dedicated marketplace for all travel needs.''',
                            style: TextStyle(fontSize: 16, color: theme.textTheme.bodyMedium?.color, height: 1.6),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _HoverScale(child: EventouryElevatedButton(onPressed: () => Get.to(() => const AboutUsWebScreen()), child: const Text('Read more →'))),
                    ],
                  ),
                ),

                const SizedBox(width: 40),

                // Right image
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: _sharedCardDecoration(theme, radius: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/onboarding_images/onboarding_4.jpeg', fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
              ),
      );

      return FadeTransition(
        opacity: aboutAnim,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(aboutAnim),
          child: aboutChild,
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
  // Shadow handled by shared decoration below.

    return InkWell(
      onTap: () => Get.to(() => DetailsScreen(title: deal['title'] ?? '', location: deal['location'] ?? '', rating: (deal['rating'] is num) ? (deal['rating'] as num).toDouble() : 0.0)),
      child: Container(
        decoration: _sharedCardDecoration(theme, radius: 20),
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
        ),
      ),
    );
  }

  // Footer removed; replaced by BottomBarWidget
}