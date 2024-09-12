import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/ui/screens/main_view_model.dart';
import 'ui/AppNavigator.dart';
import 'package:intl/date_symbol_data_local.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'l10n/l10n.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

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
      supportedLocales: L10n.all,
      locale: const Locale('pt'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      home: AppNavigator(),
    );
  }
}
