import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/web/Traveller/notifications/backend/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsWeb extends StatelessWidget {
  const NotificationsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
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
          // Top nav reuse pattern
          Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: theme.dividerColor.withOpacity(0.1), width: 1))),
            child: Row(children: [Image.asset(theme.brightness == Brightness.dark ? 'assets/app_logos/logo_5.png' : 'assets/app_logos/logo_4.png', height: 36)]),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Notification', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)),
                      const SizedBox(height: 20),

                      Text('Today', style: TextStyle(fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color)),
                      const SizedBox(height: 16),

                      Obx(() => Column(children: controller.notifications.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final item = entry.value;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  CircleAvatar(radius: 24, backgroundColor: Colors.blue.shade100),
                                  const SizedBox(width: 12),
                                  Expanded(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.title, style: TextStyle(fontWeight: FontWeight.w600, color: theme.textTheme.titleLarge?.color)), const SizedBox(height: 6), Text(item.subtitle, style: TextStyle(color: theme.textTheme.bodySmall?.color)), const SizedBox(height: 6), Text(item.timeAgo, style: TextStyle(color: theme.textTheme.bodySmall?.color, fontSize: 12))])),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    width: 72,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                        backgroundColor: EventouryColors.tangerine,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      onPressed: () => controller.openNotification(idx),
                                      child: const Text('View', style: TextStyle(color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList())),

                      const SizedBox(height: 40),
                      // footer
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: isDesktop ? 30 : isTablet ? 25 : 20, horizontal: isDesktop ? 80 : isTablet ? 40 : 20),
                        decoration: BoxDecoration(border: Border(top: BorderSide(color: theme.dividerColor.withOpacity(0.08), width: 1))),
                        child: Text('© 2024 Eventoury. All Rights Reserved.', style: TextStyle(color: theme.textTheme.bodySmall?.color)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
