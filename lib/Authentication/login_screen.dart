import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_service_finder/HomePage.dart';
import 'auth_service.dart';
import 'register_screen.dart';
import '../HomePage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  void login() async {
    User? user = await _auth.loginUser(emailController.text, passwordController.text);
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print("Login failed!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login")),
            TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                child: Text("Don't have an account? Register")
            ),
          ],
        ),
      ),
    );
  }
}
