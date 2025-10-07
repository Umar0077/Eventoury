import 'package:eventoury/web/Vendor/vendor_layout.dart';
import 'package:eventoury/Admin Mobile App/Admin Home Screens/Dashboard/admin_dashboard.dart';
import 'package:eventoury/web/Vendor/vendor_shell_controller.dart';
import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ActivePackagesScreen extends StatefulWidget {
  const ActivePackagesScreen({super.key});

  @override
  State<ActivePackagesScreen> createState() => _ActivePackagesScreenState();
}

class _ActivePackagesScreenState extends State<ActivePackagesScreen> {
  String selectedLocation = 'All';
  String selectedStatus = 'All';
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> packages = [
    {
      'title': 'Hunza Trip Deluxe',
      'subtitle': 'Explore the breathtaking Hunza Valley',
      'price': '\$900',
      'location': 'Hunza Valley',
      'status': 'Active',
    },
    {
      'title': 'City Tour',
      'subtitle': "Guided tour around the city's landmarks",
      'price': '\$150',
      'location': 'Lahore',
      'status': 'Active',
    },
    {
      'title': 'Beach Resort Getaway',
      'subtitle': 'Relax at a luxury beach resort',
      'price': '\$1200',
      'location': 'Goa',
      'status': 'Inactive',
    },
  ];

  List<Map<String, String>> get filteredPackages {
    final q = searchController.text.toLowerCase();
    return packages.where((p) {
      if (selectedLocation != 'All' && p['location'] != selectedLocation) return false;
      if (selectedStatus != 'All' && p['status'] != selectedStatus) return false;
      if (q.isNotEmpty && !(p['title']!.toLowerCase().contains(q) || p['subtitle']!.toLowerCase().contains(q))) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return VendorLayout(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                IconButton(onPressed: () async {
                  try {
                    final ctrl = Get.find<VendorShellController>();
                    ctrl.setIndex(0);
                  } catch (_) {
                    Get.offAll(() => const AdminDashboard());
                    try {
                      final ctrl2 = Get.find<VendorShellController>();
                      ctrl2.setIndex(0);
                    } catch (_) {}
                  }
                }, icon: const Icon(Icons.arrow_back)),
                Text('Packages', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              ]),
              SizedBox(
                width: 420,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                          hintText: 'Search',
                          filled: true,
                          fillColor: isDark ? theme.cardColor : Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 12),
                    CircleAvatar(radius: 18, backgroundColor: Colors.grey.shade200, child: const Icon(Icons.person, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // filters
          Row(
            children: [
              DropdownButton<String>(
                value: selectedLocation,
                dropdownColor: isDark ? theme.cardColor : Colors.white,
                style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                items: ['All', 'Hunza Valley', 'Lahore', 'Goa'].map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                onChanged: (v) => setState(() => selectedLocation = v ?? 'All'),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: selectedStatus,
                dropdownColor: isDark ? theme.cardColor : Colors.white,
                style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white : theme.textTheme.bodyMedium?.color),
                items: ['All', 'Active', 'Inactive'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (v) => setState(() => selectedStatus = v ?? 'All'),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // packages list
          // Use a shrink-wrapped ListView here because the outer VendorLayout
          // wraps the page content in a SingleChildScrollView. Using Expanded
          // inside a scrollable causes the 'non-zero flex but incoming height
          // constraints are unbounded' runtime assertion. Making the inner
          // ListView non-scrollable and shrink-wrapped lets the outer
          // scroll view manage scrolling.
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredPackages.length,
            itemBuilder: (context, index) {
              final p = filteredPackages[index];
              return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: isDark ? theme.cardColor : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06)),
                    boxShadow: [BoxShadow(color: isDark ? Colors.black.withOpacity(0.12) : Colors.black.withOpacity(0.04), blurRadius: isDark ? 6 : 8, offset: const Offset(0, 4))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(p['title']!, style: theme.textTheme.titleMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : theme.textTheme.titleMedium?.color))),
                                      if (p['status'] == 'Active')
                                        Container(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10), decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(8)), child: const Text('Active', style: TextStyle(color: Colors.white))),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(p['subtitle']!, style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color)),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text(p['price']!, style: theme.textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : theme.textTheme.titleMedium?.color)), const SizedBox(height: 6), Text(p['location']!, style: theme.textTheme.bodySmall?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodySmall?.color))]),
                                      const SizedBox(width: 24),
                                      Expanded(child: Text(p['subtitle']!, style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color))),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(children: [
                                    TextButton(onPressed: () {}, child: Text('Edit', style: TextStyle(color: EventouryColors.tangerine))),
                                    TextButton(onPressed: () {}, child: Text('Delete', style: TextStyle(color: EventouryColors.tangerine))),
                                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: isDark ? EventouryColors.tangerine : EventouryColors.tangerine), child: const Text('View'))
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          // add new package button anchored bottom-right
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              onPressed: () async {
                try {
                  // switch into the VendorShell and open the Add New Package tab
                  final ctrl = Get.find<VendorShellController>();
                  ctrl.setIndex(7);
                } catch (_) {
                  await Get.offAllNamed('/Vendor');
                  try {
                    final ctrl2 = Get.find<VendorShellController>();
                    ctrl2.setIndex(7);
                  } catch (_) {}
                }
              },
              child: const Text('+ Add New Package', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

