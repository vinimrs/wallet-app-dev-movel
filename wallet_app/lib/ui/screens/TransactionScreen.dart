import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: (){
              // Implement your logic for transaction confirmed
              widget.onTransactionConfirmed();
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Implement your logic for transaction cancelled
              widget.onTransactionCancelled();
            },
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
                  selectedCategory = (transactionType == 'Expense' && categories.isNotEmpty) ? categories.first : 'Income';
                });
              },
              children: [Text(AppLocalizations.of(context)!.incomeButton), Text(AppLocalizations.of(context)!.expenseButton)],
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.descriptionLabel,
              ),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.amountLabel,
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
