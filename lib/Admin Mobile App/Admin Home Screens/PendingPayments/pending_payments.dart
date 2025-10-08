import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Dashboard/admin_dashboard.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/elevated_button_theme.dart';
import '../../Admin_Bottom_Navigation_bar/Admin_bottom_navigation_bar.dart';
import '../Admin_Add_new_Package/add_new_package_admin.dart';

class PendingPayments extends StatefulWidget {
  const PendingPayments({super.key});

  @override
  State<PendingPayments> createState() => _PendingPaymentsState();
}

class _PendingPaymentsState extends State<PendingPayments> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';
  String _selectedVendor = 'All';

  final List<String> _statusOptions = ['All', 'Awaiting Confirmation', 'Processing', 'Failed'];
  final List<String> _vendorOptions = ['All', 'Ocean Adventures', 'Mountain Resort', 'City Events', 'Beach Paradise'];

  // Mock pending payments data
  final List<Map<String, dynamic>> _pendingPayments = [
    {
      'transactionId': '#TXP-2384',
      'vendorName': 'Ocean Adventures',
      'customerName': 'John Smith',
      'amount': 299.99,
      'date': '2025-10-15',
      'status': 'Awaiting Confirmation',
      'bookingId': '#BK2043',
      'paymentMethod': 'Credit Card',
      'referenceNumber': 'REF123456789',
      'daysWaiting': 3,
    },
    {
      'transactionId': '#TXP-2385',
      'vendorName': 'Mountain Resort',
      'customerName': 'Sarah Johnson',
      'amount': 450.00,
      'date': '2025-10-12',
      'status': 'Processing',
      'bookingId': '#BK2044',
      'paymentMethod': 'Bank Transfer',
      'referenceNumber': 'REF987654321',
      'daysWaiting': 6,
    },
    {
      'transactionId': '#TXP-2386',
      'vendorName': 'City Events',
      'customerName': 'Mike Wilson',
      'amount': 189.50,
      'date': '2025-10-10',
      'status': 'Failed',
      'bookingId': '#BK2045',
      'paymentMethod': 'PayPal',
      'referenceNumber': 'REF456789123',
      'daysWaiting': 8,
    },
    {
      'transactionId': '#TXP-2387',
      'vendorName': 'Beach Paradise',
      'customerName': 'Emma Davis',
      'amount': 750.25,
      'date': '2025-10-14',
      'status': 'Awaiting Confirmation',
      'bookingId': '#BK2046',
      'paymentMethod': 'Credit Card',
      'referenceNumber': 'REF789123456',
      'daysWaiting': 4,
    },
    {
      'transactionId': '#TXP-2388',
      'vendorName': 'Adventure Sports',
      'customerName': 'Tom Brown',
      'amount': 320.80,
      'date': '2025-09-12',
      'status': 'Processing',
      'bookingId': '#BK2047',
      'paymentMethod': 'Digital Wallet',
      'referenceNumber': 'REF321654987',
      'daysWaiting': 25,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Total Pending Payments',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Section
            _buildSummarySection(context),

            // Filter and Search Section
            _buildFilterSection(context, isDark),

            // Pending Payments List Section (constrained height so inner list can scroll)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: _buildPendingPaymentsList(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminChildBottomNavigation(
        selectedIndex: 0,
        onTap: (idx) {
          if (idx == 99) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddNewPackageAdmin()));
            return;
          }
          Get.offAll(() => AdminDashboard(initialIndex: idx));
        },
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.2,
        children: [
          _buildSummaryCard(
            context,
            title: 'Total Pending',
            subtitle: 'Payments',
            value: '12',
            isMainValue: true,
          ),
          _buildSummaryCard(
            context,
            title: 'Pending Amount',
            subtitle: 'This Month',
            value: '\$3,420',
            isMainValue: true,
          ),
          _buildSummaryCard(
            context,
            title: 'Vendors Awaiting',
            subtitle: 'Payment',
            value: '8',
            isMainValue: false,
          ),
          _buildSummaryCard(
            context,
            title: 'Oldest Pending',
            subtitle: 'Transaction',
            value: 'Since 12 Sept',
            isMainValue: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String value,
    required bool isMainValue,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? Theme.of(context).cardColor : Colors.white;
    final shadowColor = isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.08);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isMainValue ? EventouryColors.tangerine : null,
            ),
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
          // Search Field
          Container(
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: fieldShadow, blurRadius: 12, offset: const Offset(0, 6))],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by Transaction ID, Vendor, or Booking ID',
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
                  'Vendor',
                  _selectedVendor,
                  _vendorOptions,
                  (value) => setState(() => _selectedVendor = value!),
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
            boxShadow: [BoxShadow(color: fieldShadow, blurRadius: 12, offset: const Offset(0, 6))],
          ),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              filled: false,
            ),
            items: options.map((option) {
              return DropdownMenuItem(value: option, child: Text(option));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildPendingPaymentsList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _pendingPayments.length + 1, // +1 for Load More button
      itemBuilder: (context, index) {
        if (index == _pendingPayments.length) {
          return _buildLoadMoreButton();
        }
        return _buildPaymentCard(context, _pendingPayments[index]);
      },
    );
  }

  Widget _buildPaymentCard(BuildContext context, Map<String, dynamic> payment) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? Theme.of(context).cardColor : Colors.white;
    final shadowColor = isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.08);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 14, offset: const Offset(0, 8))],
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
                  payment['transactionId'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusBadge(payment['status']),
              ],
            ),
            const SizedBox(height: 12),

            // Payment Info
            _buildInfoRow(Icons.business, 'Vendor', payment['vendorName']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.person, 'Customer', payment['customerName']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.calendar_today, 'Date', payment['date']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time, 'Waiting', '${payment['daysWaiting']} days'),
            const SizedBox(height: 12),

            // Amount and Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${payment['amount'].toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: EventouryColors.tangerine,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                EventouryElevatedButton(
                  onPressed: () => _showPaymentDetails(payment),
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
      case 'awaiting confirmation':
        backgroundColor = EventouryColors.tangerine;
        break;
      case 'processing':
        backgroundColor = Colors.yellow[700]!;
        break;
      case 'failed':
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
          onPressed: _loadMorePayments,
          child: const Text('Load More'),
        ),
      ),
    );
  }

  void _applyFilters() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filters applied successfully!')),
    );
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatus = 'All';
      _selectedVendor = 'All';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filters reset!')),
    );
  }

  void _loadMorePayments() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading more pending payments...')),
    );
  }

  void _showPaymentDetails(Map<String, dynamic> payment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildPaymentDetailsModal(payment),
    );
  }

  Widget _buildPaymentDetailsModal(Map<String, dynamic> payment) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modal Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment Details',
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
          
          // Payment Information
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem('Transaction ID', payment['transactionId']),
                  _buildDetailItem('Booking ID', payment['bookingId']),
                  _buildDetailItem('Vendor Name', payment['vendorName']),
                  _buildDetailItem('Customer Name', payment['customerName']),
                  _buildDetailItem('Amount', '\$${payment['amount'].toStringAsFixed(2)}'),
                  _buildDetailItem('Date', payment['date']),
                  _buildDetailItem('Status', payment['status']),
                  _buildDetailItem('Days Waiting', '${payment['daysWaiting']} days'),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Payment Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem('Payment Method', payment['paymentMethod']),
                  _buildDetailItem('Reference Number', payment['referenceNumber']),
                  _buildDetailItem('Processing Fee', '\$5.00'),
                  _buildDetailItem('Net Amount', '\$${(payment['amount'] - 5.00).toStringAsFixed(2)}'),
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
                  onPressed: () => _markAsCompleted(payment),
                  child: const Text('Mark as Completed'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _reconfirmPayment(payment),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: EventouryColors.tangerine),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Reconfirm',
                    style: TextStyle(color: EventouryColors.tangerine),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _cancelTransaction(payment),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cancel Transaction',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: EventouryElevatedButton(
                  onPressed: () => _contactVendor(payment),
                  child: const Text('Contact Vendor'),
                ),
              ),
            ],
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
            width: 130,
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

  void _markAsCompleted(Map<String, dynamic> payment) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment ${payment['transactionId']} marked as completed!')),
    );
  }

  void _reconfirmPayment(Map<String, dynamic> payment) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment ${payment['transactionId']} reconfirmed!')),
    );
  }

  void _cancelTransaction(Map<String, dynamic> payment) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaction ${payment['transactionId']} cancelled!')),
    );
  }

  void _contactVendor(Map<String, dynamic> payment) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contacting vendor for ${payment['transactionId']}...')),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
