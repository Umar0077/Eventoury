import 'package:eventoury/utils/constants/colors.dart';
// screen imports intentionally removed — use named routes for navigation to avoid
// widget-level import coupling and to keep the sidebar reusable across pages.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/web/Vendor/vendor_shell_controller.dart';

class VendorSidebar extends StatefulWidget {
  const VendorSidebar({super.key});

  @override
  State<VendorSidebar> createState() => _VendorSidebarState();
}

class _VendorSidebarState extends State<VendorSidebar> {
  String _selected = 'Home';

  String _labelForRoute(String route) {
    switch (route) {
      case '/VendorHome':
        return 'Home';
      case '/VendorBookings':
        return 'Bookings';
      case '/VendorInsights':
        return 'Insights';
      case '/VendorProfile':
        return 'Profile';
      default:
        return '';
    }
  }

  String _routeForLabel(String label) {
    switch (label) {
      case 'Home':
        return '/VendorHome';
      case 'Bookings':
        return '/VendorBookings';
      case 'Insights':
        return '/VendorInsights';
      case 'Profile':
        return '/VendorProfile';
      default:
        return '/Vendor';
    }
  }

  @override
  void initState() {
    super.initState();
    final route = Get.currentRoute;
    switch (route) {
      case '/VendorHome':
        _selected = 'Home';
        break;
      case '/VendorBookings':
        _selected = 'Bookings';
        break;
      case '/VendorInsights':
        _selected = 'Insights';
        break;
      case '/VendorProfile':
        _selected = 'Profile';
        break;
      default:
        // keep existing default
        break;
    }
  }

  // When the sidebar is used on a standalone page (for example the
  // AddNewPackage screen) there may be no VendorShellController instance
  // yet. In that case we navigate to '/Vendor' and the shell will be
  // constructed asynchronously. This helper retries a few times to find
  // the controller and set the desired index when it becomes available.
  Future<void> _setShellIndexWithRetry(int idx) async {
    const int maxTries = 12;
    const Duration delay = Duration(milliseconds: 60);
    for (int i = 0; i < maxTries; i++) {
      try {
        final ctrl = Get.find<VendorShellController>();
        ctrl.setIndex(idx);
        return;
      } catch (_) {
        // controller not ready yet, wait and retry
        await Future.delayed(delay);
      }
    }
    // If we reach here, controller couldn't be found — nothing more to do.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // keep the selected item in sync with the current route so browser
    // back/forward navigation and deep-links update the sidebar highlighting.
    final route = Get.currentRoute;
    String want = _selected;
    switch (route) {
      case '/VendorHome':
        want = 'Home';
        break;
      case '/VendorBookings':
        want = 'Bookings';
        break;
      case '/VendorInsights':
        want = 'Insights';
        break;
      case '/VendorProfile':
        want = 'Profile';
        break;
      default:
        break;
    }
    if (want != _selected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _selected = want);
      });
    }
  }

  Widget _navItem({required IconData icon, required String label, required int index, required FutureOr<void> Function() onTap}) {
    // Try to find the shell controller; if present, derive active state from its index.
    VendorShellController? ctrl;
    try {
      ctrl = Get.find<VendorShellController>();
    } catch (_) {
      ctrl = null;
    }

    final String routeLabel = _labelForRoute(Get.currentRoute);
    // active if controller exists and its index matches, otherwise fall back
    // to route/selected string matching for pages not hosted inside the shell.
    final bool active = (ctrl != null) ? (ctrl.index.value == index) : ((routeLabel == label) || (_selected == label));

    final Color iconColor = active ? EventouryColors.tangerine : Colors.black87;

    Widget child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 25, color: iconColor),
          const SizedBox(width: 14),
          Text(
            label,
            style: TextStyle(
              color: active ? EventouryColors.tangerine : Colors.black87,
              fontWeight: active ? FontWeight.w700 : FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );

    // If controller exists, wrap in Obx so the item updates when controller index changes.
    if (ctrl != null) {
      return Obx(() {
        final bool nowActive = ctrl!.index.value == index;
        return InkWell(
          onTap: () {
            // keep the _selected string in sync for fallback routes
            setState(() => _selected = label);
              final r = onTap();
              if (r is Future) {
                // ignore: unawaited_futures
                r.catchError((_) {});
              }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Row(
              children: [
                Icon(icon, size: 25, color: nowActive ? EventouryColors.tangerine : Colors.black87),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: TextStyle(
                    color: nowActive ? EventouryColors.tangerine : Colors.black87,
                    fontWeight: nowActive ? FontWeight.w700 : FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }

    return InkWell(
      onTap: () async {
        // update UI first
        setState(() => _selected = label);
        // If there's no shell controller, navigate directly to the vendor route
        // for this label so standalone pages (for example AddNewPackage)
        // work correctly without assuming a VendorShell instance.
        try {
          // try to call the provided onTap closure (it may attempt to set the shell index)
          final res = onTap();
          if (res is Future) await res;
        } catch (_) {
          final route = _routeForLabel(label);
          await Get.offAllNamed(route);
          await _setShellIndexWithRetry(index);
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // widened slightly so the logo can be larger while keeping comfortable
      // left padding for nav items
      width: 260,
      decoration: BoxDecoration(
        color: EventouryColors.alabaster,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(18), bottomRight: Radius.circular(18)),
      ),
      // slightly more left padding so nav items line up closer to the left edge like the design
      // reduced top padding because logo removed — nav items should start nearer the top
      padding: const EdgeInsets.fromLTRB(20, 8, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo centered near the top. Uses logo_4 from assets/app_logos and
          // scales with the sidebar width so it stays responsive.
          Padding(
            // add left padding so the logo's left edge aligns with nav icons
            // increased bottom padding to add more vertical space between the
            // logo and the navigation items
            padding: const EdgeInsets.only(top: 6.0, bottom: 24.0, left: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.72,
                child: Image.asset(
                  'assets/app_logos/logo_4.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Nav items (use named navigation so Get.currentRoute updates predictably)
          _navItem(icon: Icons.home_outlined, label: 'Home', index: 0, onTap: () async {
            // prefer changing the shell index when a VendorShell is active
            try {
              final ctrl = Get.find<VendorShellController>();
              ctrl.setIndex(0);
            } catch (_) {
              // if the shell isn't present, navigate to the single Vendor
              // shell route and then set the index to ensure the sidebar
              // remains the same instance and only the right-side content
              // switches.
              await Get.offAllNamed('/Vendor');
              try {
                final ctrl2 = Get.find<VendorShellController>();
                ctrl2.setIndex(0);
              } catch (_) {}
            }
          }),
          const SizedBox(height: 6),
          _navItem(icon: Icons.calendar_month_outlined, label: 'Bookings', index: 1, onTap: () async {
            try {
              final ctrl = Get.find<VendorShellController>();
              ctrl.setIndex(1);
            } catch (_) {
              await Get.offAllNamed('/Vendor');
              try {
                final ctrl2 = Get.find<VendorShellController>();
                ctrl2.setIndex(1);
              } catch (_) {}
            }
          }),
          const SizedBox(height: 6),
          
          _navItem(icon: Icons.insights_outlined, label: 'Insights', index: 4, onTap: () async {
            try {
              final ctrl = Get.find<VendorShellController>();
              ctrl.setIndex(4);
            } catch (_) {
              await Get.offAllNamed('/Vendor');
              try {
                final ctrl2 = Get.find<VendorShellController>();
                ctrl2.setIndex(4);
              } catch (_) {}
            }
          }),
          const SizedBox(height: 6),
          _navItem(icon: Icons.person_outline, label: 'Profile', index: 5, onTap: () async {
            try {
              final ctrl = Get.find<VendorShellController>();
              ctrl.setIndex(5);
            } catch (_) {
              await Get.offAllNamed('/Vendor');
              try {
                final ctrl2 = Get.find<VendorShellController>();
                ctrl2.setIndex(5);
              } catch (_) {}
            }
          }),

          const Spacer(),

          // Logout
          InkWell(
            onTap: () {
              // Placeholder logout action
              Get.offAllNamed('/WebHomeScreen');
            },
            child: 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Row(
                children: const [
                  Icon(Icons.logout, size: 18, color: Colors.black87),
                  SizedBox(width: 12),
                  Text('Logout', style: TextStyle(color: Colors.black87)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
