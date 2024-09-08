import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import 'screens/RegisterScreen.dart';
import 'screens/MainScreen.dart';

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
            builder = (BuildContext _) => RegisterScreen(
              onRegisterClicked: () {
                print("Register clicked");
              },
              onLoginButtonClicked: () {
                print("Login clicked");
              },
            );
            break;
          case 'main':
            builder = (BuildContext _) => MainScreen(
              onNewTransactionClicked: () {
                print("New transaction clicked");
              },
              onLogoutClicked: () {
                print("Logout clicked");
              },
            );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
