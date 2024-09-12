
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:wallet_app/repository/dto/login_user_data.dart';
import 'package:wallet_app/repository/dto/planning.dart';
import 'package:wallet_app/repository/dto/transaction.dart';
import 'package:wallet_app/repository/dto/user.dart';
import 'package:wallet_app/repository/user_repository.dart';
import 'package:wallet_app/shared_preferences/user_local_storage.dart';

class MainViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();
  final UserLocalStorage userLocalStorage = UserLocalStorage();

  User _userData = User(
   planning: Planning()
  );
  bool _showNetworkErrorSnackBar = false;

  String _errorMessage = "";

  get userData => _userData;
  get showNetworkErrorSnackBar => _showNetworkErrorSnackBar;
  get errorMessage => _errorMessage;

  void setUserData(User user) {
    _userData = user;
    notifyListeners();
  }

  Future<bool?> login(String email, String password) async {
    try {
      final user = await userRepository.login(LoginUserData(email: email, password: password));
      _userData = user.data!;
      userLocalStorage.saveUser(_userData);
      _showNetworkErrorSnackBar = false;
      notifyListeners();

      return true;
    } catch (e) {
      _showNetworkErrorSnackBar = true;
      _errorMessage = e.toString();
      notifyListeners();

      return false;
    }
  }

  Future<bool?> addUser(String email, String password, String name) async {
    try {
      final user = await userRepository.addUser(User(
          email: email,
          password: password,
          name: name,
          planning: Planning()
      ));
      _userData = user.data!;
      userLocalStorage.saveUser(_userData);
      _showNetworkErrorSnackBar = false;
      notifyListeners();
      return true;
    } catch (e) {
      _showNetworkErrorSnackBar = true;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      _userData = User(
          planning: Planning()
      );
      userLocalStorage.deleteUser();
      _showNetworkErrorSnackBar = false;
    } catch (e) {
      _showNetworkErrorSnackBar = true;
    }
    notifyListeners();
  }


  Future<bool?> addTransaction(String transactionType, double amount, String selectedCategory, String description, bool income, int userId) async {
    try {
      amount = income ? amount : -amount;
      final user = await userRepository.addTransaction(Transaction(
       category: selectedCategory,
        description: description,
        expense: !income,
        value: amount
      ), userId);

      _userData = user.data!;
      userLocalStorage.saveUser(_userData);
      _showNetworkErrorSnackBar = false;
      notifyListeners();
      return true;
    } catch (e) {
      _showNetworkErrorSnackBar = true;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

}