import 'package:eventoury/mobile/notification/frontend/notification_screen.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../controllers/home_controller.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {

    final HomeController controller = Get.put(HomeController());

    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Profile Picture with onTap
              GestureDetector(
                onTap: () {
                  controller.hideNavBar(); // hide nav bar
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FullscreenImage()),
                  ).then((_) {
                    controller.showNavBar(); // show nav bar when returning
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // Logo
              Image.asset(
                isDark
                    ? 'assets/app_logos/logo_5.png'
                    : 'assets/app_logos/logo_4.png',
                width: 120,
              ),
              const Spacer(),
              // Help Icon
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? Colors.grey[900] : Colors.grey[100],
                ),
                 child: GestureDetector(
                   onTap: () {Get.to(() => NotificationScreen());},
                   child: const Icon(Icons.notifications_outlined,
                       color: EventouryColors.tangerine),
                 ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class FullscreenImage extends StatefulWidget {
  const FullscreenImage({super.key});

  @override
  State<FullscreenImage> createState() => _FullscreenImageState();
}

class _FullscreenImageState extends State<FullscreenImage> {
  @override
  void initState() {
    super.initState();
    // Hide status and navigation bars
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Center(
              child: PhotoView(
                imageProvider: const NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600&h=600&fit=crop&crop=face',
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: const PhotoViewHeroAttributes(tag: "profilePic"),
              ),
            ),
            Positioned(
              top: 40,
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}