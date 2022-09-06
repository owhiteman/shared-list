import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_list/auth/auth_service.dart';
import 'package:shared_list/views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
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
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const SizedBox(height: 10),
          const Text('Email'),
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email address here',
            ),
          ),
          const SizedBox(height: 30),
          const Text('Password'),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          TextField(
            controller: _confirmPassword,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Please confirm your password here',
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (_email.text.isNotEmpty &&
                  (_password.text.isNotEmpty &&
                      _password.text == _confirmPassword.text)) {
                context.read<AuthService>().signUp(
                      email: _email.text.trim(),
                      password: _password.text.trim(),
                    );
                Navigator.of(context).pop();
              } else {
                print('Password must be the same as confirm password');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
                'If you are already registered, click here to log in'),
          )
        ]),
      ),
    );
  }
}
