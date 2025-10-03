import 'package:eventoury/mobile/authentication/frontend/login_screen.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/backend/profile_controller.dart';


class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistItems = [
      {
        'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
        'title': 'Camping 1 night at chongkranroy',
        'rating': 3,
        'reviews': 100,
        'location': 'Krong Siem Reap',
        'price': '25',
        'duration': '2 day 1 night',
      },
      {
        'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
        'title': '2 day 1 night Siem Reap',
        'rating': 3,
        'reviews': 100,
        'location': 'Krong Siem Reap',
        'price': '25',
        'duration': '2 day 1 night',
      },
      {
        'image': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80',
        'title': '2 day Bangkok, Thailand',
        'rating': 3,
        'reviews': 100,
        'location': 'Krong Siem Reap',
        'price': '25',
        'duration': '2 day 1 night',
      },
    ];

    // Use GetX ProfileController for user state
    final profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (profileController.user.value == null) {
            // Not logged in: show login prompt
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 64, color: EventouryColors.tangerine),
                  const SizedBox(height: 20),
                  Text('Please log in to view your wishlist', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 24),
                  EventouryElevatedButton(onPressed: () {Get.to(() => LoginScreen());}, child: Text('Login'))
                ],
              ),
            );
          }
          // Logged in: show wishlist content
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 0),
                  Center(
                    child: Text(
                      'Wishlist',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: wishlistItems.length,
                    separatorBuilder: (_, __) => const Divider(height: 32),
                    itemBuilder: (context, index) {
                      final item = wishlistItems[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item['image'] as String,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    ...List.generate(5, (i) => Icon(
                                      Icons.star,
                                      size: 18,
                                      color: i < (item['rating'] as int) ? Colors.orange : Colors.grey.shade300,
                                    )),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${item['reviews']} reviews',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['location'] as String,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'from ',
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      TextSpan(
                                        text: ' 25',
                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: '/person',
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item['duration'] as String,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
