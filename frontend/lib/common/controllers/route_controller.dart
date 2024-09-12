import 'package:frontend/common/controllers/drawer_controller.dart';
import 'package:get/get.dart';

class RouteController extends GetxController {
  final drawerController = Get.find<CustomDrawerController>();

  @override
  onInit() {
    super.onInit();
    final String initialRoute = Get.currentRoute;
    drawerController.setActiveRoute(
      initialRoute.isNotEmpty ? initialRoute : '/home',
    );
  }
}
