import 'package:frontend/common/controllers/drawer_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CustomDrawerController>(CustomDrawerController());
  }
}
