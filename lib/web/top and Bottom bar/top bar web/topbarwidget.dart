import 'package:eventoury/web/Traveller/explore%20categories/frontend/explore_categories.dart';
import 'package:eventoury/web/Traveller/home/backend/web_home_controller.dart';
import 'package:eventoury/web/Traveller/settings/frontend/settingsweb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/utils/constants/colors.dart';


class TopBarWidget extends StatelessWidget {
  final VoidCallback? onMenuToggle;
  final RxBool? isMobileMenuOpen;
  final String? activeItem;
  final void Function(String item)? onNavTap;

  const TopBarWidget({super.key, this.onMenuToggle, this.isMobileMenuOpen, this.activeItem, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;
    final isMobile = screenWidth <= 768;
    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;

    // Try to get a home controller for mobile menu state if available and no explicit callbacks provided
    WebHomeController? controller;
    if (onMenuToggle == null || isMobileMenuOpen == null) {
      try {
        controller = Get.find<WebHomeController>();
      } catch (_) {
        controller = null;
      }
    }

    // Determine the effective handlers/observables
    final effectiveToggle = onMenuToggle ?? (controller?.toggleMobileMenu);
    final effectiveIsOpen = isMobileMenuOpen ?? controller?.isMobileMenuOpen;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(bottom: BorderSide(color: theme.dividerColor.withOpacity(0.1), width: 1)),
      ),
      child: Row(
        children: [
          if (isMobile && effectiveToggle != null && effectiveIsOpen != null)
            Obx(() => IconButton(
                  onPressed: effectiveToggle,
                  icon: Icon(effectiveIsOpen.value ? Icons.close : Icons.menu, color: theme.iconTheme.color),
                  padding: EdgeInsets.all(8),
                )),

          if (isMobile)
            Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Image.asset(isDark ? 'assets/app_logos/logo_5.png' : 'assets/app_logos/logo_4.png', height: 32)]))
          else
            SizedBox(width: isDesktop ? 200 : 150, child: Row(children: [Image.asset(isDark ? 'assets/app_logos/logo_5.png' : 'assets/app_logos/logo_4.png', height: isDesktop ? 40 : 32), const SizedBox(width: 8)])),

          if (!isMobile)
            // If a WebHomeController exists we bind to its activeNav observable so
            // nav items highlight immediately on click across the app.
            Expanded(
                child: controller != null
                    ? (() {
                        final ctrl = controller!;
                        return Obx(() {
                          final active = ctrl.activeNav.value;
                          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            _navItem('Home', active == 'Home', theme, isDesktop, () {
                              ctrl.setActiveNav('Home');
                              if (onNavTap != null) onNavTap!('Home');
                              // already on home; just scroll to top (use controller-registered key if available)
                              Scrollable.ensureVisible(ctrl.exploreKey?.currentContext ?? context, duration: const Duration(milliseconds: 400));
                              if (Get.currentRoute != '/WebHomeScreen') Get.offAllNamed('/WebHomeScreen');
                            }),
                            SizedBox(width: isDesktop ? 40 : 30),
                            _navItem('Explore', active == 'Explore', theme, isDesktop, () {
                              ctrl.setActiveNav('Explore');
                              if (onNavTap != null) onNavTap!('Explore');
                              ctrl.scrollToExplore();
                            }),
                            SizedBox(width: isDesktop ? 40 : 30),
                            _navItem('Hot Deals', active == 'Hot Deals', theme, isDesktop, () {
                              ctrl.setActiveNav('Hot Deals');
                              if (onNavTap != null) onNavTap!('Hot Deals');
                              ctrl.scrollToHotDeals();
                            }),
                            SizedBox(width: isDesktop ? 40 : 30),
                            _navItem('Settings', active == 'Settings', theme, isDesktop, () {
                              ctrl.setActiveNav('Settings');
                              if (onNavTap != null) onNavTap!('Settings');
                              Get.to(() => const SettingsWeb());
                            }),
                            SizedBox(width: isDesktop ? 40 : 30),
                            _navItem('About', active == 'About', theme, isDesktop, () {
                              ctrl.setActiveNav('About');
                              if (onNavTap != null) onNavTap!('About');
                              ctrl.scrollToAbout();
                            }),
                            SizedBox(width: isDesktop ? 40 : 30),
                            _navItem('Contact', active == 'Contact', theme, isDesktop, () {
                              ctrl.setActiveNav('Contact');
                              if (onNavTap != null) onNavTap!('Contact');
                              ctrl.scrollToContact();
                            }),
                          ]);
                        });
                      })()
                    : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        _navItem('Home', activeItem == 'Home', theme, isDesktop, () {
                            if (onNavTap != null) onNavTap!('Home');
                          if (controller != null) {
                            // already on home; just scroll to top (use controller-registered key if available)
                            Scrollable.ensureVisible(controller.exploreKey?.currentContext ?? context, duration: const Duration(milliseconds: 400));
                            if (Get.currentRoute != '/WebHomeScreen') Get.offAllNamed('/WebHomeScreen');
                          } else {
                            if (Get.currentRoute != '/WebHomeScreen') Get.offAllNamed('/WebHomeScreen');
                          }
                        }),
                        SizedBox(width: isDesktop ? 40 : 30),
                        _navItem('Explore', activeItem == 'Explore', theme, isDesktop, () {
                          if (onNavTap != null) onNavTap!('Explore');
                          if (controller != null) {
                            controller.scrollToExplore();
                          } else {
                            Get.to(() => const ExploreCategoriesScreen());
                          }
                        }),
                        SizedBox(width: isDesktop ? 40 : 30),
                        _navItem('Hot Deals', activeItem == 'Hot Deals', theme, isDesktop, () {
                            if (onNavTap != null) onNavTap!('Hot Deals');
                          if (controller != null) {
                            controller.scrollToHotDeals();
                          } else {
                            // No separate route implemented; fallback to home then scroll
                            if (Get.currentRoute != '/WebHomeScreen') {
                              Get.offAllNamed('/WebHomeScreen', arguments: {'scrollToHotDeals': true});
                            } else {
                              // already on home
                            }
                          }
                        }),
                        SizedBox(width: isDesktop ? 40 : 30),
                        _navItem('Settings', activeItem == 'Settings', theme, isDesktop, () {
                          if (onNavTap != null) onNavTap!('Settings');
                          Get.to(() => const SettingsWeb());
                        }),
                        SizedBox(width: isDesktop ? 40 : 30),
                        _navItem('About', activeItem == 'About', theme, isDesktop, () {
                          if (onNavTap != null) onNavTap!('About');
                          if (controller != null) {
                            controller.scrollToAbout();
                          } else {
                            // Navigate to home and request scroll to About after navigation
                            if (Get.currentRoute != '/WebHomeScreen') {
                              Get.offAllNamed('/WebHomeScreen', arguments: {'scrollToAbout': true});
                            }
                          }
                        }),
                        SizedBox(width: isDesktop ? 40 : 30),
                        _navItem('Contact', activeItem == 'Contact', theme, isDesktop, () {
                          if (onNavTap != null) onNavTap!('Contact');
                          if (controller != null) {
                            controller.scrollToContact();
                          } else {
                            if (Get.currentRoute != '/WebHomeScreen') {
                              Get.offAllNamed('/WebHomeScreen', arguments: {'scrollToContact': true});
                            }
                          }
                        }),
                      ])),

          if (isMobile)
            Row(mainAxisSize: MainAxisSize.min, children: [IconButton(onPressed: () {}, icon: Icon(Icons.search, color: theme.iconTheme.color, size: 20)), IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined, color: theme.iconTheme.color, size: 20))])
          else
            SizedBox(width: isDesktop ? 200 : 150, child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [IconButton(onPressed: () {}, icon: Icon(Icons.search, color: theme.iconTheme.color, size: isDesktop ? 24 : 20)), IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined, color: theme.iconTheme.color, size: isDesktop ? 24 : 20)), const SizedBox(width: 8), CircleAvatar(radius: isDesktop ? 20 : 16, backgroundColor: theme.primaryColor, child: Icon(Icons.person, color: Colors.white, size: isDesktop ? 20 : 16))])),
        ],
      ),
    );
  }

  Widget _navItem(String text, bool isActive, ThemeData theme, bool isDesktop, VoidCallback onTap) {
    final color = isActive ? EventouryColors.tangerine : theme.textTheme.bodyLarge?.color;
    return GestureDetector(onTap: onTap, child: Text(text, style: TextStyle(fontSize: isDesktop ? 16 : 14, fontWeight: isActive ? FontWeight.w600 : FontWeight.w500, color: color)));
  }
}
