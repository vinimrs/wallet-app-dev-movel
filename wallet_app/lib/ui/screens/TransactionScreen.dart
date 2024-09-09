import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionScreen extends StatefulWidget {
  final VoidCallback onTransactionConfirmed;
  final VoidCallback onTransactionCancelled;

  TransactionScreen({required this.onTransactionConfirmed, required this.onTransactionCancelled});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String transactionType = 'Income';
  String selectedCategory = 'Income';
  List<String> categories = ['Market', 'Health', 'Leisure', 'Bills'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Transaction'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ToggleButtons(
              isSelected: [transactionType == 'Income', transactionType == 'Expense'],
              onPressed: (int index) {
                setState(() {
                  transactionType = index == 0 ? 'Income' : 'Expense';
                  selectedCategory = index == 0 ? 'Income' : '';
                });
              },
              children: [Text('Income'), Text('Expense')],
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            if (transactionType == 'Expense') ...[
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
