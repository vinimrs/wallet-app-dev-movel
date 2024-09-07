import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final Color greenColor = Color(0xFF01AA71);
  final List<String> categories = ['Market', 'Health', 'Leisure', 'Bills'];
  String selectedCategory = 'Income';
  bool isIncome = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                color: greenColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        // Handle cancel logic here
                      },
                    ),
                    Text('New Transaction', style: TextStyle(fontSize: 24, color: Colors.white)),
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.white),
                      onPressed: () {
                        // Add transaction logic here
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(color: Colors.white, thickness: 1),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isIncome = true;
                        selectedCategory = 'Income';
                      });
                    },
                    child: Text(
                      'Income',
                      style: TextStyle(fontSize: 18, color: isIncome ? Colors.white : Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isIncome = false;
                        selectedCategory = '';
                      });
                    },
                    child: Text(
                      'Expense',
                      style: TextStyle(fontSize: 18, color: !isIncome ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 8),
              isIncome ? IncomeCategorySelector() : ExpenseCategorySelector(categories: categories, selectedCategory: selectedCategory, onSelect: (category) {
                setState(() {
                  selectedCategory = category;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseCategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onSelect;

  ExpenseCategorySelector({this.categories, this.selectedCategory, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCategory,
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: onSelect,
    );
  }
}

class IncomeCategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Income category fixed'), // Example of fixed category
    );
  }
}
