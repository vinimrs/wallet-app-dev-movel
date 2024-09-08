
class LoginUserData {
  final String email;
  final String password;

  LoginUserData({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}