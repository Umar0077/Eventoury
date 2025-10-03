import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import 'package:get/get.dart';

import '../../booking/frontend/booking.dart';

class AllPopularDealsScreen extends StatelessWidget {
  const AllPopularDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deals = [
      {
        'image': 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300&h=200&fit=crop',
        'title': 'Beach View, Thailand',
        'details': ['Beach View', 'Free Wifi'],
        'rating': 4.5,
        'location': 'Thailand',
        'isFavorite': true,
      },
      {
        'image': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=300&h=200&fit=crop',
        'title': 'Bungalow, Maldives',
        'details': ['Bora Bora Bungalow', 'Free Wifi'],
        'rating': 4.5,
        'location': 'Maldives',
        'isFavorite': true,
      },
      {
        'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=200&fit=crop',
        'title': 'Mountain Resort',
        'details': ['Mountain View', 'Free Wifi'],
        'rating': 4.8,
        'location': 'Switzerland',
        'isFavorite': false,
      },
      {
        'image': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=300&h=200&fit=crop',
        'title': 'City Hotel',
        'details': ['City Center', 'Free Wifi'],
        'rating': 4.3,
        'location': 'Paris',
        'isFavorite': false,
      },
      {
        'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=300&h=200&fit=crop',
        'title': 'Luxury Villa',
        'details': ['Private Pool', 'Free Wifi'],
        'rating': 4.7,
        'location': 'Bali',
        'isFavorite': true,
      },
      {
        'image': 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=300&h=200&fit=crop',
        'title': 'Desert Camp',
        'details': ['Desert View', 'Free Wifi'],
        'rating': 4.2,
        'location': 'Dubai',
        'isFavorite': false,
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Popular Deals', style: Theme.of(context).textTheme.titleLarge,),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(id: 1), // pops only nested route
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Explore All Popular Deals",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                itemCount: deals.length,
                itemBuilder: (context, index) {
                  final deal = deals[index] as Map<String, dynamic>;
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {Get.to(BookingScreen());},
                        child: Container(
                          height: 130, // Optimized height to prevent overflow
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Left side - Image
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                child: Image.network(
                                  deal['image'],
                                  width: 120,
                                  height: 130, // Match container height
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Right side - Information panel
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8), // Further reduced padding
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2C2C2C), // Dark brown/black background
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title and favorite icon
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              deal['title'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16, // Further reduced font size
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1, // Only 1 line for title
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            deal['isFavorite']
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: deal['isFavorite'] ? EventouryColors.electric_orange : Colors.white70,
                                            size: 16, // Further reduced icon size
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5), // Further reduced spacing
                                      // Features - Only 1 item to save space
                                      Text(
                                        '• ${deal['details'][0]}', // Only show first feature
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12, // Further reduced font size
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      // Rating
                                      Row(
                                        children: [
                                          ...List.generate(
                                            5,
                                                (index) => Icon(
                                              Icons.star,
                                              size: 12, // Further reduced star size
                                              color: index < deal['rating'].floor()
                                                  ? Colors.amber
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            deal['rating'].toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10, // Further reduced font size
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5), // Further reduced spacing
                                      // Location
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 10, // Further reduced icon size
                                            color: Colors.white70,
                                          ),
                                          const SizedBox(width: 2),
                                          Expanded(
                                            child: Text(
                                              deal['location'],
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 10, // Further reduced font size
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6), // Further reduced spacing
                                      // Book Now button
                                      Container(
                                        width: double.infinity,
                                        height: 24, // Further reduced button height
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Book Now',
                                              style: TextStyle(
                                                color: Color(0xFF2C2C2C),
                                                fontSize: 10, // Further reduced font size
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            const Icon(
                                              Icons.arrow_forward,
                                              color: Color(0xFF2C2C2C),
                                              size: 12, // Further reduced icon size
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,)
                    ],
                  );
                },
              ),
              SizedBox(height: 80,),
            ],
          ),
        )
      ),
    );
  }
}
