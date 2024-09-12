import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/repository/dto/planning.dart';
import 'package:wallet_app/repository/dto/user.dart';
import 'package:wallet_app/shared_preferences/user_local_storage.dart';
import 'package:wallet_app/ui/screens/main_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  UserLocalStorage repository = UserLocalStorage();
  User _user = User(
    planning: Planning(),
  );
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeState();

  }

  Future<void> initializeState() async {
    User userStored = await repository.getUser();
    if (userStored.name != "") {
      setState(() {
        _user = userStored;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    final viewModel = Provider.of<MainViewModel>(context, listen: true);
    final user = viewModel.userData.name.length > 0 ? viewModel.userData : _user;
    final transactions = user.transactions;
    final balance = user.balance;
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
                  "$AppLocalizations.of(context)!.hello, ${user.fullName}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF01AA71),
                  ),
                  onPressed: () {
                    viewModel.logout();
                    Navigator.pushNamed(context, 'login');
                  },
                  child: Text(AppLocalizations.of(context)!.overview),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                  AppLocalizations.of(context)!.balance,
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
              AppLocalizations.of(context)!.overview,
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
              onPressed: () {Navigator.pushNamed(context, 'transaction'); },
              child: Text(AppLocalizations.of(context)!.newTransaction, style: TextStyle(color: Colors.white)),
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
