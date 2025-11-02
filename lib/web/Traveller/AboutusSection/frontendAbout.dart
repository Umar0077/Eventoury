import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Traveller/explore%20categories/frontend/explore_categories.dart';

class AboutUsWebScreen extends StatefulWidget {
  const AboutUsWebScreen({super.key});

  @override
  State<AboutUsWebScreen> createState() => _AboutUsWebScreenState();
}

class _AboutUsWebScreenState extends State<AboutUsWebScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _storyKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _visionKey = GlobalKey();

  late final AnimationController _bgAnimController;
  bool _storyVisible = false;
  bool _visionVisible = false;

  @override
  void initState() {
    super.initState();
    _bgAnimController = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat(reverse: true);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Avoid accessing context when state is unmounted (can happen during hot-reload)
    if (!mounted) return;

    try {
      // Reveal story section when scrolled near its position
      if (!_storyVisible && _storyKey.currentContext != null) {
        final box = _storyKey.currentContext!.findRenderObject() as RenderBox;
        final top = box.localToGlobal(Offset.zero, ancestor: null).dy;
        if (top < MediaQuery.of(context).size.height * 0.8) {
          setState(() => _storyVisible = true);
        }
      }

      // Reveal vision section when scrolled into view
      if (!_visionVisible && _visionKey.currentContext != null) {
        final box = _visionKey.currentContext!.findRenderObject() as RenderBox;
        final top = box.localToGlobal(Offset.zero, ancestor: null).dy;
        if (top < MediaQuery.of(context).size.height * 0.9) {
          setState(() => _visionVisible = true);
        }
      }
    } catch (e) {
      // On web, during hot reload or race conditions, underlying JS objects can be
      // temporarily undefined which throws. Swallow the error safely and return.
      return;
    }
  }

  @override
  void dispose() {
    _bgAnimController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    if (!mounted) return;
    try {
      if (key.currentContext == null) return;
      final box = key.currentContext!.findRenderObject() as RenderBox;
      final y = box.localToGlobal(Offset.zero, ancestor: null).dy + _scrollController.offset;
      _scrollController.animateTo(y - 80, duration: const Duration(milliseconds: 600), curve: Curves.easeOut);
    } catch (e) {
      // ignore errors from transient states (hot reload / race conditions)
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 992;
    final isTablet = screenWidth > 768 && screenWidth < 992;
    final isMobile = screenWidth <= 768;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const TopBarWidget(activeItem: 'About'),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero
                  _buildHero(theme, isDesktop, isTablet, isMobile),
                  const SizedBox(height: 40),

                  // Our Story
                  Container(key: _storyKey, child: _buildOurStory(theme, isDesktop, isTablet, isMobile)),
                  const SizedBox(height: 40),

                  // Services
                  Container(key: _servicesKey, padding: const EdgeInsets.symmetric(horizontal: 24), child: _buildServices(theme, isDesktop, isTablet, isMobile)),
                  const SizedBox(height: 40),

                  // Why choose us
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: _buildWhyChoose(theme, isDesktop)),
                  const SizedBox(height: 40),

                  // Vision
                  Container(key: _visionKey, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: _buildVision(theme, isDesktop, isMobile: isMobile))),
                  const SizedBox(height: 40),

                  // Join Us
                  _buildJoinUs(theme, isDesktop),
                  const SizedBox(height: 40),

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

  Widget _buildHero(ThemeData theme, bool isDesktop, bool isTablet, bool isMobile) {
    final heroHeight = isDesktop ? 420.0 : isTablet ? 360.0 : 320.0;
    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/home_screen/BBali.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.15)], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 120 : 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('About Us', style: TextStyle(color: Colors.white, fontSize: isDesktop ? 48 : isTablet ? 40 : 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Your Concierge to Culture & Celebrations', style: TextStyle(color: Colors.white70, fontSize: isDesktop ? 20 : 18)),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isDesktop ? 700 : 560),
                    child: Text(
                      'Welcome to Eventoury, your premier concierge for culture and celebrations in the heart of Bali! We strive to make every moment of your travel unforgettable.',
                      style: TextStyle(color: Colors.white70, fontSize: isDesktop ? 18 : 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOurStory(ThemeData theme, bool isDesktop, bool isTablet, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 24),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 700),
        opacity: _storyVisible ? 1.0 : 0.0,
        child: isDesktop
            ? Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset('assets/home_screen/events.jpg', fit: BoxFit.cover)),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Our Story', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Text('At Eventoury, we go beyond traditional tourism and event management. We connect you with verified and secure service providers, ensuring seamless and enjoyable travel experiences. Whether you’re booking tours, exploring attractions, hiring guides, arranging transport, or celebrating special moments, Eventoury is your trusted marketplace for all travel needs.', style: TextStyle(fontSize: 16, height: 1.6)),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset('assets/home_screen/events.jpg', fit: BoxFit.cover)),
                  const SizedBox(height: 16),
                  const Text('Our Story', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('At Eventoury, we go beyond traditional tourism and event management. We connect you with verified and secure service providers, ensuring seamless and enjoyable travel experiences. Whether you’re booking tours, exploring attractions, hiring guides, arranging transport, or celebrating special moments, Eventoury is your trusted marketplace for all travel needs.', style: TextStyle(fontSize: 15, height: 1.6), textAlign: TextAlign.center),
                ],
              ),
      ),
    );
  }

  Widget _buildServices(ThemeData theme, bool isDesktop, bool isTablet, bool isMobile) {
    final crossAxis = isDesktop ? 3 : isTablet ? 2 : 1;
    final services = [
      {'title': 'Tailored Tours & Experiences', 'desc': 'Discover Bali’s culture with personalized experiences.', 'icon': Icons.travel_explore},
      {'title': 'Activities', 'desc': 'Adventure sports, wellness retreats, and entertainment.', 'icon': Icons.sports_motorsports},
      {'title': 'Transport Rentals', 'desc': 'Reliable options to travel comfortably across the island.', 'icon': Icons.car_rental},
      {'title': 'Guides of Your Choice', 'desc': 'Explore hidden gems with knowledgeable local guides.', 'icon': Icons.person_search},
      {'title': 'Event Management', 'desc': 'From small gatherings to large celebrations, we manage it all.', 'icon': Icons.event_available},
      {'title': 'Wellness & Fitness', 'desc': 'Rejuvenate with wellness programs and fitness services.', 'icon': Icons.spa},
      {'title': 'Medical Assistance', 'desc': 'Access trusted medical support for peace of mind.', 'icon': Icons.local_hospital},
      {'title': 'Protocol Arrivals', 'desc': 'Experience smooth and respectful arrivals with expert help.', 'icon': Icons.flight_takeoff},
    ];

    final isDark = theme.brightness == Brightness.dark;
    final sectionPaddingVertical = isDesktop ? 64.0 : 56.0; // py-16 to py-20 equivalent
    final sectionPaddingHorizontal = isDesktop ? 40.0 : 24.0; // px-6 to px-10

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: sectionPaddingVertical, horizontal: sectionPaddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading
          Text('Our Services', style: TextStyle(fontSize: isDesktop ? 32 : isTablet ? 28 : 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.grey.shade900)),
          const SizedBox(height: 8),
          Container(height: 4, width: 80, decoration: BoxDecoration(color: EventouryColors.tangerine.withOpacity(0.95), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),

          // Services grid
          LayoutBuilder(builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxis,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isDesktop ? 2.2 : isTablet ? 1.8 : 3,
              ),
              itemBuilder: (context, index) {
                final s = services[index];
                final cardBg = isDark ? const Color(0xFF1B1B1B) : Colors.white;
                final titleColor = isDark ? Colors.white : Colors.grey.shade900;
                final descColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

                return StatefulBuilder(builder: (context, setState) {
                  var hovering = false;
                  return MouseRegion(
                    onEnter: (_) => setState(() => hovering = true),
                    onExit: (_) => setState(() => hovering = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      transform: Matrix4.identity()..scale(hovering ? 1.05 : 1.0),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(24), // rounded-2xl
                        border: Border.all(color: hovering ? EventouryColors.tangerine.withOpacity(0.18) : Colors.transparent, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: isDark ? Colors.white.withOpacity(hovering ? 0.03 : 0.0) : Colors.black.withOpacity(hovering ? 0.10 : 0.04),
                            blurRadius: hovering ? 20 : 12,
                            offset: Offset(0, hovering ? 10 : 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon container
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: EventouryColors.tangerine,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [BoxShadow(color: EventouryColors.tangerine.withOpacity(0.22), blurRadius: 12, offset: const Offset(0, 6))],
                              ),
                              child: Icon(s['icon'] as IconData, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 16),
                            // Text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(s['title'] as String, style: TextStyle(fontWeight: FontWeight.w600, color: titleColor, fontSize: isDesktop ? 16 : 15)),
                                  const SizedBox(height: 6),
                                  Text(s['desc'] as String, style: TextStyle(color: descColor, fontSize: 13, height: 1.45)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildWhyChoose(ThemeData theme, bool isDesktop) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Why Choose Us?', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('At Eventoury, our mission is not just to facilitate tourism, but to be a trustworthy bridge between travelers and authentic experiences. We prioritize safety and satisfaction by partnering exclusively with verified service providers.', style: TextStyle(fontSize: 16, height: 1.6)),
          ]),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: theme.brightness == Brightness.dark ? const Color(0xFF1F1F1F) : Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 8))]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _featureRow(Icons.verified_user, 'Verified Vendors'),
                const SizedBox(height: 12),
                _featureRow(Icons.check_circle, 'Stress-Free Planning'),
                const SizedBox(height: 12),
                _featureRow(Icons.celebration, 'Authentic Experiences'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _featureRow(IconData icon, String text) {
    return Row(children: [Icon(icon, color: EventouryColors.persimmon), const SizedBox(width: 12), Text(text, style: const TextStyle(fontWeight: FontWeight.w600))]);
  }

  Widget _buildVision(ThemeData theme, bool isDesktop, {required bool isMobile}) {
    final isDark = theme.brightness == Brightness.dark;
    final bgGradient = isDark
        ? const LinearGradient(colors: [Color(0xFF121212), Color(0xFF1A1A1A)], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        : LinearGradient(colors: [Colors.grey.shade100, Colors.grey.shade50], begin: Alignment.topCenter, end: Alignment.bottomCenter);

    final headingColor = isDark ? Colors.white : Colors.grey.shade900;
    final bodyColor = isDark ? Colors.white70 : Colors.grey.shade800;

    final verticalPadding = isDesktop ? 80.0 : 64.0; // py-16 to py-20 equivalent

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: _visionVisible ? 1.0 : 0.0,
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(begin: const Offset(0, 18), end: _visionVisible ? const Offset(0, 0) : const Offset(0, 18)),
        duration: const Duration(milliseconds: 600),
        builder: (context, offset, child) {
          return Transform.translate(
            offset: offset,
            child: child,
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          decoration: BoxDecoration(gradient: bgGradient),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Our Vision', style: TextStyle(color: headingColor, fontSize: isDesktop ? 28 : 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  // Tangerine underline/accent
                  Container(
                    height: 4,
                    width: 80,
                    decoration: BoxDecoration(color: EventouryColors.tangerine.withOpacity(isDark ? 1.0 : 0.9), borderRadius: BorderRadius.circular(2)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Based in Bali, our vision extends beyond the island. We aim to expand globally, bringing our commitment to trust, security, and unforgettable moments to travelers worldwide.',
                    style: TextStyle(color: bodyColor, fontSize: isDesktop ? 16 : 15, height: 1.6),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJoinUs(ThemeData theme, bool isDesktop) {
    // Removed strong background color/gradient so this section blends with page theme.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: Column(
          children: [
            const Text('Join Our Journey', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Let Eventoury enhance your adventures with trust, security, and unforgettable memories.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.to(() => const ExploreCategoriesScreen()),
              style: ElevatedButton.styleFrom(backgroundColor: EventouryColors.persimmon, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
              child: const Text('Explore Experiences'),
            ),
          ],
        ),
      ),
    );
  }
}
