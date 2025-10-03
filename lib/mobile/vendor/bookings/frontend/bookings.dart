import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class VendorBookingScreen extends StatelessWidget {
  const VendorBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final bookings = {
      'Upcoming': [
        {
          'title': 'Siem Reap Adventure',
          'date': 'Sep 15, 2025',
          'location': 'Krong Siem Reap',
          'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
        },
        {
          'title': 'Bangkok Nightlife',
          'date': 'Sep 20, 2025',
          'location': 'Bangkok, Thailand',
          'image': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80',
        },
      ],
      'Completed': [
        {
          'title': 'Camping at Chongkranroy',
          'date': 'Aug 10, 2025',
          'location': 'Chongkranroy',
          'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
        },
        {
          'title': 'Phuket Beach Holiday',
          'date': 'Oct 5, 2025',
          'location': 'Phuket, Thailand',
          'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=400&q=80',
        },
      ],
    };

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('My Bookings', style: textTheme.titleLarge),
              elevation: 0,
              bottom: TabBar(
                dividerColor: Colors.transparent,
                unselectedLabelColor: isDark ? Colors.white : Colors.black,
                labelColor: EventouryColors.persimmon,
                indicatorColor: EventouryColors.persimmon,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _buildBookingList(bookings['Upcoming']!, theme, textTheme),
                _buildBookingList(bookings['Completed']!, theme, textTheme),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildBookingList(List bookings, ThemeData theme, TextTheme textTheme) {
    if (bookings.isEmpty) {
      return Center(child: Text('No bookings found.', style: textTheme.bodyLarge));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return _buildBookingCard(bookings[index], theme, textTheme, context);
      },
    );
  }

  Widget _buildBookingCard(Map booking, ThemeData theme, TextTheme textTheme, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 1,
      color: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: isDark ? Colors.white : Colors.black,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            booking['image'],
            width: 54,
            height: 54,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(booking['title'], style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(booking['location'], style: textTheme.bodySmall),
            Text(booking['date'], style: textTheme.bodySmall?.copyWith(color: theme.hintColor)),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.white : Colors.black,),
        onTap: () {},
      ),
    );
  }
}
