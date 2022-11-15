import 'package:flutter/material.dart';
import 'package:shared_list/firebase/firestore_methods.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  late final TextEditingController _noteController;

  @override
  void initState() {
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: 'Enter new note here',
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  var res =
                      await FirestoreMethods().createNote(_noteController.text);
                  if (res == 'success') {
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  } else {
                    print('Error occured');
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
