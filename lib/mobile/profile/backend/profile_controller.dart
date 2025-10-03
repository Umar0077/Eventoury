import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  void updateUser() {
    user.value = _auth.currentUser;
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    user.value = _auth.currentUser;
    super.onInit();
  }

  void logout() async {
    await _auth.signOut();
    user.value = null;
    Get.offAllNamed('/login'); // Change route as needed
  }
}
