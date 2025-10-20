import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend/add_package_controller.dart';

class AddNewPackagePage extends StatelessWidget {
  AddNewPackagePage({Key? key}) : super(key: key);

  final AddPackageController controller = Get.put(AddPackageController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).maybePop()),
          title: const Text('Add New Package'),
          centerTitle: true,
          // no actions here; Save moved to bottom of form so it's always reachable
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Package Name
              _SectionHeader(title: 'Package Name'),
              const SizedBox(height: 8),
              _SurfaceTextField(
                hint: 'Package Name',
                onChanged: (v) => controller.title.value = v,
              ),

              const SizedBox(height: 12),
              _SectionHeader(title: 'Short Description'),
              const SizedBox(height: 8),
              _SurfaceTextField(hint: 'Short Description', onChanged: (v) => controller.shortDesc.value = v),

              const SizedBox(height: 12),
              _SectionHeader(title: 'Full Description / About Destination'),
              const SizedBox(height: 8),
              _SurfaceTextField(hint: 'Full Description / About Destination', maxLines: 5, onChanged: (v) => controller.fullDesc.value = v),

              const SizedBox(height: 12),
              // Location, Price, Duration
              LayoutBuilder(builder: (context, constraints) {
                final wide = constraints.maxWidth > 420;
                if (wide) {
                  return Row(children: [
                    Expanded(child: _SurfaceTextField(hint: 'Location', onChanged: (v) => controller.location.value = v)),
                    const SizedBox(width: 8),
                    SizedBox(width: 120, child: _SurfaceTextField(hint: 'Price', onChanged: (v) => controller.price.value = v)),
                    const SizedBox(width: 8),
                    SizedBox(width: 120, child: _SurfaceTextField(hint: 'Duration', onChanged: (v) => controller.duration.value = v)),
                  ]);
                }
                return Column(children: [
                  _SurfaceTextField(hint: 'Location', onChanged: (v) => controller.location.value = v),
                  const SizedBox(height: 8),
                  _SurfaceTextField(hint: 'Price', onChanged: (v) => controller.price.value = v),
                  const SizedBox(height: 8),
                  _SurfaceTextField(hint: 'Duration', onChanged: (v) => controller.duration.value = v),
                ]);
              }),

              const SizedBox(height: 16),
              _SectionHeader(title: 'Gallery'),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Mock: add a placeholder image url
                      controller.addImage('local_image_${DateTime.now().millisecondsSinceEpoch}');
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: EventouryColors.tangerine),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Add Image', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ]),
              const SizedBox(height: 8),
              Obx(() => Wrap(spacing: 8, runSpacing: 8, children: controller.images.map((i) => ClipRRect(borderRadius: BorderRadius.circular(8), child: Container(width: 72, height: 72, color: Colors.grey.shade300, child: Center(child: Text('Img', style: TextStyle(color: isDark ? Colors.white : Colors.black)))))).toList())),

              const SizedBox(height: 16),
              _SectionHeader(title: 'Included Items'),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, idx) {
                    final it = controller.defaultIncluded[idx];
                    return Obx(() {
                      final selected = controller.included.contains(it);
                      final bg = selected ? EventouryColors.tangerine : (isDark ? Colors.grey.shade800 : Colors.grey.shade300);
                      final textColor = selected ? Colors.white : (isDark ? Colors.white : Colors.black87);
                      return GestureDetector(
                        onTap: () => controller.toggleIncluded(it),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(20),
                            border: selected ? Border.all(color: EventouryColors.tangerine, width: 2) : null,
                          ),
                          child: Text(it, style: TextStyle(color: textColor)),
                        ),
                      );
                    });
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: controller.defaultIncluded.length,
                ),
              ),

              const SizedBox(height: 16),
              _SectionHeader(title: 'Excluded Items'),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, idx) {
                    final it = controller.defaultExcluded[idx];
                    return Obx(() {
                      final selected = controller.excluded.contains(it);
                      final bg = selected ? EventouryColors.tangerine : (isDark ? Colors.grey.shade800 : Colors.grey.shade300);
                      final textColor = selected ? Colors.white : (isDark ? Colors.white : Colors.black87);
                      return GestureDetector(
                        onTap: () => controller.toggleExcluded(it),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(20),
                            border: selected ? Border.all(color: EventouryColors.tangerine, width: 2) : null,
                          ),
                          child: Text(it, style: TextStyle(color: textColor)),
                        ),
                      );
                    });
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: controller.defaultExcluded.length,
                ),
              ),

              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _SectionHeader(title: 'Status'),
                Row(children: [
                  const Text('Active'),
                  const SizedBox(width: 8),
                  Obx(() => Switch(value: controller.isActive.value, activeColor: EventouryColors.tangerine, onChanged: (v) => controller.isActive.value = v)),
                ])
              ]),

              const SizedBox(height: 24),
              // Save button placed at end so it's visible above bottom nav
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  onPressed: () async {
                    final ok = await controller.savePackage();
                    if (ok) Navigator.of(context).pop();
                    else Get.snackbar('Validation', 'Please enter a title', backgroundColor: Colors.redAccent.withOpacity(0.9), colorText: Colors.white);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: EventouryColors.tangerine, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), elevation: 4, shadowColor: Colors.black26),
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                )
              ]),

              // Add a bottom spacer the same color as scaffold to allow scrolling past bottom nav
              SizedBox(height: 120, child: Container(color: Theme.of(context).scaffoldBackgroundColor)),
            ]),
          ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold));
  }
}

class _SurfaceTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  const _SurfaceTextField({required this.hint, this.maxLines = 1, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade400;
    return Container(
      decoration: BoxDecoration(color: isDark ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: isDark ? Colors.black54 : Colors.black12, offset: const Offset(0, 2), blurRadius: 6)]),
      child: TextField(
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: isDark ? Colors.grey.shade500 : Colors.grey.shade600),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: EventouryColors.tangerine)),
          filled: false,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}
