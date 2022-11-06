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
  var notes = [];
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
    notes = await FirestoreMethods().getGroupNotes();
    setState(() {
      isLoading = false;
    });
  }

  refresh() async {
    groupData = await FirestoreMethods().getGroupDetails();
    notes = await FirestoreMethods().getGroupNotes();
    setState(() {});
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
            body: Center(
              child: RefreshIndicator(
                onRefresh: (() async {
                  refresh();
                }),
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final member = notes.elementAt(index)['text'];
                    return Card(
                      child: ListTile(
                        title: Text(member),
                      ),
                    );
                  },
                ),
              ),
            ),
            drawer: const NavigationDrawer(),
          );
  }
}
