import 'package:flutter/material.dart';
import '../../../utils/theme/elevated_button_theme.dart';

class AddNewPackageAdmin extends StatefulWidget {
  const AddNewPackageAdmin({super.key});

  @override
  State<AddNewPackageAdmin> createState() => _AddNewPackageAdminState();
}

class _AddNewPackageAdminState extends State<AddNewPackageAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _aboutCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _aboutCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fieldBg = isDark ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Explore Category'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _buildField(_nameCtrl, hint: 'Enter destination name', bg: fieldBg),
              const SizedBox(height: 16),

              Text('Select Location', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              EventouryElevatedButton(onPressed: _chooseLocation, child: const Text('Choose Location')),
              const SizedBox(height: 16),

              Text('Upload Image', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _imagePlaceholder(fieldBg),
              const SizedBox(height: 16),

              Text('About Destination', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _buildMultilineField(_aboutCtrl, hint: 'Write about the destination, attractions, and highlights.', bg: fieldBg),
              const SizedBox(height: 16),

              Text('Price', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _buildField(_priceCtrl, hint: 'Enter price', bg: fieldBg, keyboardType: TextInputType.number, suffix: const Text('USD')),
              const SizedBox(height: 24),

              Row(children: [Expanded(child: EventouryElevatedButton(onPressed: _submit, child: const Text('Add Category')))]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, {required String hint, required Color bg, TextInputType? keyboardType, Widget? suffix}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0,3))],
      ),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        decoration: InputDecoration(hintText: hint, border: InputBorder.none, suffix: suffix),
        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
      ),
    );
  }

  Widget _buildMultilineField(TextEditingController ctrl, {required String hint, required Color bg}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0,3))],
      ),
      child: TextFormField(
        controller: ctrl,
        maxLines: 6,
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
      ),
    );
  }

  Widget _imagePlaceholder(Color bg) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_upload_outlined, size: 36, color: Colors.grey),
            const SizedBox(height: 8),
            EventouryElevatedButton(onPressed: _uploadImage, child: const Text('Upload')),
          ],
        ),
      ),
    );
  }

  void _chooseLocation() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open location picker (not implemented)')));
  }

  void _uploadImage() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open image picker (not implemented)')));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('New category added successfully.'),
      actions: [
        EventouryElevatedButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('View Categories')),
        EventouryElevatedButton(onPressed: () { Navigator.pop(context); _nameCtrl.clear(); _aboutCtrl.clear(); _priceCtrl.clear(); }, child: const Text('Add Another')),
      ],
    ));
  }
}
