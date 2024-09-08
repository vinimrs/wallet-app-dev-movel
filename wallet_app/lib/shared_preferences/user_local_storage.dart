import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app/repository/dto/planning.dart';
import 'package:wallet_app/repository/dto/user.dart';
import 'package:wallet_app/repository/dto/user_api_response.dart';
import 'package:wallet_app/repository/user_repository.dart';

class UserLocalStorage {
  UserRepository userRepository = UserRepository();
  User user = User(
    id: 0,
    name: "",
    email: "",
    password: "",
    planning: Planning(),
  );

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userIdString = prefs.getString("user_id");
    if (userIdString != null) {
      UserApiResponse data = await userRepository.getUserById(int.parse(userIdString!));
      user = data.data!;
    }
    return user;
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_id", user.id.toString());
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_id");
  }
}
