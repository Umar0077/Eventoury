import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// Global navigator keys used by nested Navigators. Prefer Get's nested keys
// when available so Get's nested navigation and our explicit Navigators
// reference the same underlying key instance. Otherwise, fall back to a
// uniquely-labeled GlobalKey to avoid default key generation.
final GlobalKey<NavigatorState> homeNestedKey = Get.nestedKey(1) ?? GlobalKey<NavigatorState>(debugLabel: 'homeNested');
final GlobalKey<NavigatorState> vendorNestedKey = Get.nestedKey(2) ?? GlobalKey<NavigatorState>(debugLabel: 'vendorNested');
