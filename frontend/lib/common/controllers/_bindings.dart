import 'package:frontend/common/controllers/drawer_controller.dart';
import 'package:frontend/common/controllers/session_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CustomDrawerController>(CustomDrawerController(), permanent: true);
    Get.put<SessionController>(SessionController(), permanent: true);
  }
}
