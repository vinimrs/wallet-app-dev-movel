import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import 'screens/RegisterScreen.dart';
import 'screens/MainScreen.dart';
import 'screens/TransactionScreen.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'login',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'login':
            builder = (BuildContext _) => LoginScreen();
            break;
          case 'register':
            builder = (BuildContext _) => RegisterScreen();
            break;
          case 'main':
            builder = (BuildContext _) => MainScreen();
            break;
          case 'transaction':
            builder = (BuildContext _) => TransactionScreen();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
