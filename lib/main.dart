import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:local_service_finder/Authentication/auth_service.dart';
import 'package:local_service_finder/Authentication/login_screen.dart';
import 'package:local_service_finder/Authentication/register_screen.dart';
import 'HomePage.dart'; // Make sure this file exists

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Service Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      initialRoute: '/login', // Start with login screen
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
