import 'package:frontend/common/controllers/session_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SessionController>(SessionController(), permanent: true);
  }
}
