import 'package:flutter/material.dart';
import 'package:shared_list/firebase/firestore_methods.dart';

class GroupMembersView extends StatefulWidget {
  const GroupMembersView({super.key});

  @override
  State<GroupMembersView> createState() => _GroupMembersViewState();
}

class _GroupMembersViewState extends State<GroupMembersView> {
  List<String> groupList = [];
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
    groupList = await FirestoreMethods().getGroupMembers();
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
              title: const Text('Group Members'),
            ),
            body: ListView.builder(
                itemCount: groupList.length,
                itemBuilder: (context, index) {
                  final member = groupList.elementAt(index);
                  return Card(
                    child: ListTile(
                      title: Text(member),
                    ),
                  );
                }),
          );
  }
}
