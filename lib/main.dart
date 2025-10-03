import 'package:eventoury/splash_screen.dart';
import 'package:eventoury/web/Traveller/home/frontend/web_home_screen.dart';
// Ensure controller is available at app start
import 'package:eventoury/web/Traveller/home/backend/web_home_controller.dart';
// Add onboarding and mobile home imports so named routes referenced from
// the splash screen are registered and their page builders never return null.
import 'package:eventoury/web/Traveller/intro/frontend/web_onboarding.dart';
import 'package:eventoury/mobile/intro/frontend/onboarding.dart';
import 'package:eventoury/mobile/home/frontend/home_screen.dart';
// vendor pages are now mounted inside the VendorShell route. Imports of
// individual vendor page widgets are not required here to avoid rebuilds
// and unused-import diagnostics.
import 'web/Vendor/vendor_shell.dart';
import 'package:eventoury/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize storage
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Ensure the WebHomeController is registered as early as possible so
  // pages that call Get.find<WebHomeController>() won't fail during build.
  Get.put(WebHomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eventoury',
      themeMode: ThemeMode.system,
      theme: EventouryAppTheme.lightTheme,
      darkTheme: EventouryAppTheme.darkTheme,
      // app-level bindings handled during startup (registered before runApp)
          getPages: [
              GetPage(name: '/splash', page: () => const AnimatedSplashScreen()),
              GetPage(name: '/WebHomeScreen', page: () => const WebHomeScreen()),
              // Ensure onboarding and mobile home routes exist so calls like
              // Get.offAllNamed('/WebOnboarding') or '/Onboarding' succeed.
              GetPage(name: '/WebOnboarding', page: () => const WebOnboardingScreen()),
              GetPage(name: '/Onboarding', page: () => const OnboardingScreen()),
              GetPage(name: '/HomeScreen', page: () => HomeScreen()),
            GetPage(name: '/Vendor', page: () => const VendorShell()),
            GetPage(name: '/VendorHome', page: () => const VendorShell(initialIndex: 0)),
            GetPage(name: '/VendorBookings', page: () => const VendorShell(initialIndex: 1)),
            GetPage(name: '/VendorRevenue', page: () => const VendorShell(initialIndex: 2)),
            GetPage(name: '/VendorReviews', page: () => const VendorShell(initialIndex: 3)),
            GetPage(name: '/VendorInsights', page: () => const VendorShell(initialIndex: 4)),
            GetPage(name: '/VendorProfile', page: () => const VendorShell(initialIndex: 5)),
            GetPage(name: '/VendorPackages', page: () => const VendorShell(initialIndex: 6)),
          ],
  initialRoute: '/splash',
    );
  }
}
