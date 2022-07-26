import 'package:flutter/material.dart';
import 'package:shared_list/views/side_navigation.dart';
import 'package:shared_list/widgets/button.dart';
import '../firebase/firestore_methods.dart';
import 'group_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return userData['groupId'] != null
        ? const GroupListView()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: Center(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/createGroup');
                    },
                    inputText: 'Create Group',
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/joinGroup');
                    },
                    inputText: 'Join Group',
                  ),
                ],
              ),
            ),
            drawer: const NavigationDrawer(),
          );
  }
}
