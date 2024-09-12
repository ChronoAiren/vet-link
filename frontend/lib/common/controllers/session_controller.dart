import 'package:frontend/features/auth/domain/clinic/clinic_model.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';
import 'package:get/get.dart';

class SessionController extends GetxController {
  User? currentUser;
  Clinic? currentClinic;

  void setCurrentUser(User user) => currentUser = user;

  void setCurrentClinic(Clinic clinic) => currentClinic = clinic;

  void clearSession() {
    currentUser = null;
    currentClinic = null;
  }

  void resetCurrentUser() => currentUser == null;
}
