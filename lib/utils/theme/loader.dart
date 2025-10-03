import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.image,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String image;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          isDark
              ? 'assets/loader/loader_light.gif'
              : 'assets/loader/loader_dark.gif',
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        const SizedBox(height: 50),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        if (showAction)
          SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
      ],
    );
  }
}

class FullScreenLoader {
  static void openLoadingDialogue(String text, String image) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          body: Center(
            child: AnimationLoaderWidget(text: text, image: image),
          ),
        ),
      ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}


class Loaders {
  static successSnackBar({required title, message = '', duration = 2}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: EventouryColors.tangerine,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Icons.check, color: Colors.white,)
    );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Icons.error, color: Colors.white,)
    );
  }

  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Icons.error, color: Colors.white,)
    );
  }

  static simpleSnackBar({required title, message = '', duration = 2, required BuildContext context}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
    );
  }
}
