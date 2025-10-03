import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend/wishlist_controller.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
// bottom bar removed for this screen

class WishlistWeb extends StatelessWidget {
  const WishlistWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

  final isDesktop = screenWidth > 1200;
  final isTablet = screenWidth > 768 && screenWidth <= 1200;

    final horizontalPadding = isDesktop ? 80.0 : isTablet ? 40.0 : 20.0;
    final verticalPadding = isDesktop ? 40.0 : isTablet ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // shared top nav
          TopBarWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(children: [
                    IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back, color: theme.iconTheme.color)),
                    const SizedBox(width: 8),
                    Text('Wishlist', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)),
                  ]),
                  const SizedBox(height: 20),

                  // Make the list span the full available width
                  Obx(() => Column(children: controller.items.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final item = entry.value;
                        return Column(children: [
                          InkWell(
                            onTap: () => controller.openItem(idx),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                color: theme.brightness == Brightness.dark ? theme.cardColor : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: theme.dividerColor.withOpacity(0.06)),
                                boxShadow: [
                                  BoxShadow(color: theme.shadowColor.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                                ],
                              ),
                              child: Row(children: [
                                ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(item.image, width: 90, height: 70, fit: BoxFit.cover)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(item.title, style: TextStyle(fontWeight: FontWeight.w600, color: theme.textTheme.titleLarge?.color)),
                                    const SizedBox(height: 6),
                                    Row(children: [Icon(Icons.star, size: 14, color: Colors.amber), const SizedBox(width: 6), Text('${item.reviews} reviews', style: TextStyle(color: theme.textTheme.bodySmall?.color))]),
                                    const SizedBox(height: 6),
                                    Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: EventouryColors.tangerine, borderRadius: BorderRadius.circular(6)), child: Text('\$${item.price}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))), const SizedBox(width: 8), Text('/person', style: TextStyle(color: theme.textTheme.bodySmall?.color))]),
                                  ]),
                                ),
                                const SizedBox(width: 12),
                                Text('${item.nights} day | ${item.nights} night', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ]);
                      }).toList())),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          // (bottom bar removed for this screen)
        ],
      ),
    );
  }
}
