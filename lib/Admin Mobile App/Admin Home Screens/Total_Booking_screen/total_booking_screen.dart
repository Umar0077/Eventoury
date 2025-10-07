import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Dashboard/admin_dashboard.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/elevated_button_theme.dart';

class TotalBookingScreen extends StatefulWidget {
  const TotalBookingScreen({super.key});

  @override
  State<TotalBookingScreen> createState() => _TotalBookingScreenState();
}

class _TotalBookingScreenState extends State<TotalBookingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';
  String _selectedSort = 'Newest';

  final List<String> _statusOptions = ['All', 'Pending', 'Confirmed', 'Cancelled'];
  final List<String> _sortOptions = ['Newest', 'Oldest', 'Highest Value'];

  // Mock booking data
  final List<Map<String, dynamic>> _bookings = [
    {
      'id': '#BK2043',
      'customerName': 'John Smith',
      'vendorName': 'Ocean Adventures',
      'date': '2025-10-15 14:30',
      'amount': 299.99,
      'status': 'Confirmed',
    },
    {
      'id': '#BK2044',
      'customerName': 'Sarah Johnson',
      'vendorName': 'Mountain Tours',
      'date': '2025-10-16 09:00',
      'amount': 450.00,
      'status': 'Pending',
    },
    {
      'id': '#BK2045',
      'customerName': 'Mike Wilson',
      'vendorName': 'City Explorer',
      'date': '2025-10-14 16:45',
      'amount': 189.50,
      'status': 'Cancelled',
    },
    {
      'id': '#BK2046',
      'customerName': 'Emma Davis',
      'vendorName': 'Beach Resort',
      'date': '2025-10-17 11:20',
      'amount': 750.25,
      'status': 'Confirmed',
    },
    {
      'id': '#BK2047',
      'customerName': 'Tom Brown',
      'vendorName': 'Adventure Sports',
      'date': '2025-10-18 08:15',
      'amount': 320.80,
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Total Bookings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.offAll(() => const AdminDashboard()),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter and Search Section
          _buildFilterSection(context, isDark),
          
          // Bookings List Section
          Expanded(
            child: _buildBookingsList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, bool isDark) {
    final fieldBg = isDark ? Colors.black : Colors.white;
    final containerBg = isDark ? Colors.grey[900] : Colors.grey[50];
    final fieldShadow = isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.08);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field (wrapped to add shadow & theme-aware bg)
          Container(
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: fieldShadow,
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by Booking ID, Vendor, or Customer',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                filled: false,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Filter Controls
          Row(
            children: [
              Flexible(
                flex: 1,
                child: _buildDropdown(
                  context,
                  'Status',
                  _selectedStatus,
                  _statusOptions,
                  (value) => setState(() => _selectedStatus = value!),
                  fieldBg,
                  fieldShadow,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: _buildDropdown(
                  context,
                  'Sort',
                  _selectedSort,
                  _sortOptions,
                  (value) => setState(() => _selectedSort = value!),
                  fieldBg,
                  fieldShadow,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: EventouryElevatedButton(
                  onPressed: _applyFilters,
                  child: const Text('Apply Filters'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetFilters,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: EventouryColors.tangerine),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(color: EventouryColors.tangerine),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context,
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
    Color fieldBg,
    Color fieldShadow,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: fieldBg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: fieldShadow,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              filled: false,
            ),
            items: options.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingsList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _bookings.length + 1, // +1 for Load More button
      itemBuilder: (context, index) {
        if (index == _bookings.length) {
          return _buildLoadMoreButton();
        }
        return _buildBookingCard(context, _bookings[index]);
      },
    );
  }

  Widget _buildBookingCard(BuildContext context, Map<String, dynamic> booking) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? Theme.of(context).cardColor : Colors.white;
    final shadowColor = isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.08);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking['id'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusBadge(booking['status']),
              ],
            ),
            const SizedBox(height: 12),

            // Customer and Vendor Info
            _buildInfoRow(Icons.person, 'Customer', booking['customerName']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.business, 'Vendor', booking['vendorName']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.calendar_today, 'Date', booking['date']),
            const SizedBox(height: 12),

            // Amount and Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${booking['amount'].toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: EventouryColors.tangerine,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                EventouryElevatedButton(
                  onPressed: () => _showBookingDetails(booking),
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor = Colors.white;
    
    switch (status.toLowerCase()) {
      case 'confirmed':
        backgroundColor = Colors.green;
        break;
      case 'pending':
        backgroundColor = EventouryColors.tangerine;
        break;
      case 'cancelled':
        backgroundColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: EventouryElevatedButton(
          onPressed: _loadMoreBookings,
          child: const Text('Load More'),
        ),
      ),
    );
  }

  void _applyFilters() {
    // Implement filter logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filters applied successfully!')),
    );
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatus = 'All';
      _selectedSort = 'Newest';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filters reset!')),
    );
  }

  void _loadMoreBookings() {
    // Implement load more logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading more bookings...')),
    );
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildBookingDetailsModal(booking),
    );
  }

  Widget _buildBookingDetailsModal(Map<String, dynamic> booking) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modal Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking Details',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          
          // Booking Information
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem('Booking ID', booking['id']),
                  _buildDetailItem('Customer Name', booking['customerName']),
                  _buildDetailItem('Vendor Name', booking['vendorName']),
                  _buildDetailItem('Date & Time', booking['date']),
                  _buildDetailItem('Amount', '\$${booking['amount'].toStringAsFixed(2)}'),
                  _buildDetailItem('Status', booking['status']),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Additional Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem('Payment Method', 'Credit Card'),
                  _buildDetailItem('Transaction ID', 'TXN123456789'),
                  _buildDetailItem('Booking Created', '2025-10-01 10:30'),
                  _buildDetailItem('Last Updated', '2025-10-05 15:45'),
                ],
              ),
            ),
          ),
          
          // Action Buttons
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: EventouryElevatedButton(
                  onPressed: () => _confirmBooking(booking),
                  child: const Text('Mark as Confirmed'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _cancelBooking(booking),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel Booking',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: EventouryElevatedButton(
              onPressed: () => _sendReminderEmail(booking),
              child: const Text('Send Reminder Email'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmBooking(Map<String, dynamic> booking) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking ${booking['id']} confirmed!')),
    );
  }

  void _cancelBooking(Map<String, dynamic> booking) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking ${booking['id']} cancelled!')),
    );
  }

  void _sendReminderEmail(Map<String, dynamic> booking) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminder email sent for ${booking['id']}!')),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
