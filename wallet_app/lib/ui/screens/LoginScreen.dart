import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/repository/dto/planning.dart';
import 'package:wallet_app/repository/dto/user.dart';
import 'package:wallet_app/shared_preferences/user_local_storage.dart';
import 'package:wallet_app/ui/screens/main_view_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserLocalStorage repository = UserLocalStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Color greenColor = Color(0xFF01AA71);

  @override
  void initState() {
    super.initState();
    initializeState();

  }

  Future<void> initializeState() async {
    User userStored = await repository.getUser();
    if (userStored.name != "") {
      Navigator.pushNamed(context, 'main');
    }

  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainViewModel>(context);


    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.email, size: 64, color: greenColor),
              SizedBox(height: 16),
              Text('Welcome back', style: TextStyle(fontSize: 32)),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: Text(
                      'No account? Register',
                      style: TextStyle(color: greenColor, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: greenColor),
                onPressed: () async {
                  bool? success = await viewModel.login(emailController.text, passwordController.text);
                  if (success != true) {
                    String message = viewModel.errorMessage;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                  } else {
                    Navigator.pushNamed(context, 'main');
                  }
                },
                child: Text('Login', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
