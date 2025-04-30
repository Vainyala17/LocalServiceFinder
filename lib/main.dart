import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:local_service_finder/Authentication/AuthService.dart';
import 'package:local_service_finder/Authentication/LoginScreen.dart';
import 'package:local_service_finder/Authentication/RegisterScreen.dart';
import 'HomePage.dart'; // Make sure this file exists
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Service Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade400),
        useMaterial3: true,
      ),
      initialRoute: '/home', // Start with login screen
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
