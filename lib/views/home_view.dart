import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: const Text('Shared List'),
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
  );
}

Widget buildMenuItems(BuildContext context) {
  return Column(
    children: [
      ListTile(
        leading: const Icon(Icons.group_outlined),
        title: const Text('Group members'),
        onTap: () {},
      ),
      const Divider(color: Colors.black54),
      ListTile(
        leading: const Icon(Icons.person_outline),
        title: const Text('Profile'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.logout_outlined),
        title: const Text('Log out'),
        onTap: () {
          context.read<AuthService>().signOut();
        },
      )
    ],
  );
}
