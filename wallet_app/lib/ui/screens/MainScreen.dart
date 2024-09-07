import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String currency = "R\$"; // Simulating stringResource access for currency
    // This assumes viewModel is provided higher in the widget tree
    final viewModel = Provider.of<MainViewModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Hello, ${viewModel.getUserName()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFF01AA71)),
                  onPressed: () {
                    viewModel.logout();
                    // Handle logout logic here
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Balance', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Card(
              color: Color(0xFF01AA71),
              child: Container(
                width: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: Text(
                  '$currency ${NumberFormat("#,##0.00", "pt_BR").format(viewModel.userData.planning.balance)}',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.userData.planning.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = viewModel.userData.planning.transactions[index];
                  return ListTile(
                    leading: Icon(Icons.shopping_cart, color: transaction.expense ? Colors.red : Colors.green),
                    title: Text('${transaction.category} - ${transaction.description}'),
                    subtitle: Text(transaction.date),
                    trailing: Text(
                      '${transaction.value < 0 ? "-" : "+"}$currency ${NumberFormat("#,##0.00", "pt_BR").format(transaction.value.abs())}',
                      style: TextStyle(color: transaction.value < 0 ? Colors.red : Colors.green),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Color(0xFF01AA71)),
              onPressed: () {
                // Handle new transaction logic here
              },
              child: Text('New Transaction', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
