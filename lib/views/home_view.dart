import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_list/views/side_navigation.dart';

import '../auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Home'),
          ),
          TextButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              child: const Text('Sign out'))
        ],
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
