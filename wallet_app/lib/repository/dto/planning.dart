
import 'transaction.dart';

class Planning {
   final double initBalance;
   final double balance;
   final List<Transaction> transactions ;

  Planning({
     this.initBalance = 0.0,
     this.balance  = 0.0,
     this.transactions = const [],
  });

  @override
  String toString() {
    return 'Planning(initBalance: $initBalance, balance: $balance, transactions: $transactions)';
  }

  // Factory method to create an instance from a JSON map
  factory Planning.fromJson(Map<String, dynamic> json) {
    var transactionsFromJson = json['transactions'] as List;
    List<Transaction> transactionsList = transactionsFromJson.map((transactionJson) => Transaction.fromJson(transactionJson)).toList();

    return Planning(
      initBalance: double.parse(json['initBalance'].toString()),
      balance: double.parse(json['balance'].toString()),
      transactions: transactionsList,
    );
  }

  // Convert a Planning instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'initBalance': initBalance,
      'balance': balance,
      'transactions': transactions.map((transaction) => transaction.toJson()).toList(),
    };
  }

}