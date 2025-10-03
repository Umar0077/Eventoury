import 'package:get/get.dart';

class NotificationItem {
  final String title;
  final String subtitle;
  final String timeAgo;
  final bool read;

  NotificationItem({required this.title, required this.subtitle, required this.timeAgo, this.read = false});
}

class NotificationsController extends GetxController {
  final notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // sample data
    notifications.addAll([
      NotificationItem(title: 'New Recommended place', subtitle: 'Just for you', timeAgo: '1 day ago'),
      NotificationItem(title: 'Your Booking Success', subtitle: 'You have been accepted as...', timeAgo: '1 day ago'),
      NotificationItem(title: 'Get an unlimited traveling', subtitle: 'Received summer special pr...', timeAgo: '2 day ago'),
    ]);
  }

  void markRead(int index) {
    // placeholder: could update read state
  }

  void openNotification(int index) {
    // placeholder: navigate to detail or perform action
  }
}
