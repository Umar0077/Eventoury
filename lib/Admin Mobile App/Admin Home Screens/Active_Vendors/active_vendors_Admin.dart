import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Dashboard/admin_dashboard.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/theme/elevated_button_theme.dart';

class ActiveVendorsAdmin extends StatefulWidget {
  const ActiveVendorsAdmin({super.key});

  @override
  State<ActiveVendorsAdmin> createState() => _ActiveVendorsAdminState();
}

class _ActiveVendorsAdminState extends State<ActiveVendorsAdmin> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedLocation = 'All';
  String _selectedStatus = 'All';

  final List<String> _categoryOptions = ['All', 'Hotels', 'Tour Operators', 'Event Planners', 'Restaurants', 'Transport'];
  final List<String> _locationOptions = ['All', 'New York', 'Los Angeles', 'London', 'Paris', 'Tokyo'];
  final List<String> _statusOptions = ['All', 'Active', 'Recently Joined', 'Top Rated'];

  // Mock vendor data
  final List<Map<String, dynamic>> _vendors = [
    {
      'id': 'VND001',
      'name': 'Ocean Adventures',
      'businessType': 'Tour Operator',
      'location': 'Miami, FL',
      'rating': 4.8,
      'bookingsCount': 156,
      'email': 'contact@oceanadventures.com',
      'phone': '+1 (555) 123-4567',
      'status': 'Active',
      'joinDate': '2024-03-15',
      'monthlyRevenue': 12500.00,
    },
    {
      'id': 'VND002',
      'name': 'Mountain Resort',
      'businessType': 'Luxury Hotel',
      'location': 'Denver, CO',
      'rating': 4.6,
      'bookingsCount': 89,
      'email': 'info@mountainresort.com',
      'phone': '+1 (555) 987-6543',
      'status': 'Top Rated',
      'joinDate': '2024-01-20',
      'monthlyRevenue': 8750.00,
    },
    {
      'id': 'VND003',
      'name': 'City Event Planners',
      'businessType': 'Event Organizer',
      'location': 'New York, NY',
      'rating': 4.9,
      'bookingsCount': 234,
      'email': 'hello@cityevents.com',
      'phone': '+1 (555) 456-7890',
      'status': 'Recently Joined',
      'joinDate': '2024-09-01',
      'monthlyRevenue': 15200.00,
    },
    {
      'id': 'VND004',
      'name': 'Beach Paradise',
      'businessType': 'Resort',
      'location': 'San Diego, CA',
      'rating': 4.7,
      'bookingsCount': 178,
      'email': 'reservations@beachparadise.com',
      'phone': '+1 (555) 321-0987',
      'status': 'Active',
      'joinDate': '2024-02-10',
      'monthlyRevenue': 11800.00,
    },
    {
      'id': 'VND005',
      'name': 'Adventure Sports',
      'businessType': 'Activity Provider',
      'location': 'Austin, TX',
      'rating': 4.5,
      'bookingsCount': 92,
      'email': 'bookings@adventuresports.com',
      'phone': '+1 (555) 654-3210',
      'status': 'Active',
      'joinDate': '2024-04-05',
      'monthlyRevenue': 6900.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Active Vendors',
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
          
          // Vendors List Section
          Expanded(
            child: _buildVendorsList(context),
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
              boxShadow: [
                BoxShadow(color: fieldShadow, blurRadius: 12, offset: const Offset(0, 6)),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by vendor name, email, or ID',
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
                  'Category',
                  _selectedCategory,
                  _categoryOptions,
                  (value) => setState(() => _selectedCategory = value!),
                  fieldBg,
                  fieldShadow,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: _buildDropdown(
                  context,
                  'Location',
                  _selectedLocation,
                  _locationOptions,
                  (value) => setState(() => _selectedLocation = value!),
                  fieldBg,
                  fieldShadow,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

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
              const SizedBox(width: 8),
              const Flexible(flex: 1, child: SizedBox()), // Empty space for alignment
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

  Widget _buildVendorsList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _vendors.length + 1, // +1 for Load More button
      itemBuilder: (context, index) {
        if (index == _vendors.length) {
          return _buildLoadMoreButton();
        }
        return _buildVendorCard(context, _vendors[index]);
      },
    );
  }

  Widget _buildVendorCard(BuildContext context, Map<String, dynamic> vendor) {
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendor['name'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vendor['businessType'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(vendor['status']),
              ],
            ),
            const SizedBox(height: 12),

            // Vendor Info
            _buildInfoRow(Icons.location_on, vendor['location']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.email, vendor['email']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.phone, vendor['phone']),
            const SizedBox(height: 12),

            // Rating and Bookings Row
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  vendor['rating'].toString(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.book_online,
                  color: EventouryColors.tangerine,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${vendor['bookingsCount']} bookings',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: EventouryColors.tangerine,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action Buttons Row
            Row(
              children: [
                Expanded(
                  child: EventouryElevatedButton(
                    onPressed: () => _showVendorProfile(vendor),
                    child: const Text('View Profile'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _deactivateVendor(vendor),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Deactivate',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
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
      case 'active':
        backgroundColor = Colors.green;
        break;
      case 'recently joined':
        backgroundColor = EventouryColors.tangerine;
        break;
      case 'top rated':
        backgroundColor = Colors.purple;
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
          onPressed: _loadMoreVendors,
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
      _selectedCategory = 'All';
      _selectedLocation = 'All';
      _selectedStatus = 'All';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filters reset!')),
    );
  }

  void _loadMoreVendors() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading more vendors...')),
    );
  }

  void _deactivateVendor(Map<String, dynamic> vendor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deactivate Vendor'),
          content: Text('Are you sure you want to deactivate ${vendor['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            EventouryElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${vendor['name']} has been deactivated!')),
                );
              },
              child: const Text('Deactivate'),
            ),
          ],
        );
      },
    );
  }

  void _showVendorProfile(Map<String, dynamic> vendor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildVendorProfileModal(vendor),
    );
  }

  Widget _buildVendorProfileModal(Map<String, dynamic> vendor) {
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
                'Vendor Profile',
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
          
          // Vendor Information
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: EventouryColors.tangerine,
                        child: Text(
                          vendor['name'][0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vendor['name'],
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              vendor['businessType'],
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildStatusBadge(vendor['status']),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Business Details
                  Text(
                    'Business Details',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem('Vendor ID', vendor['id']),
                  _buildDetailItem('Business Type', vendor['businessType']),
                  _buildDetailItem('Location', vendor['location']),
                  _buildDetailItem('Email', vendor['email']),
                  _buildDetailItem('Phone', vendor['phone']),
                  _buildDetailItem('Join Date', vendor['joinDate']),
                  const SizedBox(height: 24),
                  
                  // Performance Metrics
                  Text(
                    'Performance Metrics',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem('Rating', '${vendor['rating']} / 5.0'),
                  _buildDetailItem('Total Bookings', vendor['bookingsCount'].toString()),
                  _buildDetailItem('Monthly Revenue', '\$${vendor['monthlyRevenue'].toStringAsFixed(2)}'),
                  _buildDetailItem('Status', vendor['status']),
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
                  onPressed: () => _contactVendor(vendor),
                  child: const Text('Contact Vendor'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _sendWarning(vendor),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Send Warning',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _deactivateVendorFromProfile(vendor),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Deactivate Vendor',
                style: TextStyle(color: Colors.red),
              ),
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

  void _contactVendor(Map<String, dynamic> vendor) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contacting ${vendor['name']}...')),
    );
  }

  void _sendWarning(Map<String, dynamic> vendor) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Warning sent to ${vendor['name']}!')),
    );
  }

  void _deactivateVendorFromProfile(Map<String, dynamic> vendor) {
    Navigator.pop(context);
    _deactivateVendor(vendor);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
