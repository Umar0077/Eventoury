import 'package:eventoury/utils/constants/colors.dart';
import 'package:eventoury/utils/theme/elevated_button_theme.dart';
import 'package:eventoury/web/top and Bottom bar/top bar web/topbarwidget.dart';
import 'package:eventoury/web/top and Bottom bar/bottom bar web/bottombarwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactWebPage extends StatefulWidget {
  const ContactWebPage({super.key});

  @override
  State<ContactWebPage> createState() => _ContactWebPageState();
}

class _ContactWebPageState extends State<ContactWebPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _messageCtrl = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 600)); // simulate network
    setState(() => _isSubmitting = false);
  Get.snackbar('Message sent', 'Thank you — we will contact you shortly.', snackPosition: SnackPosition.BOTTOM, backgroundColor: EventouryColors.tangerine.withOpacity(0.95), colorText: Colors.white);
    _formKey.currentState?.reset();
    _nameCtrl.clear();
    _emailCtrl.clear();
    _phoneCtrl.clear();
    _messageCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 992;
    final horizontalPadding = isDesktop ? 80.0 : 24.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const TopBarWidget(activeItem: 'Contact'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Us', style: theme.textTheme.headlineSmall?.copyWith(fontSize: isDesktop ? 42 : 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('We would love to hear from you. Fill the form or reach us through the contact details below.', style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 28),

                  // Main content: form + info/map
                  isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Form
                            Expanded(flex: 2, child: _buildContactForm(theme)),
                            const SizedBox(width: 40),
                            // Info + map
                            Expanded(flex: 1, child: _buildContactInfo(theme)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildContactForm(theme),
                            const SizedBox(height: 24),
                            _buildContactInfo(theme),
                          ],
                        ),

                  const SizedBox(height: 40),
                  const BottomBarWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    // Section background and shadow tuned per theme to avoid pinkish/incorrect tint
    final sectionBg = isDark ? Colors.grey[900] : Colors.white;
    final sectionElevation = isDark ? 2.0 : 6.0;
    final sectionShadowColor = isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.08);
    final fieldBg = isDark ? Colors.white10 : Colors.grey[50];

    return Card(
      color: sectionBg,
      elevation: sectionElevation,
      shadowColor: sectionShadowColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Send us a message', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(labelText: 'Your name', filled: true, fillColor: fieldBg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(labelText: 'Email address', filled: true, fillColor: fieldBg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please enter an email';
                  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");
                  if (!emailRegex.hasMatch(v.trim())) return 'Please enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneCtrl,
                decoration: InputDecoration(labelText: 'Phone (optional)', filled: true, fillColor: fieldBg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _messageCtrl,
                maxLines: 6,
                decoration: InputDecoration(labelText: 'Message', alignLabelWithHint: true, filled: true, fillColor: fieldBg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a message' : null,
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: EventouryElevatedButton(onPressed: _isSubmitting ? null : _submit, isLoading: _isSubmitting, child: const Text('Send Message')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(ThemeData theme) {
    final textColor = theme.textTheme.bodyLarge?.color;
    final isDark = theme.brightness == Brightness.dark;
    final sectionBg = isDark ? Colors.grey[900] : Colors.white;
    final sectionElevation = isDark ? 2.0 : 6.0;
    final sectionShadowColor = isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.08);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: sectionBg,
          elevation: sectionElevation,
          shadowColor: sectionShadowColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Details', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Row(children: [Icon(Icons.location_on, color: EventouryColors.persimmon), const SizedBox(width: 8), Expanded(child: Text('Jalan Raya Seminyak, Bali, Indonesia', style: TextStyle(color: textColor)))]),
                const SizedBox(height: 8),
                Row(children: [Icon(Icons.email, color: EventouryColors.tangerine), const SizedBox(width: 8), Expanded(child: Text('info@eventoury.com', style: TextStyle(color: textColor)))]),
                const SizedBox(height: 8),
                Row(children: [Icon(Icons.phone, color: EventouryColors.persimmon), const SizedBox(width: 8), Expanded(child: Text('+62 812 3456 7890', style: TextStyle(color: textColor)))]),
                const SizedBox(height: 12),
                Divider(),
                const SizedBox(height: 8),
                Text('Opening hours', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text('Mon – Fri: 09:00 — 18:00', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text('Sat: 09:00 — 14:00 • Sun: Closed', style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Map placeholder
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset('assets/home_screen/BBali.jpg', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 12),
        Text('Prefer chat?', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(children: [
          EventouryElevatedButton(onPressed: () {}, child: const Text('Chat on WhatsApp')),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: EventouryColors.tangerine, width: 1.5),
              foregroundColor: EventouryColors.tangerine,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('Contact Agent'),
          ),
        ])
      ],
    );
  }
}
