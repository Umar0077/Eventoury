import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_list.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Transport',
        'image': 'assets/home_screen/transport.jpg',
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
        'name': 'Activities',
        'image': 'assets/home_screen/tour_packages.jpeg',
      },
      {
        'name': 'Guides',
        'image': 'assets/home_screen/tour_packages.jpeg',
      },
      {
        'name': 'Entertainment',
        'image': 'assets/home_screen/tour_packages.jpeg',
      },
      {
        'name': 'Hotels',
        'image': 'assets/home_screen/events.jpg',
      },
      {
        'name': 'Restaurants',
        'image': 'assets/home_screen/events.jpg',
      },
      {
        'name': 'Activities',
        'image': 'assets/home_screen/events.jpg',
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
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
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/home_screen/circle (1).png',
              width: 120,
              height: 120,
            ),
            Container(
              width: 90,
              height: 90,
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
        const SizedBox(height: 8),
        Text(
          category['name'],
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
