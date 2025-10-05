import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_list.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Activities',
        'image': 'assets/home_screen/events.jpg',
      },
      {
        'name': 'Lessons / Classes',
        'image': 'assets/home_screen/transport.jpg',
      },
      {
        'name': 'Transportation',
        'image': 'assets/home_screen/transport.jpg',
      },
      {
        'name': 'Guide',
        'image': 'assets/home_screen/tour_packages.jpeg',
      },
      {
        'name': 'Accommodation',
        'image': 'assets/home_screen/tour_packages.jpeg',
      },
      {
        'name': 'Entertainment',
        'image': 'assets/home_screen/events.jpg',
      },
      {
        'name': 'Tourist Attraction Spots',
        'image': 'assets/home_screen/tour_packages.jpeg',
      },
      {
        'name': 'Fitness & Wellbeing',
        'image': 'assets/home_screen/events.jpg',
      },
      {
        'name': 'Cultural & Heritage & History',
        'image': 'assets/home_screen/tour_packages.jpeg',
      },
      {
        'name': 'Tickets',
        'image': 'assets/home_screen/events.jpg',
      },
      {
        'name': 'Events',
        'image': 'assets/home_screen/events.jpg',
      },
      {
        'name': 'Tour Packages',
        'image': 'assets/home_screen/tour_packages.jpeg',
      },
      {
        'name': 'VIP Protocol',
        'image': 'assets/home_screen/transport.jpg',
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Categories",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(id: 1), // pops only nested route
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore All Categories",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true, // Important for SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // disable GridView scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: MediaQuery.of(context).size.width > 400 ? 0.95 : 0.9, // Responsive aspect ratio
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the category detail screen inside nested navigator (id: 1)
                        Get.to(
                              () => CategoriesList(category: categories[index]),
                          id: 1,
                        );
                      },
                      child: CategoryCard(category: categories[index]),
                    ),

                  );
                },
              ),
              SizedBox(height: 80,)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 400;
    
    // Responsive sizing
    final outerCircleSize = isLargeScreen ? 130.0 : 120.0;
    final innerCircleSize = isLargeScreen ? 100.0 : 90.0;
    final fontSize = isLargeScreen ? 14.0 : 13.0;
    
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/home_screen/circle (1).png',
                  width: outerCircleSize,
                  height: outerCircleSize,
                ),
                Container(
                  width: innerCircleSize,
                  height: innerCircleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(category['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            flex: 1,
            child: Text(
              category['name'],
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
