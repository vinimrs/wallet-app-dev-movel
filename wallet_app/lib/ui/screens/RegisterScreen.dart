import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/ui/screens/main_view_model.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegisterClicked;
  final VoidCallback onLoginButtonClicked;

  const RegisterScreen({
    Key? key,
    required this.onRegisterClicked,
    required this.onLoginButtonClicked,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final greenColor = Color(0xFF01AA71);
    final viewModel = Provider.of<MainViewModel>(context, listen: true);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 64.0,
                color: greenColor,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Register',
                style: TextStyle(fontSize: 32.0),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                    Navigator.pushNamed(context, 'login');
                },
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: greenColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () async {
                  bool? success = await viewModel.addUser(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
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
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(WalletApp());
}

class WalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RegisterScreen(
        onRegisterClicked: () {
          print("Register clicked!");
        },
        onLoginButtonClicked: () {
          print("Login button clicked!");
        },
      ),
    );
  }
}
