import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Dashboard/admin_dashboard.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/elevated_button_theme.dart';

class RevenueAdmin extends StatefulWidget {
  const RevenueAdmin({super.key});

  @override
  State<RevenueAdmin> createState() => _RevenueAdminState();
}

class _RevenueAdminState extends State<RevenueAdmin> {
  // Mock transaction data
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': '#TXN9021',
      'vendorName': 'Ocean Adventures',
      'customerName': 'John Smith',
      'date': '2025-10-15 14:30',
      'amount': 299.99,
      'status': 'Completed',
    },
    {
      'id': '#TXN9022',
      'vendorName': 'Mountain Tours',
      'customerName': 'Sarah Johnson',
      'date': '2025-10-16 09:00',
      'amount': 450.00,
      'status': 'Pending',
    },
    {
      'id': '#TXN9023',
      'vendorName': 'City Explorer',
      'customerName': 'Mike Wilson',
      'date': '2025-10-14 16:45',
      'amount': 189.50,
      'status': 'Failed',
    },
    {
      'id': '#TXN9024',
      'vendorName': 'Beach Resort',
      'customerName': 'Emma Davis',
      'date': '2025-10-17 11:20',
      'amount': 750.25,
      'status': 'Completed',
    },
    {
      'id': '#TXN9025',
      'vendorName': 'Adventure Sports',
      'customerName': 'Tom Brown',
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
          'Revenue This Month',
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
          children: [
            // Summary Metrics Section
            _buildSummaryMetrics(context),
            
            // Revenue Trends Chart Section
            _buildRevenueTrendsChart(context),
            
            // Transaction List Section
            _buildTransactionList(context),
            
            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryMetrics(BuildContext context) {
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
          _buildMetricCard(
            context,
            title: 'Total Revenue',
            subtitle: 'This Month',
            value: '\$2,340',
            isMainValue: true,
          ),
          _buildMetricCard(
            context,
            title: 'Average Revenue',
            subtitle: 'per Booking',
            value: '\$28.5',
            isMainValue: false,
          ),
          _buildMetricCard(
            context,
            title: 'Total Transactions',
            subtitle: 'This Month',
            value: '92',
            isMainValue: false,
          ),
          _buildMetricCard(
            context,
            title: 'Pending Payments',
            subtitle: 'Awaiting',
            value: '12',
            isMainValue: false,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
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

  Widget _buildRevenueTrendsChart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Revenue Trends',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 250,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).cardColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.04)
                      : Colors.black.withOpacity(0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    size: const Size(double.infinity, 180),
                    painter: RevenueTrendsChart(),
                  ),
                ),
                const SizedBox(height: 16),
                // Week labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('Week 1', style: TextStyle(fontSize: 12)),
                    Text('Week 2', style: TextStyle(fontSize: 12)),
                    Text('Week 3', style: TextStyle(fontSize: 12)),
                    Text('Week 4', style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'October 2025',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: EventouryColors.tangerine,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Transactions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _transactions.length + 1, // +1 for Load More button
            itemBuilder: (context, index) {
              if (index == _transactions.length) {
                return _buildLoadMoreButton();
              }
              return _buildTransactionCard(context, _transactions[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(
      BuildContext context, Map<String, dynamic> transaction) {
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
                  transaction['id'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusBadge(transaction['status']),
              ],
            ),
            const SizedBox(height: 12),

            // Transaction Info
            _buildInfoRow(Icons.business, 'Vendor', transaction['vendorName']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.person, 'Customer', transaction['customerName']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time, 'Date', transaction['date']),
            const SizedBox(height: 12),

            // Amount and Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${transaction['amount'].toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: EventouryColors.tangerine,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                EventouryElevatedButton(
                  onPressed: () => _showTransactionDetails(transaction),
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
      case 'completed':
        backgroundColor = Colors.green;
        break;
      case 'pending':
        backgroundColor = EventouryColors.tangerine;
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
          onPressed: _loadMoreTransactions,
          child: const Text('Load More'),
        ),
      ),
    );
  }

  void _loadMoreTransactions() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading more transactions...')),
    );
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildTransactionDetailsModal(transaction),
    );
  }

  Widget _buildTransactionDetailsModal(Map<String, dynamic> transaction) {
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
                'Transaction Details',
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
          
          // Transaction Information
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem('Transaction ID', transaction['id']),
                  _buildDetailItem('Vendor Name', transaction['vendorName']),
                  _buildDetailItem('Customer Name', transaction['customerName']),
                  _buildDetailItem('Date & Time', transaction['date']),
                  _buildDetailItem('Amount', '\$${transaction['amount'].toStringAsFixed(2)}'),
                  _buildDetailItem('Status', transaction['status']),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Payment Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem('Payment Method', 'Credit Card'),
                  _buildDetailItem('Reference Number', 'REF123456789'),
                  _buildDetailItem('Processing Fee', '\$2.50'),
                  _buildDetailItem('Net Amount', '\$${(transaction['amount'] - 2.50).toStringAsFixed(2)}'),
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
                  onPressed: () => _markAsCompleted(transaction),
                  child: const Text('Mark as Completed'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _refundPayment(transaction),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Refund Payment',
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
              onPressed: () => _sendReceipt(transaction),
              child: const Text('Send Receipt'),
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

  void _markAsCompleted(Map<String, dynamic> transaction) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaction ${transaction['id']} marked as completed!')),
    );
  }

  void _refundPayment(Map<String, dynamic> transaction) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Refund initiated for ${transaction['id']}!')),
    );
  }

  void _sendReceipt(Map<String, dynamic> transaction) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Receipt sent for ${transaction['id']}!')),
    );
  }
}

class RevenueTrendsChart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = EventouryColors.tangerine
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;



    // Data points for weekly revenue (normalized)
    final dataPoints = [580, 820, 650, 920]; // Weekly revenue data
    final maxValue = 1000.0;
    final barWidth = size.width / (dataPoints.length * 2);

    for (int i = 0; i < dataPoints.length; i++) {
      final x = (i * 2 + 1) * barWidth;
      final barHeight = (dataPoints[i] / maxValue) * size.height;
      final y = size.height - barHeight;

      // Draw bar
      final rect = Rect.fromLTWH(x - barWidth / 2, y, barWidth, barHeight);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        paint,
      );

      // Draw value labels on top of bars
      final textPainter = TextPainter(
        text: TextSpan(
          text: '\$${dataPoints[i]}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - 20),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
