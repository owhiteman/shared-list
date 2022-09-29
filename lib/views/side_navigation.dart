import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';

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
