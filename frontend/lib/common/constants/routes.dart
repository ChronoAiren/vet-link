import 'package:frontend/features/auth/presentation/login/login_screen.dart';
import 'package:frontend/features/auth/presentation/register/clinic_owner/register_co_screen.dart';
import 'package:frontend/features/auth/presentation/register/pet_owner/register_screen.dart';
import 'package:frontend/features/general/presentation/home/home_screen.dart';
import 'package:frontend/features/pet/presentation/add_pet/add_pet_screen.dart';
import 'package:frontend/features/pet/presentation/view_pet/view_pet_screen.dart';
import 'package:frontend/features/user/presentation/add_staff/add_staff_screen.dart';
import 'package:frontend/features/user/presentation/verify_clinic_owner/verify_clinic_owner_screen.dart';
import 'package:frontend/features/user/presentation/view_staffs/view_staffs_screen.dart';
import 'package:frontend/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = '/';

  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/register', page: () => RegisterPetOwnerScreen()),
    GetPage(name: '/register_co', page: () => RegisterClinicOwnerScreen()),
    GetPage(
        name: '/verify_clinic_owner', page: () => VerifyClinicOwnerScreen()),
    GetPage(name: '/view_staffs', page: () => ViewStaffsScreen()),
    GetPage(name: '/add_staff', page: () => AddStaffScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/view_pets', page: () => ViewPetScreen()),
    GetPage(name: '/add_pet', page: () => const AddPetScreen()),
  ];
}
