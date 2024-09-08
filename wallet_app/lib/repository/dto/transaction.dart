
import 'package:intl/intl.dart';

class Transaction {
  final int id;
  final double value;
  final String description;
  final String category;
  final String date = DateFormat("dd/MM/yyyy", "pt_BR").format(DateTime.now());
  bool expense;

  Transaction({
    this.id = 0,
    this.value = 0.0,
     this.description = "",
     this.category = "",
     this.expense = false,
  });

  @override
  String toString() {
    return 'Transaction(id: $id, value: $value, description: $description, category: $category, date: $date, expense: $expense)';
  }

  // Factory method to create an instance from a JSON map
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      value: double.parse(json['value'].toString()),
      description: json['description'],
      category: json['category'],
      expense: json['expense'],
    );
  }

  // Convert a Transaction instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'description': description,
      'category': category,
      'date': date,
      'expense': expense,
    };
  }
}
