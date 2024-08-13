import 'package:dio/dio.dart';
import 'package:frontend/utils/dio/dio_client.dart';

class AuthRepository {
  final DioClient dioClient = DioClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dioClient.post(
        'auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>> registerPetOwner(
      String email, String password) async {
    try {
      final response = await dioClient.post(
        'auth/register/pet-owner',
        data: {
          "email": email,
          "password": password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  Future<Map<String, dynamic>> registerClinicOwner(
      String email, String password) async {
    try {
      final response = await dioClient.post(
        'auth/register/clinic-owner',
        data: {
          "email": email,
          "password": password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }
}
