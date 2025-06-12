import 'package:flutter/material.dart';

import 'Animations.dart';
import 'Authentication/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _selectedRole = '';
  bool _isButtonVisible = false;
  bool _isRoleSelected = false;

  void _selectRole(String role) {
    setState(() {
      _selectedRole = role;
      _isButtonVisible = true;
      _isRoleSelected = true;
    });
  }

  void _navigateToLogin(BuildContext context) {
    if (_selectedRole == 'User') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(role: '', isLogin: true,)),
      );
    } else if (_selectedRole == 'Admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(role: '', isLogin: true,)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isRoleSelected = _selectedRole.isNotEmpty;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              delay: 500,
              child: Text(
                'Welcome to LocalServiceFinder',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.withOpacity(0.8),
                ),
              ),
            ),
            FadeIn(
              delay: 1000,
              child: Text(
                'Choose your profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _selectRole('User'),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _selectedRole == 'User' ? 160 : 150,
                    height: _selectedRole == 'User' ? 240 : 230,
                    decoration: BoxDecoration(
                      color: _selectedRole == 'User'
                          ? Colors.green.shade200
                          : Colors.grey.withOpacity(0.3),
                      border: Border.all(
                        color: _selectedRole == 'User'
                            ? Colors.black
                            : Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleIn(
                            scale: _selectedRole == 'User' ? 1.1 : 1.0,
                            child: Image.asset(
                              'assets/User.png',
                              width: 120,
                            ),
                          ),
                          SizedBox(height: 10),
                          ScaleIn(
                            scale: _selectedRole == 'Admin' ? 1.1 : 1.0,
                            child: Text(
                              'User',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _selectedRole == 'User'
                                    ? Colors.black
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _selectRole('Admin'),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _selectedRole == 'Admin' ? 160 : 150,
                    height: _selectedRole == 'Admin' ? 240 : 230,
                    decoration: BoxDecoration(
                      color: _selectedRole == 'Admin'
                          ? Colors.green.shade200
                          : Colors.grey.withOpacity(0.3),
                      border: Border.all(
                        color: _selectedRole == 'Admin'
                            ? Colors.black
                            : Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleIn(
                            scale: _selectedRole == 'Admin' ? 1.1 : 1.0,
                            child: Image.asset(
                              'assets/Admin.png',
                              width: 120,
                            ),
                          ),
                          SizedBox(height: 10),
                          ScaleIn(
                            scale: _selectedRole == 'Admin' ? 1.1 : 1.0,
                            child: Text(
                              'Admin',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _selectedRole == 'Admin'
                                    ? Colors.black
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            AnimatedOpacity(
              opacity: _isButtonVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: ElevatedButton(
                onPressed: isRoleSelected ? () => _navigateToLogin(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRoleSelected ? Colors.green : Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Let's Go",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}