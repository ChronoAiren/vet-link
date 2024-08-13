import 'package:flutter/foundation.dart';
import 'package:frontend/common/constants/nav_items.dart';
import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  final List<Map<String, dynamic>> _navItems = [...navigationItems];

  final RxString activeRoute = '/home'.obs;
  final RxBool isMobileDrawerOpened = false.obs;

  List<Map<String, dynamic>> getNavItems() => _navItems;

  bool isActive(String route) => activeRoute.value == route;

  bool isDrawerOpen() => isMobileDrawerOpened.value;

  void setActiveRoute(String route) => activeRoute.value = route;

  void goTo(String route) {
    if (kIsWeb) {
      Get.toNamed(route);
    } else {
      Get.back();
      Get.toNamed(route);
    }
    activeRoute.value = route;
  }

  void openMobileDrawer() {
    if (!kIsWeb && !isMobileDrawerOpened.value) {
      isMobileDrawerOpened.value == true;
    }
  }

  void closeMobileDrawer() {
    if (!kIsWeb && isMobileDrawerOpened.value) {
      isMobileDrawerOpened.value == false;
    }
  }
}
