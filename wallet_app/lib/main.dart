import 'package:flutter/material.dart';
import 'ui/theme.dart';
import 'ui/AppNavigator.dart';

void main() {
  runApp(WalletApp());
}

class WalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletApp',
      theme: walletAppTheme(),
      home: AppNavigator(),
    );
  }
}
