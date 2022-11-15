import 'package:shared_list/firebase/firestore_methods.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    setUserDetails();
    super.initState();
  }

  setUserDetails() async {
    setState(() {
      isLoading = true;
    });
    userData = await FirestoreMethods().getUserDetails();
    setState(() {
      isLoading = false;
    });
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
            const SizedBox(height: 10),
            buildProfileItems(context),
            const Divider(color: Colors.black54),
            buildGroupItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  userData['displayPicUrl'] ??
                      "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                ),
                radius: 40,
              ),
              const SizedBox(height: 10),
              Text(
                userData['name'] ?? "Unkown",
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          );
  }

  Widget buildGroupItems(BuildContext context) {
    return userData['groupId'] == null
        ? Container()
        : Column(
            children: [
              ListTile(
                leading: const Icon(Icons.group_outlined),
                title: const Text('Group members'),
                onTap: () {
                  Navigator.of(context).pushNamed('/groupMembersView');
                },
              ),
              ListTile(
                leading: const Icon(Icons.directions_walk),
                title: const Text('Leave Group'),
                onTap: () async {
                  var res = await FirestoreMethods().leaveGroup();
                  if (res == 'success') {
                    if (!mounted) return;
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home', (route) => false);
                  }
                },
              ),
            ],
          );
  }

  Widget buildProfileItems(BuildContext context) {
    return Column(
      children: [
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
