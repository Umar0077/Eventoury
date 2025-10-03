import 'package:eventoury/mobile/home/frontend/category_details.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesList extends StatelessWidget {
  final Map<String, dynamic> category;
  const CategoriesList ({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    final categorydetails = [
      {
        'name': 'Adventure',
        'place': 'Thailand',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '459',
      },
      {
        'name': 'Family Tour',
        'place': 'Thailand',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '459',
      },
      {
        'name': 'Paragliding',
        'place': 'Thailand',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '459',
      },
      {
        'name': 'Baby Shower',
        'place': 'Thailand',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '459',
      },
      {
        'name': 'Wedding',
        'place': 'Thailand',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '459',
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            category['name'],
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
                "Explore Popular ${category['name']}",
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
                  childAspectRatio: 0.65,
                ),
                itemCount: categorydetails.length,
                itemBuilder: (context, index) {
                  final item = categorydetails[index];
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the category detail screen inside nested navigator (id: 1)
                        // Get.to(
                        //       () => CategoriesDetail(category: categorydetails[index]),
                        //   id: 1,
                        // );
                        Get.to(CategoryDetails(
                          image: item['image'] ?? '',        // Use empty string if null
                          name: item['name'] ?? '',
                          location: item['place'] ?? '',
                          rating: double.tryParse(item['rating'] ?? '0') ?? 0.0,
                          price: double.tryParse(item['price'] ?? '0') ?? 0.0,
                        ),
                            id : 1,
                        );
                      },
                      child: DetailCard(
                        image: item['image'] ?? '',        // Use empty string if null
                        title: item['name'] ?? '',
                        location: item['place'] ?? '',
                        rating: double.tryParse(item['rating'] ?? '0') ?? 0.0,
                        price: double.tryParse(item['price'] ?? '0') ?? 0.0,
                      )
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

class DetailCard extends StatelessWidget {

  final String image;
  final String title;
  final String location;
  final double rating;
  final double price;

  const DetailCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
    required this.price,
});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade500,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with heart icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    image,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: EventouryColors.electric_orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Location
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      Icon(Icons.star, color: Colors.amber, size: 14),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '\$$price/Person',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: EventouryColors.persimmon,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
      ],
    );
  }
}

