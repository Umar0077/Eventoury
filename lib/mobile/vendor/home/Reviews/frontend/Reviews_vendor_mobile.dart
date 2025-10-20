import 'package:eventoury/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../backend/reviews_vendor_controller.dart';

class ReviewsVendorMobile extends StatelessWidget {
	ReviewsVendorMobile({Key? key}) : super(key: key);

	final ReviewsVendorController controller = Get.put(ReviewsVendorController());

	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		final isDark = theme.brightness == Brightness.dark;

		return SafeArea(
			child: Obx(() {
				if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());

				return Scaffold(
					appBar: AppBar(
						leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).maybePop()),
						title: const Text('Reviews'),
						centerTitle: true,
						elevation: 0,
					),
					body: SingleChildScrollView(
						padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
						child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
							// Rating summary
							Card(
								color: isDark ? Colors.black : Colors.white,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
								elevation: 3,
								shadowColor: Colors.black26,
								child: Padding(
									padding: const EdgeInsets.all(14.0),
									child: Row(children: [
										// Left: average rating
										Expanded(
											child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
												Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
													Text(controller.average.value.toStringAsFixed(1), style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
													const SizedBox(width: 6),
													Text('/5', style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey)),
												]),
												const SizedBox(height: 8),
												Row(children: [
													...List.generate(5, (i) => Icon(Icons.star, size: 18, color: i < controller.average.value.round() ? EventouryColors.tangerine : Colors.grey.shade400)),
												]),
												const SizedBox(height: 8),
												Text('${controller.count.value} reviews', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
											]),
										),

										// Right: distribution bars
										SizedBox(
											width: 140,
											child: Column(children: [
												...[5, 4, 3, 2, 1].map((star) {
													final maxCount = controller.distribution.values.fold<int>(0, (a, b) => b > a ? b : a);
													final cur = controller.distribution[star] ?? 0;
													final fraction = maxCount == 0 ? 0.0 : cur / maxCount;
													return Padding(
														padding: const EdgeInsets.symmetric(vertical: 3.0),
														child: Row(children: [
															SizedBox(width: 20, child: Text('$star', style: theme.textTheme.bodySmall)),
															const SizedBox(width: 6),
															Expanded(
																child: Stack(children: [
																	Container(height: 10, decoration: BoxDecoration(color: isDark ? Colors.white12 : Colors.black12, borderRadius: BorderRadius.circular(6))),
																	FractionallySizedBox(widthFactor: fraction, child: Container(height: 10, decoration: BoxDecoration(color: EventouryColors.tangerine, borderRadius: BorderRadius.circular(6)))),
																]),
															),
															const SizedBox(width: 8),
															SizedBox(width: 28, child: Text(cur.toString(), style: theme.textTheme.bodySmall)),
														]),
													);
												}).toList(),
											]),
										),
									]),
								),
							),

							const SizedBox(height: 12),

							// Filters: Category and Sort
							Row(children: [
								Expanded(child: _DropdownCard(label: 'Category', value: controller.category.value, items: ['All', 'Package', 'Guide'], onChanged: (v) => controller.setCategory(v ?? 'All'))),
								const SizedBox(width: 12),
								SizedBox(width: 140, child: _DropdownCard(label: 'Sort', value: controller.sort.value, items: ['Newest', 'Oldest', 'Highest Rating'], onChanged: (v) => controller.setSort(v ?? 'Newest'))),
							]),

							const SizedBox(height: 12),

							// Reviews list
							ListView.separated(
								shrinkWrap: true,
								physics: const NeverScrollableScrollPhysics(),
								itemCount: controller.reviews.length,
								separatorBuilder: (_, __) => const SizedBox(height: 8),
								itemBuilder: (context, idx) {
									final r = controller.reviews[idx];
									return Card(
										color: isDark ? Colors.black : Colors.white,
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
										elevation: 3,
										shadowColor: Colors.black26,
										child: Padding(
											padding: const EdgeInsets.all(12.0),
											child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
												Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
													CircleAvatar(backgroundColor: EventouryColors.tangerine, child: Text((r['name'] as String).substring(0, 1).toUpperCase(), style: const TextStyle(color: Colors.white))),
													const SizedBox(width: 12),
													Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
														Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
															Expanded(child: Text(r['name'], style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold))),
															Row(children: List.generate(5, (i) => Icon(Icons.star, size: 16, color: i < (r['rating'] as int) ? EventouryColors.tangerine : Colors.grey.shade400))),
														]),
														const SizedBox(height: 4),
														Text(r['timeAgo'], style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
													])),
												]),
												const SizedBox(height: 10),
												Text(r['text'], style: theme.textTheme.bodyMedium),
												const SizedBox(height: 10),
												Align(
													alignment: Alignment.centerRight,
													child: OutlinedButton(
														onPressed: () => _openReply(context, r),
														style: OutlinedButton.styleFrom(
															side: BorderSide(color: EventouryColors.tangerine),
															shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
															foregroundColor: EventouryColors.tangerine,
														),
														child: const Text('Reply'),
													),
												)
											]),
										),
									);
								},
							),

							const SizedBox(height: 24),
						]),
					),
				);
			}),
		);
	}

	void _openReply(BuildContext context, Map<String, dynamic> r) {
		showModalBottomSheet(context: context, isScrollControlled: true, builder: (_) {
			final ctrl = TextEditingController();
			return Padding(
				padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 12),
				child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
					Text('Reply to ${r['name']}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
					const SizedBox(height: 8),
					TextField(controller: ctrl, maxLines: 4, decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Write a reply...')),
					const SizedBox(height: 12),
					Row(mainAxisAlignment: MainAxisAlignment.end, children: [
						TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
						const SizedBox(width: 8),
						ElevatedButton(onPressed: () { Navigator.of(context).pop(); }, child: const Text('Send'))
					])
				]),
			);
		});
	}
}

class _DropdownCard extends StatelessWidget {
	final String label;
	final String value;
	final List<String> items;
	final ValueChanged<String?> onChanged;

	const _DropdownCard({required this.label, required this.value, required this.items, required this.onChanged});

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
			decoration: BoxDecoration(
				color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
				borderRadius: BorderRadius.circular(10),
				boxShadow: [
					BoxShadow(color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.black12, offset: const Offset(0, 2), blurRadius: 6),
				],
			),
			child: Row(children: [
				Text(label + ': ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
				const SizedBox(width: 6),
				Expanded(
					child: DropdownButtonHideUnderline(
						child: DropdownButton<String>(
							value: value,
							isExpanded: true,
							items: items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
							onChanged: onChanged,
						),
					),
				)
			]),
		);
	}
}

