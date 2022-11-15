import 'package:flutter/material.dart';
import 'package:shared_list/firebase/firestore_methods.dart';
import 'package:shared_list/widgets/button.dart';

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
        title: const Text('Join Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _groupIdController,
              decoration: const InputDecoration(
                hintText: 'Enter group ID',
              ),
              autocorrect: false,
            ),
            CustomButton(
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
              inputText: 'Join Group',
            )
          ],
        ),
      ),
    );
  }
}
