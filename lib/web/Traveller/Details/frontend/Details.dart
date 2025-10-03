import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:eventoury/web/Traveller/Details/backend/details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';

class DetailsScreen extends StatefulWidget {
  final String title;
  final String location;
  final String country;
  final double rating;
  final int reviewCount;
  final String price;
  
  const DetailsScreen({
    super.key,
    this.title = 'Beach',
    this.location = 'Bali, Indonesia',
    this.country = 'Indonesia',
    this.rating = 4.7,
    this.reviewCount = 2498,
    this.price = '\$59',
  });
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // Track the current sheet extent so the handle can modify it directly.
  double sheetExtent = 0.6;
  final DraggableScrollableController _dsController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailsController());
    controller.updateDestination(
      title: widget.title,
      locationName: widget.location,
      countryName: widget.country,
      ratingValue: widget.rating,
      reviews: widget.reviewCount,
      priceValue: widget.price,
    );
    
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Full Screen Hero Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding_images/onboarding_1.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha((0.3 * 255).round()),
                    Colors.transparent,
                    Colors.black.withAlpha((0.4 * 255).round()),
                  ],
                ),
              ),
            ),
          ),
          
          // Top App Bar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : isTablet ? 40 : 20,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: isDesktop ? 28 : 24,
                    ),
                  ),
                  Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isDesktop ? 24 : isTablet ? 20 : 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Obx(() => IconButton(
                    onPressed: () => controller.toggleFavorite(),
                    icon: Icon(
                      controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                      color: controller.isFavorite.value ? Colors.red : Colors.white,
                      size: isDesktop ? 28 : 24,
                    ),
                  )),
                ],
              ),
            ),
          ),
          
          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            controller: _dsController,
            initialChildSize: sheetExtent, // Start at current sheetExtent
            minChildSize: 0.4,     // Can be dragged to 40% minimum
            maxChildSize: 0.9,     // Can be dragged to 90% maximum
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.2 * 255).round()),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Curved Drag Handle Area (draggable)
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                        onVerticalDragUpdate: (details) async {
                        // details.delta.dy > 0 means dragging down (reduce sheet), < 0 means up (increase sheet)
                        final screenHeight = MediaQuery.of(context).size.height;
                        final deltaFraction = details.delta.dy / screenHeight;
                        double newExtent = sheetExtent - deltaFraction;
                        newExtent = newExtent.clamp(0.4, 0.9);
                        setState(() {
                          sheetExtent = newExtent;
                        });
                        // Animate the sheet to the new extent for smoothness
                        try {
                          await _dsController.animateTo(sheetExtent, duration: const Duration(milliseconds: 50), curve: Curves.linear);
                        } catch (_) {}
                      },
                      child: Container(
                        width: double.infinity,
                        height: 36,
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: theme.dividerColor.withAlpha((0.3 * 255).round()),
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Scrollable Content
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: _buildMainContent(controller, theme, screenWidth, isDesktop, isTablet, isMobile),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(DetailsController controller, ThemeData theme, double screenWidth, bool isDesktop, bool isTablet, bool isMobile) {
    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Destination Info and Map Section
            if (isDesktop)
              _buildDesktopLayout(controller, theme, screenWidth)
            else
              _buildMobileLayout(controller, theme, screenWidth, isTablet, isMobile),
            
            SizedBox(height: isDesktop ? 40 : 30),
            
            // Gallery Section
            _buildGallerySection(controller, theme, isDesktop, isTablet),
            
            SizedBox(height: isDesktop ? 40 : 30),
            
            // About Destination Section
            _buildAboutSection(controller, theme, isDesktop, isTablet),
            
            SizedBox(height: isDesktop ? 60 : 40),
            
            // Book Now Button
            _buildBookButton(controller, isDesktop, isTablet),
            
            const SizedBox(height: 40),
            
            // Footer
            const BottomBarWidget(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(DetailsController controller, ThemeData theme, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Destination Info
        Expanded(
          flex: 2,
          child: _buildDestinationInfo(controller, theme, true, false),
        ),
        const SizedBox(width: 40),
        // Right side - Map
        Expanded(
          flex: 1,
          child: _buildMapSection(theme, true),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(DetailsController controller, ThemeData theme, double screenWidth, bool isTablet, bool isMobile) {
    return Column(
      children: [
        _buildDestinationInfo(controller, theme, false, isTablet),
        const SizedBox(height: 20),
        _buildMapSection(theme, false),
      ],
    );
  }

  Widget _buildDestinationInfo(DetailsController controller, ThemeData theme, bool isDesktop, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Obx(() => Text(
          controller.destinationTitle.value,
          style: TextStyle(
            fontSize: isDesktop ? 32 : isTablet ? 28 : 24,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.headlineLarge?.color,
          ),
        )),
        const SizedBox(height: 8),
        
        // Location
        Obx(() => Text(
          controller.location.value,
          style: TextStyle(
            fontSize: isDesktop ? 16 : isTablet ? 15 : 14,
            color: theme.textTheme.bodyMedium?.color,
          ),
        )),
        const SizedBox(height: 16),
        
        // Temperature, Country, Rating, Price Row
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            // Temperature
            _buildInfoChip(
              icon: Icons.thermostat,
              text: controller.temperature.value,
              theme: theme,
              isDesktop: isDesktop,
            ),
            
            // Country
            Obx(() => _buildInfoChip(
              icon: Icons.location_on,
              text: controller.country.value,
              theme: theme,
              isDesktop: isDesktop,
            )),
            
            // Rating
            Obx(() => _buildRatingChip(
              rating: controller.rating.value,
              reviewCount: controller.reviewCount.value,
              theme: theme,
              isDesktop: isDesktop,
            )),
            
            // Price
            Obx(() => _buildPriceChip(
              price: controller.price.value,
              unit: controller.priceUnit.value,
              theme: theme,
              isDesktop: isDesktop,
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required ThemeData theme,
    required bool isDesktop,
  }) {
    final bool isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 12 : 10,
        vertical: isDesktop ? 8 : 6,
      ),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.dividerColor.withAlpha((0.2 * 255).round()),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isDesktop ? 16 : 14,
            color: EventouryColors.tangerine,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: isDesktop ? 14 : 12,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingChip({
    required double rating,
    required int reviewCount,
    required ThemeData theme,
    required bool isDesktop,
  }) {
    final bool isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 12 : 10,
        vertical: isDesktop ? 8 : 6,
      ),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.dividerColor.withAlpha((0.2 * 255).round()),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: isDesktop ? 16 : 14,
            color: Colors.amber,
          ),
          const SizedBox(width: 4),
          Text(
            '$rating ($reviewCount)',
            style: TextStyle(
              fontSize: isDesktop ? 14 : 12,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceChip({
    required String price,
    required String unit,
    required ThemeData theme,
    required bool isDesktop,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 12 : 10,
        vertical: isDesktop ? 8 : 6,
      ),
      decoration: BoxDecoration(
  color: EventouryColors.tangerine.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: EventouryColors.tangerine.withAlpha((0.3 * 255).round()),
        ),
      ),
      child: Text(
        '$price/$unit',
        style: TextStyle(
          fontSize: isDesktop ? 14 : 12,
          fontWeight: FontWeight.w600,
          color: EventouryColors.tangerine,
        ),
      ),
    );
  }

  Widget _buildMapSection(ThemeData theme, bool isDesktop) {
    return Container(
      height: isDesktop ? 250 : 200,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor.withAlpha((0.2 * 255).round()),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[300]!,
                Colors.blue[500]!,
              ],
            ),
          ),
          child: Stack(
            children: [
              // Map placeholder with some decorative elements
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Denpasar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.brightness == Brightness.dark ? theme.textTheme.bodyMedium?.color : Colors.grey[800],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 30,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'BALI',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.brightness == Brightness.dark ? theme.textTheme.bodyMedium?.color : Colors.grey[800],
                    ),
                  ),
                ),
              ),
              // Map pin
              const Center(
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGallerySection(DetailsController controller, ThemeData theme, bool isDesktop, bool isTablet) {
    return SizedBox(
      height: isDesktop ? 120 : isTablet ? 100 : 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.galleryImages.length,
        itemBuilder: (context, index) {
          return Container(
            width: isDesktop ? 120 : isTablet ? 100 : 80,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(controller.galleryImages[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAboutSection(DetailsController controller, ThemeData theme, bool isDesktop, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Destination',
          style: TextStyle(
            fontSize: isDesktop ? 24 : isTablet ? 20 : 18,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.headlineLarge?.color,
          ),
        ),
        const SizedBox(height: 16),
        Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.aboutDescription.value,
              style: TextStyle(
                fontSize: isDesktop ? 16 : isTablet ? 15 : 14,
                height: 1.6,
                color: theme.textTheme.bodyMedium?.color,
              ),
              maxLines: controller.isExpanded.value ? null : 3,
              overflow: controller.isExpanded.value ? null : TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: controller.toggleReadMore,
              child: Text(
                controller.readMoreText.value,
                style: TextStyle(
                  fontSize: isDesktop ? 16 : isTablet ? 15 : 14,
                  color: EventouryColors.tangerine,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildBookButton(DetailsController controller, bool isDesktop, bool isTablet) {
    return SizedBox(
      width: double.infinity,
      height: isDesktop ? 56 : isTablet ? 52 : 48,
      child: EventouryElevatedButton(
        onPressed: controller.onBookNow,
        borderRadius: BorderRadius.circular(16),
        child: Text(
          'Book Now',
          style: TextStyle(
            fontSize: isDesktop ? 18 : isTablet ? 16 : 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Footer replaced by shared BottomBarWidget
}
