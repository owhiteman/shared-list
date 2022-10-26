import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_list/auth/auth_service.dart';
import 'package:shared_list/firebase_options.dart';
import 'package:shared_list/views/create_group_view.dart';
import 'package:shared_list/views/home_view.dart';
import 'package:shared_list/views/join_group_view.dart';
import 'package:shared_list/views/login_view.dart';
import 'package:shared_list/views/register_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Shared List',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const AuthenticationWrapper(),
        routes: {
          '/register': (context) => const RegisterView(),
          '/login': (context) => const LoginView(),
          '/home': (context) => const HomePage(),
          '/createGroup': (context) => const CreateGroupView(),
          '/joinGroup': (context) => const JoinGroupView(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomePage();
    } else {
      return const LoginView();
    }
  }
}
