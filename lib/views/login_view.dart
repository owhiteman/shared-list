import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_list/auth/auth_service.dart';
import 'package:shared_list/widgets/button.dart';

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
            decoration: const InputDecoration(
              hintText: "Enter your email here",
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Enter your password here",
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              context.read<AuthService>().signIn(
                    email: _email.text.trim(),
                    password: _password.text.trim(),
                  );
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
