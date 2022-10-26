import 'package:flutter/material.dart';
import 'package:shared_list/firestore_methods.dart';

class JoinGroupView extends StatefulWidget {
  const JoinGroupView({super.key});

  @override
  State<JoinGroupView> createState() => _JoinGroupViewState();
}

class _JoinGroupViewState extends State<JoinGroupView> {
  late final TextEditingController _groupIdController;

  @override
  void initState() {
    _groupIdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _groupIdController.dispose();
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
              controller: _groupIdController,
              decoration: const InputDecoration(
                hintText: 'Enter group name',
              ),
              autocorrect: false,
            ),
            TextButton(
              onPressed: () async {
                var res =
                    await FirestoreMethods().joinGroup(_groupIdController.text);
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
