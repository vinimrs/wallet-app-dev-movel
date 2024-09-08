
import 'package:wallet_app/repository/dto/transaction.dart';

import 'planning.dart';

class User {
   final int id;
   final String name;
   final String email;
   final String password;
   final Planning planning;

  User({
    this.id = 0,
    this.name = "",
    this.email = "",
    this.password = "",
    required this.planning,
  });

  String get fullName => name;
  String get userEmail => email;
  List<Transaction> get transactions => planning.transactions;
  double get balance => planning.balance;

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, planning: $planning)';
  }

  // Factory method to create an instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'],
      email: json['email'],
      password: json['password'],
      planning: Planning.fromJson(json['planning']),
    );
  }

  // Convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'planning': planning.toJson(),
    };
  }
}
