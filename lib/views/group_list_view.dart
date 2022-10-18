import 'package:flutter/material.dart';
import 'package:shared_list/views/side_navigation.dart';

class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group List'),
      ),
      body: Column(
        children: const [
          Center(
            child: Text('Home'),
          ),
        ],
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
