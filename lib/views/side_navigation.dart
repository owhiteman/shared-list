import 'package:shared_list/firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  var userData = {};

  @override
  void initState() {
    setUserDetails();
    super.initState();
  }

  setUserDetails() async {
    userData = await FirestoreMethods().getUserDetails();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(
            userData['displayPicUrl'],
          ),
          radius: 40,
        ),
        const SizedBox(height: 10),
        Text(
          userData['name'],
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
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
}
