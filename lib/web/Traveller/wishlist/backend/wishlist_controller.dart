import 'package:get/get.dart';

class WishlistItem {
  final String title;
  final String location;
  final int nights;
  final double rating;
  final int reviews;
  final double price;
  final String image;

  WishlistItem({required this.title, required this.location, required this.nights, required this.rating, required this.reviews, required this.price, required this.image});
}

class WishlistController extends GetxController {
  final items = <WishlistItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    items.addAll([
      WishlistItem(title: 'Camping 1 night at chongkranroy', location: 'Krong Siem Reap', nights: 1, rating: 4.8, reviews: 100, price: 25, image: 'assets/home_screen/events.jpg'),
      WishlistItem(title: '2 day 1 nigh Siem Reap', location: 'Krong Siem Reap', nights: 2, rating: 4.7, reviews: 100, price: 35, image: 'assets/home_screen/events.jpg'),
      WishlistItem(title: '2 day Bangkok, Thailand', location: 'Bangkok, Thailand', nights: 2, rating: 4.6, reviews: 100, price: 45, image: 'assets/home_screen/events.jpg'),
    ]);
  }

  void openItem(int index) {
    // placeholder: navigate to detail page
  }
}
