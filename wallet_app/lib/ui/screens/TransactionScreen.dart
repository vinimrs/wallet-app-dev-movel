import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/repository/dto/planning.dart';
import 'package:wallet_app/repository/dto/user.dart';
import 'package:wallet_app/shared_preferences/user_local_storage.dart';
import 'package:wallet_app/ui/screens/main_view_model.dart';

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
    final viewModel = Provider.of<MainViewModel>(context);
    final user = viewModel.userData.name.length > 0 ? viewModel.userData : _user;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              bool? success = await viewModel.addTransaction(
                transactionType,
                double.parse(amountController.text),
                selectedCategory,
                descriptionController.text,
                transactionType == 'Income',
                user.id
              );
              if(success != true) {
                String message = viewModel.errorMessage;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              } else {
                Navigator.pushNamed(context, 'main');
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pushNamed(context, 'main');
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
