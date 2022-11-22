import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_list/auth/auth_service.dart';
import 'package:shared_list/widgets/button.dart';
import 'package:shared_list/widgets/error_message.dart';
import 'package:shared_list/widgets/text_field_stylings.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: LoginTextFieldDecoration().decoration("Email"),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: LoginTextFieldDecoration().decoration("Password"),
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                context.read<AuthService>().signIn(
                      email: _email.text.trim(),
                      password: _password.text.trim(),
                    );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: ErrorMessage(
                      errorText: 'Please enter an email and password'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ));
              }
            },
            inputText: 'Login',
          ),
          Row(
            children: [
              const Text("If you aren't registered, click"),
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/register');
                },
                child: const Text(" here to sign up"),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
