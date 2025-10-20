import 'dart:async';

class AddPackageService {
  Future<String> uploadImage(/*File*/ dynamic image) async {
    // Mock upload - return a URL after delay
    await Future.delayed(const Duration(milliseconds: 300));
    return 'https://example.com/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  Future<bool> savePackage(Map<String, dynamic> data) async {
    // Mock save
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }
}
