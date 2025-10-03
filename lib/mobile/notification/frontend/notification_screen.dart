import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close,),
          onPressed: () => Get.back(),
        ),
        title: Text('Notification', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Today', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            _notificationItem(
              context,
              title: 'New Recommended place',
              subtitle: 'Just for you',
              time: '1 day ago',
            ),
            const SizedBox(height: 8),
            _notificationItem(
              context,
              title: 'Your Booking Success',
              subtitle: 'You have been accepted as..',
              time: '1 day ago',
            ),
            const SizedBox(height: 8),
            _notificationItem(
              context,
              title: 'Get an unlimited traveling',
              subtitle: 'Recieved summer special pr...',
              time: '2 day ago',
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem(BuildContext context, {required String title, required String subtitle, required String time}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall, overflow: TextOverflow.ellipsis,),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,),
                Text(time, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _gradientButton(context),
        ],
      ),
    );
  }

  Widget _gradientButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
          foregroundColor: Colors.white,
          minimumSize: const Size(60, 36),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text('View', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
