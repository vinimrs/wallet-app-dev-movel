import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback onNewTransactionClicked;
  final VoidCallback onLogoutClicked;

  MainScreen({
    required this.onNewTransactionClicked,
    required this.onLogoutClicked,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class Transaction {
  final String category;
  final String description;
  final double value;
  final String date;
  final bool expense;

  Transaction({
    required this.category,
    required this.description,
    required this.value,
    required this.date,
    required this.expense,
  });
}


class _MainScreenState extends State<MainScreen> {
  String userName = "Usuário";
  double balance = 1000.0;
  List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    final moeda = "R\$";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"Olá"}, $userName",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF01AA71),
                  ),
                  onPressed: () {

                    Navigator.pushNamed(context, 'login');
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                "Saldo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Card(
                color: Color(0xFF01AA71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "$moeda ${NumberFormat.currency(locale: "pt_BR", symbol: "").format(balance)}",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Visão Geral",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return RecentItem(
                    category: "${transaction.category} - ${transaction.description}",
                    amount: transaction.value < 0
                        ? "- $moeda ${NumberFormat.currency(locale: "pt_BR", symbol: "").format(transaction.value + 2 * (-transaction.value))}"
                        : "+ $moeda ${NumberFormat.currency(locale: "pt_BR", symbol: "").format(transaction.value)}",
                    date: transaction.date,
                    iconColor: transaction.expense ? Colors.red : Colors.green,
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF01AA71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: widget.onNewTransactionClicked,
              child: Text("Nova Transação", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentItem extends StatelessWidget {
  final String category;
  final String amount;
  final String date;
  final Color iconColor;

  RecentItem({
    required this.category,
    required this.amount,
    required this.date,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.shopping_cart,
            color: iconColor,
            size: 32,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(date, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(color: amount.startsWith("-") ? Colors.red : Colors.green),
          ),
        ],
      ),
    );
  }
}
