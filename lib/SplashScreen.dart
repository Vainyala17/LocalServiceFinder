import 'package:flutter/material.dart';
import 'Authentication/LoginScreen.dart'; // replace with your next screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => RoleSelectionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.green[700], // your theme color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/LSF2.png', height: 120), // your logo
            SizedBox(height: 20),
            Text(
              'Local Service Finder',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              'Connecting You to Nearby Experts Instantly',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Colors.green),
          ],
        ),
      ),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select Your Role'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset('assets/LSF2.png', height: 80),
            ),
            SizedBox(height: 30),

            Text(
              'Welcome to Local Service Finder',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Choose how you want to continue',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Admin Role Card
            _buildRoleCard(
              context,
              title: 'Admin',
              subtitle: 'Manage services and users',
              icon: Icons.admin_panel_settings,
              color: Colors.orange,
              onTap: () => _navigateToAuth(context, 'admin'),
            ),

            SizedBox(height: 20),

            // User Role Card
            _buildRoleCard(
              context,
              title: 'User',
              subtitle: 'Find and book services',
              icon: Icons.person,
              color: Colors.green,
              onTap: () => _navigateToAuth(context, 'user'),
            ),

            SizedBox(height: 40),

            // Continue as Guest option
            TextButton(
              onPressed: () {
                // Navigate to guest mode or main app
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Guest mode coming soon!')),
                );
              },
              child: Text(
                'Continue as Guest',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAuth(BuildContext context, String role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AuthSelectionScreen(role: role),
      ),
    );
  }
}

class AuthSelectionScreen extends StatelessWidget {
  final String role;

  const AuthSelectionScreen({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('${role.toUpperCase()} Access'),
        backgroundColor: role == 'admin' ? Colors.orange[700] : Colors.green[700],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Role Icon
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: role == 'admin' ? Colors.orange[100] : Colors.green[100],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                role == 'admin' ? Icons.admin_panel_settings : Icons.person,
                size: 60,
                color: role == 'admin' ? Colors.orange[700] : Colors.green[700],
              ),
            ),
            SizedBox(height: 30),

            Text(
              '${role.toUpperCase()} Portal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: role == 'admin' ? Colors.orange[800] : Colors.green[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              role == 'admin'
                  ? 'Access administrative features and manage the platform'
                  : 'Find local services and connect with experts',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),

            // Login Button
            _buildAuthButton(
              context,
              title: 'Login',
              subtitle: 'Access your existing account',
              icon: Icons.login,
              onTap: () => _navigateToLogin(context, true),
            ),

            SizedBox(height: 20),

            // Register Button
            _buildAuthButton(
              context,
              title: 'Register',
              subtitle: 'Create a new account',
              icon: Icons.person_add,
              onTap: () => _navigateToLogin(context, false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthButton(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    Color primaryColor = role == 'admin' ? Colors.orange : Colors.green;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [primaryColor.withOpacity(0.1), primaryColor.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: primaryColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLogin(BuildContext context, bool isLogin) {
    // Navigate to your LoginScreen with role and auth type information
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          role: role,
          isLogin: isLogin,
        ),
      ),
    );
  }
}