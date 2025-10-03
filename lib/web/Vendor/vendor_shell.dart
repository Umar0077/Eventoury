import 'package:eventoury/web/Vendor/Sidebar/frontend/sidebar.dart';
import 'package:eventoury/web/Vendor/home/frontend/vendor_home_screen.dart';
import 'package:eventoury/web/Vendor/insights/frontend/vendor_insights.dart';
import 'package:eventoury/web/Vendor/profile/frontend/vendor_profile.dart';
import 'package:eventoury/web/Vendor/Booking screens/frontend/bookingvendor.dart';
import 'package:eventoury/web/Vendor/Revenue/frontend/revenuevendor.dart';
import 'package:eventoury/web/Vendor/Reviews/frontend/reviewsvendor.dart';
import 'package:eventoury/web/Vendor/Packages/active packages/frontend/activepackages.dart';
import 'package:eventoury/web/Vendor/Packages/add new packages/frontend/addnewpackage.dart';
import 'package:eventoury/web/Vendor/vendor_shell_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A persistent shell that keeps a single `VendorSidebar` on the left and
/// swaps the right-side content using an IndexedStack. The initialIndex
/// controls which tab/content is visible.
class VendorShell extends StatefulWidget {
  final int initialIndex;
  const VendorShell({super.key, this.initialIndex = 0});

  @override
  State<VendorShell> createState() => _VendorShellState();
}

class _VendorShellState extends State<VendorShell> {
  late final VendorShellController _ctrl;

  int get _index => _ctrl.index.value;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.put(VendorShellController());
    // Determine index from initialIndex or from the current route (deep links)
    final route = Get.currentRoute;
    int startIndex = widget.initialIndex;
    switch (route) {
      case '/VendorHome':
        startIndex = 0;
        break;
      case '/VendorBookings':
        startIndex = 1;
        break;
      case '/VendorRevenue':
        startIndex = 2;
        break;
      case '/VendorReviews':
        startIndex = 3;
        break;
      case '/VendorInsights':
        startIndex = 4;
        break;
      case '/VendorProfile':
        startIndex = 5;
        break;
      case '/VendorPackages':
        startIndex = 6;
        break;
      case '/VendorAddPackage':
        startIndex = 7;
        break;
      default:
        // keep widget.initialIndex
        break;
    }
    // Defer setting the controller index until after the first frame so
    // we don't mark Obx dirty while the framework is still building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _ctrl.setIndex(startIndex);
    });
  }

  // index is managed via VendorShellController; no local setter needed.

  @override
  Widget build(BuildContext context) {
    // We keep the sidebar on the left and an IndexedStack so switching content
    // doesn't rebuild the sidebar.
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            // pass a callback to the sidebar via a simple mechanism: the
            // sidebar can use navigation by route names already; to allow
            // clicking to change the index without changing URL, you'd wire
            // the sidebar to call this _setIndex. For now we keep route
            // navigation working: when routes load this shell with different
            // initialIndex they'll show correct content.
            const VendorSidebar(),
            // Add a left padding so right-side content doesn't butt up
            // against the sidebar. This prevents visual clipping/overflow
            // on smaller screens and matches the page designs.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                child: Obx(() => IndexedStack(
                      index: _index,
                      // children cannot be const because some content widgets
                      // (for example BookingVendorContent) currently accept
                      // non-const constructors or parameters.
                      children: [
                        VendorHomeContent(),
                        BookingVendorContent(),
                        RevenueVendorContent(),
                        ReviewsVendorContent(),
                        VendorInsightsContent(),
                        VendorProfileContent(),
                        const ActivePackagesScreen(),
                        const AddNewPackageScreen(),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
