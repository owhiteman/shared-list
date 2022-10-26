import 'package:flutter/material.dart';
import 'package:shared_list/firestore_methods.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  late final TextEditingController _groupNameController;

  @override
  void initState() {
    _groupNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                hintText: 'Enter group name',
              ),
              autocorrect: false,
            ),
            TextButton(
              onPressed: () async {
                var res = await FirestoreMethods()
                    .createGroup(_groupNameController.text);
                if (res == 'success') {
                  if (!mounted) return;
                  Navigator.of(context).pushReplacementNamed('/home');
                } else {
                  print('Error occured');
                }
              },
              child: const Text('Create Group'),
            )
          ],
        ),
      ),
    );
  }
}
