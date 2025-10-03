import 'package:eventoury/web/Vendor/vendor_layout.dart';
import 'package:eventoury/web/Vendor/vendor_shell_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventoury/utils/constants/colors.dart';

class AddNewPackageScreen extends StatefulWidget {
  const AddNewPackageScreen({super.key});

  @override
  State<AddNewPackageScreen> createState() => _AddNewPackageScreenState();
}

class _AddNewPackageScreenState extends State<AddNewPackageScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _shortDescCtrl = TextEditingController();
  final TextEditingController _fullDescCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _durationCtrl = TextEditingController();

  bool _isActive = true;
  final List<String> _gallery = [];

  final List<String> _possibleIncluded = ['Meals', 'Transport', 'Guide', 'Accommodation'];
  final List<String> _possibleExcluded = ['Flights', 'Visa', 'Personal Expenses'];

  final Set<String> _included = {};
  final Set<String> _excluded = {};

  void _pickGallery() async {
    // Placeholder: show dialog to add image url or file name. Real upload can be wired later.
    final TextEditingController url = TextEditingController();
    await showDialog<void>(context: context, builder: (ctx) {
      return AlertDialog(
        title: const Text('Add gallery item (placeholder)'),
        content: TextField(controller: url, decoration: const InputDecoration(hintText: 'Image URL or name')),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(onPressed: () {
            if (url.text.trim().isNotEmpty) {
              setState(() => _gallery.add(url.text.trim()));
            }
            Navigator.of(ctx).pop();
          }, child: const Text('Add')),
        ],
      );
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        'name': _nameCtrl.text.trim(),
        'short': _shortDescCtrl.text.trim(),
        'full': _fullDescCtrl.text.trim(),
        'location': _locationCtrl.text.trim(),
        'price': _priceCtrl.text.trim(),
        'duration': _durationCtrl.text.trim(),
        'included': _included.toList(),
        'excluded': _excluded.toList(),
        'active': _isActive,
        'gallery': _gallery,
      };
      // For now just print and show a snackbar. Hook into your backend here.
      debugPrint('New package: $data');
      Get.snackbar('Saved', 'Package saved (mock)', snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use VendorLayout so this screen can be hosted inside VendorShell (keeps
    // the sidebar persistent) and still be usable standalone during dev.
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return VendorLayout(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                IconButton(onPressed: () async {
                  try {
                    final ctrl = Get.find<VendorShellController>();
                    // go back to packages list (index 6)
                    ctrl.setIndex(6);
                  } catch (_) {
                    await Get.offAllNamed('/Vendor');
                    try {
                      final ctrl2 = Get.find<VendorShellController>();
                      ctrl2.setIndex(6);
                    } catch (_) {}
                  }
                }, icon: const Icon(Icons.arrow_back)),
                Text('Add New Package', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
              ]),
              const SizedBox(height: 18),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Package Name
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(labelText: 'Package Name', border: OutlineInputBorder()),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter package name' : null,
                    ),
                    const SizedBox(height: 12),

                    // Short Description
                    TextFormField(
                      controller: _shortDescCtrl,
                      decoration: const InputDecoration(labelText: 'Short Description', border: OutlineInputBorder()),
                      maxLines: 2,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter short description' : null,
                    ),
                    const SizedBox(height: 12),

                    // Full Description / About Destination
                    TextFormField(
                      controller: _fullDescCtrl,
                      decoration: const InputDecoration(labelText: 'Full Description / About Destination', border: OutlineInputBorder()),
                      maxLines: 6,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter full description' : null,
                    ),
                    const SizedBox(height: 12),

                    // Row: Location | Price | Duration
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _locationCtrl,
                            decoration: const InputDecoration(labelText: 'Location', border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 140,
                          child: TextFormField(
                            controller: _priceCtrl,
                            decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 140,
                          child: TextFormField(
                            controller: _durationCtrl,
                            decoration: const InputDecoration(labelText: 'Duration', hintText: '3 days', border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Gallery upload placeholder
                    Text('Gallery', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                                children: [
                                  ..._gallery.map((g) => Chip(
                                        label: Text(g, style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white70 : theme.textTheme.bodyMedium?.color)),
                                        onDeleted: () => setState(() => _gallery.remove(g)),
                                        backgroundColor: isDark ? theme.cardColor : Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: isDark ? Colors.grey.shade800 : theme.dividerColor.withOpacity(0.06))),
                                      )),
                                  ActionChip(
                                    onPressed: _pickGallery,
                                    label: const Text('Add Image'),
                                    labelStyle: TextStyle(color: EventouryColors.tangerine),
                                    backgroundColor: isDark ? theme.cardColor : Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: EventouryColors.tangerine)),
                                  ),
                                ],
                            ),
                    const SizedBox(height: 16),

                    // Included items
                    Text('Included Items', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: _possibleIncluded.map((item) {
                                final selected = _included.contains(item);
                                return FilterChip(
                                  selected: selected,
                                  label: Text(item, style: TextStyle(color: selected ? Colors.white : EventouryColors.tangerine)),
                                  onSelected: (v) => setState(() => v ? _included.add(item) : _included.remove(item)),
                                  selectedColor: EventouryColors.tangerine,
                                  checkmarkColor: Colors.white,
                                  backgroundColor: isDark ? theme.cardColor : Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: isDark ? Colors.grey.shade800 : EventouryColors.tangerine)),
                                );
                              }).toList(),
                            ),
                    const SizedBox(height: 12),

                    // Excluded items
                    Text('Excluded Items', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: _possibleExcluded.map((item) {
                                final selected = _excluded.contains(item);
                                return FilterChip(
                                  selected: selected,
                                  label: Text(item, style: TextStyle(color: selected ? Colors.white : EventouryColors.tangerine)),
                                  onSelected: (v) => setState(() => v ? _excluded.add(item) : _excluded.remove(item)),
                                  selectedColor: EventouryColors.tangerine,
                                  checkmarkColor: Colors.white,
                                  backgroundColor: isDark ? theme.cardColor : Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: isDark ? Colors.grey.shade800 : EventouryColors.tangerine)),
                                );
                              }).toList(),
                            ),
                    const SizedBox(height: 12),

                            // Status toggle
                            Row(
                              children: [
                                const Text('Status', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(width: 12),
                                Switch(
                                  value: _isActive,
                                  onChanged: (v) => setState(() => _isActive = v),
                                  activeThumbColor: EventouryColors.tangerine,
                                  activeTrackColor: EventouryColors.tangerine.withOpacity(0.35),
                                ),
                                const SizedBox(width: 12),
                                Text(_isActive ? 'Active' : 'Inactive'),
                              ],
                            ),
                    const SizedBox(height: 18),

                    // Actions: single right-aligned Save button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: EventouryColors.tangerine,
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
