import 'package:eventoury/mobile/home/frontend/category_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/theme/text_theme.dart';
import '../categories.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Explore', style: Theme.of(context).textTheme.titleLarge),
              GestureDetector(
                onTap: () {Get.to(() => const Categories(), id: 1);},
                child: Text('View all', style: EventouryTextTheme.accentText)
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 13,
              itemBuilder: (context, index) {
                final categories = [
                  {
                    'name': 'Activities',
                    'image': 'assets/home_screen/events.jpg',
                  },
                  {
                    'name': 'Lessons /\nClasses',
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
                    'name': 'Tourist\nAttraction\nSpots',
                    'image': 'assets/home_screen/tour_packages.jpeg',
                  },
                  {
                    'name': 'Fitness &\nWellbeing',
                    'image': 'assets/home_screen/events.jpg',
                  },
                  {
                    'name': 'Cultural &\nHeritage &\nHistory',
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
                    'name': 'Tour\nPackages',
                    'image': 'assets/home_screen/tour_packages.jpeg',
                  },
                  {
                    'name': 'VIP Protocol',
                    'image': 'assets/home_screen/transport.jpg',
                  },
                ];
                return CategoryCard(
                  category: categories[index],
                  onTap: () {
                    Get.to(
                      () => CategoriesList(category: categories[index]),
                      id: 1,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, this.onTap});

  final Map<String, dynamic> category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 90,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/home_screen/circle (1).png',
                      width: 90, height: 90),
                  Container(
                    width: 70,
                    height: 70,
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
              SizedBox(
                height: 42,
                child: Text(
                  category['name'],
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
