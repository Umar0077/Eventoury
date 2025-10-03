import 'package:flutter/material.dart';
import 'package:eventoury/web/Vendor/Sidebar/frontend/sidebar.dart';

/// A shared layout for all Vendor screens that keeps a single sidebar on the left
/// and places page-specific content to the right. Use this to avoid embedding
/// `VendorSidebar` in every screen.
class VendorLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Widget? floatingActionButton;

  const VendorLayout({super.key, required this.child, this.padding, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    // VendorLayout provides a responsive wrapper used by all vendor pages.
    // On wide screens we show a persistent left sidebar. On narrow screens
    // we collapse the sidebar into a Drawer opened via a hamburger in the
    // top app bar so the UI matches the provided mobile design.
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // Responsive padding: larger on wide screens, smaller on mobile
      final EdgeInsets responsivePadding = padding as EdgeInsets? ??
          (width > 1400
              ? const EdgeInsets.all(32)
              : width > 900
                  ? const EdgeInsets.all(20)
                  : const EdgeInsets.symmetric(horizontal: 12, vertical: 10));

      // Provide a bounded viewport-height container for page content.
      // This ensures pages that use Expanded/Flexible vertically receive
      // finite height constraints and avoids runtime errors caused by
      // Expanded inside an unbounded (scrollable) parent.
      final content = SafeArea(
        child: Padding(
          padding: responsivePadding,
          child: SizedBox(
            // Use the available height minus padding as a finite bound.
            height: constraints.maxHeight - responsivePadding.vertical,
            child: child,
          ),
        ),
      );

      // If this layout is already hosted inside another Scaffold (for
      // example the persistent `VendorShell`), we must not build another
      // Scaffold or render a second sidebar. In that case simply return the
      // prepared content so the outer scaffold (shell) controls the page
      // chrome and sidebar.
      if (Scaffold.maybeOf(context) != null) {
        return content;
      }

      // Wide screens: show persistent sidebar alongside content
      if (width >= 900) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VendorSidebar(),
              // Allow the right side to scroll independently
              Expanded(child: content),
            ],
          ),
          floatingActionButton: floatingActionButton as FloatingActionButton?,
        );
      }

      // Narrow screens: collapse sidebar into a Drawer and show a compact AppBar
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
        ),
        drawer: Drawer(
          child: SafeArea(child: VendorSidebar()),
        ),
        body: content,
        floatingActionButton: floatingActionButton as FloatingActionButton?,
      );
    });
  }
}
