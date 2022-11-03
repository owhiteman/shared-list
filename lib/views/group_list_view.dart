import 'package:flutter/material.dart';
import 'package:shared_list/firestore_methods.dart';
import 'package:shared_list/views/side_navigation.dart';

class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  var groupData = {};
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
    groupData = await FirestoreMethods().getGroupDetails();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(groupData['name']),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/createNote');
                  },
                  icon: const Icon(Icons.add),
                  iconSize: 30,
                )
              ],
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
