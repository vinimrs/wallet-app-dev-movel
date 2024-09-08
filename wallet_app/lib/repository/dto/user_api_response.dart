
import 'package:wallet_app/repository/dto/user.dart';

class UserApiResponse {
  final String? message;
  final bool? success;
  final User? data;

  UserApiResponse({this.message, this.success, this.data});

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(
      message: json['message'],
      success: json['success'],
      data: json['data'] != null ? User.fromJson(json['data']) : null,
    );
  }


}