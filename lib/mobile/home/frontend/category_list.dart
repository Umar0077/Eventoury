import 'package:eventoury/mobile/home/frontend/category_details.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesList extends StatelessWidget {
  final Map<String, dynamic> category;
  const CategoriesList ({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    // Activities specific data
    final activitiesData = [
      {
        'name': 'Snorkeling',
        'place': 'Maldives',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '75',
      },
      {
        'name': 'Surfing',
        'place': 'Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.6',
        'price': '120',
      },
      {
        'name': 'Jet Ski',
        'place': 'Dubai',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '150',
      },
      {
        'name': 'Para Sailing',
        'place': 'Goa',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.5',
        'price': '80',
      },
      {
        'name': 'Trekking',
        'place': 'Nepal',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.9',
        'price': '200',
      },
      {
        'name': 'Flying Fish',
        'place': 'Maldives',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.4',
        'price': '95',
      },
      {
        'name': 'ATV',
        'place': 'Costa Rica',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '110',
      },
      {
        'name': 'Cycling',
        'place': 'Amsterdam',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.3',
        'price': '45',
      },
      {
        'name': 'Rafting',
        'place': 'Colorado',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '180',
      },
      {
        'name': 'Banana Boat',
        'place': 'Phuket',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.2',
        'price': '60',
      },
      {
        'name': 'Hot Air Balloon',
        'place': 'Cappadocia',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.9',
        'price': '350',
      },
      {
        'name': 'Flyingboarding',
        'place': 'Miami',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.5',
        'price': '220',
      },
      {
        'name': 'Boat / Yatch Cruise',
        'place': 'Mediterranean',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.7',
        'price': '450',
      },
      {
        'name': 'Helicopter Hire',
        'place': 'New York',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '800',
      },
      {
        'name': 'Beer Bus',
        'place': 'Prague',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.4',
        'price': '35',
      },
    ];

    // Lessons/Classes specific data
    final lessonsClassesData = [
      {
        'name': 'Yoga Classes',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '25',
      },
      {
        'name': 'Silver Jewellery Making Class',
        'place': 'Celuk, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.6',
        'price': '45',
      },
      {
        'name': 'Stitching & Sewing Classes',
        'place': 'Denpasar, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.4',
        'price': '30',
      },
      {
        'name': 'Batik Painting',
        'place': 'Yogyakarta',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '35',
      },
      {
        'name': 'Coffee Making',
        'place': 'Kintamani, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.5',
        'price': '40',
      },
      {
        'name': 'Yadnya (Traditional Bali Craft)',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.9',
        'price': '55',
      },
      {
        'name': 'Traditional Bali Music Classes',
        'place': 'Gianyar, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.6',
        'price': '50',
      },
      {
        'name': 'Cooking Classes',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '65',
      },
      {
        'name': 'Balinese Cooking Classes',
        'place': 'Sanur, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '70',
      },
      {
        'name': 'Surfing Classes',
        'place': 'Canggu, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.5',
        'price': '80',
      },
      {
        'name': 'Pottery & Ceramic',
        'place': 'Pejaten, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.4',
        'price': '42',
      },
      {
        'name': 'Wood Carving',
        'place': 'Mas Village, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '60',
      },
      {
        'name': 'Batik Classes',
        'place': 'Solo, Indonesia',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '38',
      },
      {
        'name': 'Traditional Bali Dance Classes',
        'place': 'Denpasar, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '48',
      },
      {
        'name': 'Scooter Lessons',
        'place': 'Seminyak, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.3',
        'price': '35',
      },
    ];

    // Transportation specific data
    final transportationData = [
      {
        'name': 'Rent a Car',
        'place': 'Bali Airport',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '35',
      },
      {
        'name': 'Fast Boat & Yatch',
        'place': 'Sanur Harbor',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '120',
      },
      {
        'name': 'Horse Carriage',
        'place': 'Gili Islands',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.4',
        'price': '25',
      },
      {
        'name': 'Electric Bike',
        'place': 'Ubud Center',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.5',
        'price': '15',
      },
      {
        'name': 'Rent a Scooter / Motor Cycle',
        'place': 'Seminyak',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.7',
        'price': '12',
      },
      {
        'name': 'Traditional Taxi',
        'place': 'Denpasar',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.2',
        'price': '20',
      },
      {
        'name': 'Ride Hailing',
        'place': 'All Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '8',
      },
      {
        'name': 'Cycle',
        'place': 'Rice Terraces',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.3',
        'price': '10',
      },
    ];

    // Guide specific data
    final guideData = [
      {
        'name': 'English Speaking',
        'place': 'Bali & Indonesia',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '45',
      },
      {
        'name': 'Male Guides',
        'place': 'All Destinations',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '40',
      },
      {
        'name': 'Multi Lingual',
        'place': 'Tourist Areas',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.9',
        'price': '55',
      },
      {
        'name': 'Female Guides',
        'place': 'All Destinations',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.6',
        'price': '42',
      },
    ];

    // Accommodation specific data
    final accommodationData = [
      {
        'name': 'Villas',
        'place': 'Seminyak, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '180',
      },
      {
        'name': 'Guest House',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.5',
        'price': '45',
      },
      {
        'name': 'Home Stay',
        'place': 'Canggu, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '35',
      },
      {
        'name': 'Budget Hotels',
        'place': 'Kuta, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.2',
        'price': '28',
      },
      {
        'name': 'Hostel',
        'place': 'Denpasar, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.1',
        'price': '15',
      },
      {
        'name': 'Apartment',
        'place': 'Sanur, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.4',
        'price': '65',
      },
      {
        'name': 'Capsule',
        'place': 'Jakarta',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.3',
        'price': '22',
      },
    ];

    // Entertainment specific data
    final entertainmentData = [
      {
        'name': 'Cinemas',
        'place': 'Denpasar Mall',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.4',
        'price': '8',
      },
      {
        'name': 'Beach Clubs',
        'place': 'Seminyak Beach',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.7',
        'price': '35',
      },
      {
        'name': 'Live Music Bars',
        'place': 'Ubud Center',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.6',
        'price': '25',
      },
      {
        'name': 'Kareoke (KTV)',
        'place': 'Kuta Area',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.3',
        'price': '20',
      },
      {
        'name': 'Shopping Malls',
        'place': 'Bali Collection',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.5',
        'price': '0',
      },
      {
        'name': 'Theme Parks',
        'place': 'Bali Safari',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '45',
      },
      {
        'name': 'Night Clubs',
        'place': 'Legian Street',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.4',
        'price': '30',
      },
      {
        'name': 'Night Bars',
        'place': 'Canggu Beach',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.5',
        'price': '22',
      },
    ];

    // Tourist Attraction Spots specific data
    final touristAttractionData = [
      {
        'name': 'Bali Bird Park',
        'place': 'Gianyar, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.6',
        'price': '35',
      },
      {
        'name': 'Theme Park Studio Bali',
        'place': 'Tabanan, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.4',
        'price': '45',
      },
      {
        'name': 'Bali Bom Water Park',
        'place': 'Gianyar, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.3',
        'price': '25',
      },
      {
        'name': 'Bali Zoo',
        'place': 'Gianyar, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.5',
        'price': '40',
      },
      {
        'name': 'Bali Shooting Gun Club',
        'place': 'Canggu, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.2',
        'price': '60',
      },
      {
        'name': 'Bali Handara Gate',
        'place': 'Bedugul, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '15',
      },
      {
        'name': 'Ubud Center',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '0',
      },
      {
        'name': 'Nusa Penida',
        'place': 'Nusa Penida Island',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.9',
        'price': '75',
      },
      {
        'name': 'Gili Islands',
        'place': 'Lombok',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.8',
        'price': '85',
      },
      {
        'name': 'Uluwatu',
        'place': 'Uluwatu, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.7',
        'price': '20',
      },
      {
        'name': 'Bali Golf',
        'place': 'Nusa Dua, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.6',
        'price': '120',
      },
      {
        'name': 'Ubud Palace',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.5',
        'price': '10',
      },
      {
        'name': 'Bali Safari',
        'place': 'Gianyar, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '55',
      },
      {
        'name': 'Campuhan Ridge Walk',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.6',
        'price': '0',
      },
      {
        'name': 'Botanical Garden',
        'place': 'Bedugul, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.4',
        'price': '18',
      },
      {
        'name': 'Seminyak Square',
        'place': 'Seminyak, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.3',
        'price': '0',
      },
      {
        'name': 'Nusa Lembongan',
        'place': 'Nusa Lembongan Island',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '65',
      },
      {
        'name': 'Lombok',
        'place': 'Lombok Island',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.8',
        'price': '90',
      },
      {
        'name': 'Bali Marine Park',
        'place': 'Sanur, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.5',
        'price': '45',
      },
      {
        'name': 'Sacred Monkey Forest',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.4',
        'price': '8',
      },
      {
        'name': 'Bali Swings',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '35',
      },
      {
        'name': 'Upside Down Museum',
        'place': 'Denpasar, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.2',
        'price': '25',
      },
      {
        'name': 'Banjar Hot Spring',
        'place': 'Buleleng, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.5',
        'price': '12',
      },
      {
        'name': 'Garuda Wisnu Kencana',
        'place': 'Uluwatu, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '30',
      },
      {
        'name': 'Art Galleries',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.3',
        'price': '15',
      },
      {
        'name': 'Nusa Ceningan',
        'place': 'Nusa Ceningan Island',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.6',
        'price': '55',
      },
      {
        'name': 'Menjangan Island',
        'place': 'West Bali National Park',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.8',
        'price': '80',
      },
      {
        'name': 'Temples',
        'place': 'All Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.7',
        'price': '5',
      },
      {
        'name': 'Rice Terrace',
        'place': 'Jatiluwih, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '10',
      },
      {
        'name': 'Beaches',
        'place': 'All Coastal Areas',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '0',
      },
      {
        'name': 'Water Falls',
        'place': 'North Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.7',
        'price': '8',
      },
      {
        'name': 'Volcanoes',
        'place': 'Mount Batur, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.9',
        'price': '50',
      },
      {
        'name': 'Museums',
        'place': 'Denpasar, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.2',
        'price': '12',
      },
      {
        'name': 'Art Markets',
        'place': 'Ubud & Sukawati',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.4',
        'price': '0',
      },
      {
        'name': 'Lakes',
        'place': 'Bedugul, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.5',
        'price': '15',
      },
      {
        'name': 'Komodo Island',
        'place': 'Flores, Indonesia',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.9',
        'price': '200',
      },
    ];

    // Fitness & Wellbeing specific data
    final fitnessWellbeingData = [
      {
        'name': 'Gym',
        'place': 'Seminyak, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.5',
        'price': '15',
      },
      {
        'name': 'Pilates',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.7',
        'price': '35',
      },
      {
        'name': 'Flower Bath Ritual Healing',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.8',
        'price': '65',
      },
      {
        'name': 'Spiritual Meditation',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.9',
        'price': '45',
      },
      {
        'name': 'Bali Padel',
        'place': 'Canggu, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.4',
        'price': '25',
      },
      {
        'name': 'Traditional SPA',
        'place': 'Sanur, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.8',
        'price': '80',
      },
      {
        'name': 'Sound Healing',
        'place': 'Ubud, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '55',
      },
      {
        'name': 'Spas',
        'place': 'Nusa Dua, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.6',
        'price': '90',
      },
    ];

    // Cultural & Heritage & History specific data
    final culturalHeritageData = [
      {
        'name': 'Penglipuran Village',
        'place': 'Bangli, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '25',
      },
      {
        'name': 'Garuda Wisnu Kencana Cultural Park',
        'place': 'Uluwatu, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '45',
      },
      {
        'name': 'Trunyan Village',
        'place': 'Kintamani, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.5',
        'price': '35',
      },
      {
        'name': 'Tenganan Village',
        'place': 'Karangasem, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.6',
        'price': '30',
      },
      {
        'name': 'MAS Village',
        'place': 'Gianyar, Bali',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.4',
        'price': '20',
      },
      {
        'name': 'Pesa Lakan Cultural Village',
        'place': 'Tabanan, Bali',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.3',
        'price': '28',
      },
      {
        'name': 'Kertalangu Cultural Village',
        'place': 'Denpasar, Bali',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.5',
        'price': '32',
      },
    ];

    // Tickets specific data
    final ticketsData = [
      {
        'name': 'Theme Parks',
        'place': 'Bali Safari & Marine Park',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '55',
      },
      {
        'name': 'Museums',
        'place': 'Bali Museum Denpasar',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.3',
        'price': '12',
      },
      {
        'name': 'Tourist Attractions',
        'place': 'Garuda Wisnu Kencana',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.7',
        'price': '30',
      },
      {
        'name': 'Beach Clubs & Other Clubs',
        'place': 'Potato Head Beach Club',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.6',
        'price': '40',
      },
      {
        'name': 'Cinemas',
        'place': 'XXI Cineplex Denpasar',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.2',
        'price': '8',
      },
      {
        'name': 'Activities',
        'place': 'Bali Treetop Adventure',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.5',
        'price': '25',
      },
    ];

    // Events specific data
    final eventsData = [
      {
        'name': 'Romantic Dinner',
        'place': 'Jimbaran Beach',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '120',
      },
      {
        'name': 'Weddings',
        'place': 'Uluwatu Clifftop',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.9',
        'price': '2500',
      },
      {
        'name': 'Bachelor Parties',
        'place': 'Seminyak Clubs',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '180',
      },
      {
        'name': 'Bachelorette Parties',
        'place': 'Beach Clubs Canggu',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '200',
      },
      {
        'name': 'Honeymoon',
        'place': 'Ubud Luxury Resort',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.9',
        'price': '450',
      },
      {
        'name': 'Birthdays',
        'place': 'Private Villa Seminyak',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.5',
        'price': '250',
      },
      {
        'name': 'Romantic Proposals',
        'place': 'Tanah Lot Sunset',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '300',
      },
      {
        'name': 'Baby Shower',
        'place': 'Garden Restaurant Ubud',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.4',
        'price': '150',
      },
    ];

    // Tour Packages specific data
    final tourPackagesData = [
      {
        'name': 'Honey Moon Tours',
        'place': 'Ubud & Seminyak',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.9',
        'price': '450',
      },
      {
        'name': 'Family Tours',
        'place': 'Bali Safari & Beaches',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '180',
      },
      {
        'name': 'Wellbeing Tours',
        'place': 'Ubud Wellness Centers',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.8',
        'price': '220',
      },
      {
        'name': 'Bar Hopping Tours',
        'place': 'Seminyak & Canggu',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.5',
        'price': '85',
      },
      {
        'name': 'Couple Tours',
        'place': 'Romantic Bali Spots',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '320',
      },
      {
        'name': 'Adventure Tours',
        'place': 'Mount Batur & Rafting',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.6',
        'price': '150',
      },
      {
        'name': 'Food Tours',
        'place': 'Traditional Markets',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.7',
        'price': '65',
      },
      {
        'name': 'Cultural & Heritage Tours',
        'place': 'Temples & Villages',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.8',
        'price': '95',
      },
      {
        'name': 'Backpacker Tours',
        'place': 'Budget Bali Circuit',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.4',
        'price': '45',
      },
      {
        'name': 'Spiritual Tours',
        'place': 'Sacred Temples',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.9',
        'price': '110',
      },
      {
        'name': 'Activity Tours',
        'place': 'Multi-Adventure',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.6',
        'price': '195',
      },
      {
        'name': 'Corporate Tours',
        'place': 'Team Building Venues',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.5',
        'price': '280',
      },
    ];

    // VIP Protocol specific data
    final vipProtocolData = [
      {
        'name': 'from Plane to Checkout',
        'place': 'Ngurah Rai Airport',
        'image': 'assets/home_screen/transport.jpg',
        'rating': '4.9',
        'price': '350',
      },
      {
        'name': 'Immigration & Customs',
        'place': 'Airport Immigration',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '120',
      },
      {
        'name': 'VIP Lounge Welcome Snacks',
        'place': 'Premier Lounge',
        'image': 'assets/home_screen/events.jpg',
        'rating': '4.7',
        'price': '85',
      },
      {
        'name': 'VIP Luxury Vehicle',
        'place': 'Premium Car Service',
        'image': 'assets/home_screen/tour_packages.jpeg',
        'rating': '4.8',
        'price': '150',
      },
    ];

    // Default data for other categories
    final defaultCategoryData = [
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

    // Choose data based on category
    final categorydetails = category['name'] == 'Activities' 
        ? activitiesData 
        : category['name'] == 'Lessons / Classes' 
            ? lessonsClassesData 
            : category['name'] == 'Transportation'
                ? transportationData
                : category['name'] == 'Guide'
                    ? guideData
                    : category['name'] == 'Accommodation'
                        ? accommodationData
                        : category['name'] == 'Entertainment'
                            ? entertainmentData
                            : category['name'] == 'Tourist Attraction Spots'
                                ? touristAttractionData
                                : category['name'] == 'Fitness & Wellbeing'
                                    ? fitnessWellbeingData
                                    : category['name'] == 'Cultural & Heritage & History'
                                        ? culturalHeritageData
                                        : category['name'] == 'Tickets'
                                            ? ticketsData
                                            : category['name'] == 'Events'
                                                ? eventsData
                                                : category['name'] == 'Tour Packages'
                                                    ? tourPackagesData
                                                    : category['name'] == 'VIP Protocol'
                                                        ? vipProtocolData
                                                        : defaultCategoryData;

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
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
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
                  Expanded(
                    child: Text(
                      location,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                      ...List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: index < rating.floor() ? Colors.amber : Colors.grey.shade300,
                          size: 14,
                        );
                      }),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

