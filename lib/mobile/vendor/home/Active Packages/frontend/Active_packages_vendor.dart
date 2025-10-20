import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend/packages_vendor_controller.dart';
import '../Add new Package/frontend/Add_newpackage.dart';

class ActivePackagesVendor extends StatelessWidget {
	ActivePackagesVendor({Key? key}) : super(key: key);

	final PackagesVendorController controller = Get.put(PackagesVendorController());

	@override
	Widget build(BuildContext context) {
    

		return SafeArea(
			child: Obx(() {
				if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());

				return Scaffold(
					appBar: AppBar(
						leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).maybePop()),
						title: const Text('Packages'),
						centerTitle: true,
						elevation: 0,
						actions: [
							IconButton(
								icon: const Icon(Icons.search),
								onPressed: () => _openSearchOverlay(context),
							),
						],
					),
								body: Padding(
									padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
									child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
										// Filters and Add button placed inline (responsive)
														LayoutBuilder(builder: (context, constraints) {
															final aw = constraints.maxWidth;
															final isNarrow = aw < 420;

															if (isNarrow) {
																// Stack vertically on small screens to avoid overflow
																return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
																	_FilterDropdown(label: 'Category', value: controller.category.value, items: ['All', 'Adventure', 'City', 'Relax'], onChanged: (v) => controller.setCategory(v ?? 'All')),
																	const SizedBox(height: 8),
																	_FilterDropdown(label: 'Status', value: controller.status.value, items: ['All', 'Active', 'Inactive'], onChanged: (v) => controller.setStatus(v ?? 'All')),
												const SizedBox(height: 8),
												SizedBox(width: double.infinity, child: _EventouryElevatedButton(onPressed: () => _openAdd(context), child: const Text('+ Add New Package'))),
																]);
															}

															// Wide layout: compute widths to avoid overflow
															final addWidth = 160.0;
															final statusWidth = 160.0;
															final spacing = 12.0;
															final categoryWidth = (aw - addWidth - statusWidth - spacing * 2).clamp(120.0, aw - statusWidth - addWidth - spacing * 2);

															return Row(children: [
																SizedBox(width: categoryWidth, child: _FilterDropdown(label: 'Category', value: controller.category.value, items: ['All', 'Adventure', 'City', 'Relax'], onChanged: (v) => controller.setCategory(v ?? 'All'))),
																SizedBox(width: spacing),
																SizedBox(width: statusWidth, child: _FilterDropdown(label: 'Status', value: controller.status.value, items: ['All', 'Active', 'Inactive'], onChanged: (v) => controller.setStatus(v ?? 'All'))),
																SizedBox(width: spacing),
											SizedBox(width: addWidth, child: _EventouryElevatedButton(onPressed: () => _openAdd(context), child: const Text('+ Add New Package'))),
															]);
														}),

										const SizedBox(height: 12),

										Expanded(
											child: ListView.separated(
												itemCount: controller.packages.length,
												separatorBuilder: (_, __) => const SizedBox(height: 12),
												itemBuilder: (context, idx) {
													final p = controller.packages[idx];
													return _PackageCard(
														package: p,
														onEdit: () => _openEdit(context, p),
														onDelete: () => _confirmDelete(context, p['id']),
														onView: () => _openView(context, p),
													);
												},
											),
										),
									]),
								),
				);
			}),
		);
	}

	void _openSearchOverlay(BuildContext context) {
		showDialog(context: context, builder: (_) {
			final ctrl = TextEditingController();
			return Dialog(
				insetPadding: const EdgeInsets.all(0),
				child: Container(
					padding: const EdgeInsets.all(12),
					color: Theme.of(context).scaffoldBackgroundColor,
					child: Column(mainAxisSize: MainAxisSize.min, children: [
						Row(children: [
							Expanded(child: TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'Search packages...', border: OutlineInputBorder()))),
							const SizedBox(width: 8),
							ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))
						]),
						const SizedBox(height: 12),
						// In real app, implement instant search results here
						const Text('Search results would appear here'),
						const SizedBox(height: 12),
						ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Done'))
					]),
				),
			);
		});
	}

	void _openAdd(BuildContext context) {
	  Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddNewPackagePage()));
	}

	void _openEdit(BuildContext context, Map<String, dynamic> p) {
		showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
			return Padding(
				padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 12),
				child: Column(mainAxisSize: MainAxisSize.min, children: [
					Text('Edit ${p['title']}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
					const SizedBox(height: 12),
					TextField(decoration: InputDecoration(labelText: 'Title', hintText: p['title'])),
					const SizedBox(height: 8),
					TextField(decoration: InputDecoration(labelText: 'Price', hintText: p['price'].toString())),
					const SizedBox(height: 12),
					ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Save'))
				]),
			);
		});
	}

	void _openView(BuildContext context, Map<String, dynamic> p) {
		showModalBottomSheet(context: context, builder: (_) {
			return Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
					Text(p['title'], style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
					const SizedBox(height: 8),
					Text('\$${p['price']}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
					const SizedBox(height: 6),
					Text(p['location'], style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
					const SizedBox(height: 12),
					Text(p['description']),
					const SizedBox(height: 12),
					ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))
				]),
			);
		});
	}

	void _confirmDelete(BuildContext context, String id) {
		showDialog(context: context, builder: (_) {
			return AlertDialog(
				title: const Text('Delete Package'),
				content: const Text('Are you sure you want to delete this package?'),
				actions: [
					TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
					TextButton(onPressed: () { Get.find<PackagesVendorController>().deletePackage(id); Navigator.of(context).pop(); }, child: const Text('Delete'))
				],
			);
		});
	}
}

class _FilterDropdown extends StatelessWidget {
	final String label;
	final String value;
	final List<String> items;
	final ValueChanged<String?> onChanged;

	const _FilterDropdown({required this.label, required this.value, required this.items, required this.onChanged});

	@override
	Widget build(BuildContext context) {
				final theme = Theme.of(context);
				final isDark = theme.brightness == Brightness.dark;
				return Container(
					padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
					decoration: BoxDecoration(
						color: isDark ? Colors.black : Colors.white,
						borderRadius: BorderRadius.circular(10),
						boxShadow: [BoxShadow(color: isDark ? Colors.black54 : Colors.black12, offset: const Offset(0, 2), blurRadius: 6)],
					),
					child: Row(children: [
						Text(label + ': ', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
						const SizedBox(width: 6),
						Expanded(
							child: DropdownButtonHideUnderline(
								child: DropdownButton<String>(
									isDense: true,
									value: value,
									items: items.map((s) => DropdownMenuItem(value: s, child: Text(s, overflow: TextOverflow.ellipsis))).toList(),
									onChanged: onChanged,
								),
							),
						)
					]),
				);
	}
}
	/// A small local wrapper to ensure consistent Eventoury elevated button styling
	class _EventouryElevatedButton extends StatelessWidget {
		final VoidCallback onPressed;
		final Widget child;
			const _EventouryElevatedButton({required this.onPressed, required this.child});

		@override
		Widget build(BuildContext context) {
			return ElevatedButton(
				onPressed: onPressed,
				style: ElevatedButton.styleFrom(
					backgroundColor: EventouryColors.tangerine,
					foregroundColor: Colors.white,
				padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
					elevation: 2,
				),
				child: child,
			);
		}
	}

	class _PackageCard extends StatelessWidget {
		final Map<String, dynamic> package;
		final VoidCallback onEdit;
		final VoidCallback onDelete;
		final VoidCallback onView;

		const _PackageCard({required this.package, required this.onEdit, required this.onDelete, required this.onView});

		@override
		Widget build(BuildContext context) {
			final theme = Theme.of(context);
			final isActive = package['status'] == 'Active';
			return Card(
				color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
				elevation: 3,
				shadowColor: Colors.black26,
				child: Padding(
					padding: const EdgeInsets.all(14.0),
					child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
						Row(children: [
							Expanded(child: Text(package['title'], style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
							Container(
								padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
								decoration: BoxDecoration(color: isActive ? Colors.green.shade600 : Colors.grey.shade600, borderRadius: BorderRadius.circular(8)),
								child: Text(package['status'], style: theme.textTheme.bodySmall?.copyWith(color: Colors.white)),
							)
						]),
						const SizedBox(height: 8),
						Text(package['subtitle'], style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
						const SizedBox(height: 8),
						Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
							Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
								Text('\$${package['price']}', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
								const SizedBox(height: 4),
								Text(package['location'], style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
							]),
						]),
						const SizedBox(height: 8),
						Text(package['description'], style: theme.textTheme.bodyMedium),
						const SizedBox(height: 12),
						LayoutBuilder(builder: (context, constraints) {
							final narrow = constraints.maxWidth < 360;
							if (narrow) {
								return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
									TextButton(onPressed: onEdit, child: const Text('Edit')),
									TextButton(onPressed: onDelete, child: const Text('Delete')),
									_EventouryElevatedButton(onPressed: onView, child: const Text('View')),
								]);
							}
							return Row(children: [
								TextButton(onPressed: onEdit, child: const Text('Edit')),
								const SizedBox(width: 8),
								TextButton(onPressed: onDelete, child: const Text('Delete')),
								const SizedBox(width: 8),
								_EventouryElevatedButton(onPressed: onView, child: const Text('View')),
							]);
						})
					]),
				),
			);
		}
	}

