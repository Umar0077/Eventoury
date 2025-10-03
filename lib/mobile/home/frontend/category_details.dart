import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/theme/text_theme.dart';
import '../../booking/frontend/booking.dart';

class CategoryDetails extends StatelessWidget {

  final String name;
  final String location;
  final double rating;
  final double price;
  final String image;

  const CategoryDetails ({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Header image
              SizedBox(
                height: screenHeight * 0.45,
                width: double.infinity,
                child: Image.asset(
                  'assets/home_screen/tour_packages.jpeg', // replace with your image
                  fit: BoxFit.cover,
                ),
              ),

              // Scrollable content
              SingleChildScrollView(
                padding: EdgeInsets.only(top: screenHeight * 0.35),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and avatar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                location,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Temperature, Location, Rating, Price
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.thermostat, color: Colors.grey, size: 20),
                              SizedBox(width: 4),
                              Text("21C", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 20),
                                  SizedBox(width: 4),
                                  Text("4.7 (2498)", style: Theme.of(context).textTheme.labelLarge),
                                ],
                              ),
                              Text("\$59/Person", style: EventouryTextTheme.accentText),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Map preview
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(child: Text("Map Preview Here")),
                      ),
                      const SizedBox(height: 16),

                      // About Destination
                      const Text("About Destination", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text(
                        "You will get a complete travel package on the beaches. Packages in the form of airline tickets, recommended Hotel rooms, Transportation, Have you ever been on holiday to the Greek ETC...",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text("Read More", style: TextStyle(color: EventouryColors.persimmon)),

                      const SizedBox(height: 24),
                      // Book Now button
                      SizedBox(
                        width: double.infinity,
                        child: EventouryElevatedButton(onPressed: (){Get.to(() => BookingScreen());}, child: Text("Book Now")),
                      ),
                      const SizedBox(height: 90), // extra space for bottom navigation
                    ],
                  ),
                ),
              ),

              // Back & Bookmark buttons
              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.7),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.7),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

