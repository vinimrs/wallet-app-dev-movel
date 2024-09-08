import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/ui/screens/main_view_model.dart';
import 'ui/AppNavigator.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('pt_BR', null).then((_) =>
      runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => MainViewModel())
            ],
            child: const WalletApp(),
          )
      )
  );

}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletApp',

      home: AppNavigator(),
    );
  }
}
