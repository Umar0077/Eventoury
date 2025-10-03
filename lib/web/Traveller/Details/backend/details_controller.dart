import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../AvailableDate/frontend/availabledate.dart';
import '../../authentication/signin_required.dart';

class DetailsController extends GetxController {
  final RxString destinationTitle = 'Beach'.obs;
  final RxString location = 'Bali, Indonesia'.obs;
  final RxString temperature = '21°C'.obs;
  final RxString country = 'Indonesia'.obs;
  final RxDouble rating = 4.7.obs;
  final RxInt reviewCount = 2498.obs;
  final RxString price = '\$59'.obs;
  final RxString priceUnit = 'Person'.obs;
  final RxBool isFavorite = false.obs;
  
  final RxString aboutDescription = '''You will get a complete travel package on the beaches. Packages in the form of airline tickets, recommended Hotel rooms, Transportation. Have you ever been on holiday to the Greek ETC...'''.obs;
  final RxString readMoreText = 'Read More'.obs;
  final RxBool isExpanded = false.obs;
  
  final List<String> galleryImages = [
    'assets/onboarding_images/onboarding_1.jpeg',
    'assets/onboarding_images/onboarding_2.jpeg',
    'assets/onboarding_images/onboarding_3.jpeg',
    'assets/onboarding_images/onboarding_4.jpeg',
  ];
  
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
  
  void toggleReadMore() {
    isExpanded.value = !isExpanded.value;
    readMoreText.value = isExpanded.value ? 'Read Less' : 'Read More';
  }
  
  void onBookNow() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.to(() => const SignInRequired());
      return;
    }
    Get.to(() => const AvailableDateScreen());
  }
  
  void updateDestination({
    required String title,
    required String locationName,
    required String countryName,
    required double ratingValue,
    required int reviews,
    required String priceValue,
  }) {
    destinationTitle.value = title;
    location.value = locationName;
    country.value = countryName;
    rating.value = ratingValue;
    reviewCount.value = reviews;
    price.value = priceValue;
  }
}