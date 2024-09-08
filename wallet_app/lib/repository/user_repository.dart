import 'package:dio/dio.dart';
import 'package:wallet_app/repository/dto/general_response.dart';
import 'package:wallet_app/repository/dto/login_user_data.dart';
import 'package:wallet_app/repository/dto/transaction.dart';
import 'package:wallet_app/repository/dto/user_api_response.dart';
import 'dto/user.dart';

class UserRepository {
  static const BASE_URL = "http://10.0.2.2:3000/";
  static const TO_TEST_URL = "http://localhost:3000/";

  late final Dio _dio;
  bool _isStreamingBoard = false;

  UserRepository([bool test = false]) {
    if (test) {
      _dio = Dio(BaseOptions(baseUrl: TO_TEST_URL));
    } else {
      _dio = Dio(BaseOptions(baseUrl: BASE_URL));
    }
  }

  Future<UserApiResponse> login(LoginUserData loginUserData) async {
    try {
      final response = await _dio.post(
        '/login',
        data: loginUserData.toJson(),
      );

      if (response.statusCode == 200) {
        return UserApiResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  Future<UserApiResponse> addUser(User user) async {
    try {
      final response = await _dio.post(
        '/users',
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserApiResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to add the user');
      }
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  Future<UserApiResponse> addTransaction(Transaction transaction,
      int userId) async {
    try {
      final response = await _dio.post(
        '/users/$userId/transactions',
        data: transaction.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserApiResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to add the transaction');
      }
    } catch (e) {
      throw Exception('Error adding transaction: $e');
    }
  }
}