import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../HelpSupportPage.dart';
import '../MyDetailsPage.dart';
import '../Notifications/NotificationPage.dart';
import 'OrdersPage.dart';
import '../SettingsPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Your logout logic here (e.g., FirebaseAuth.instance.signOut())
              // After logout, navigate to login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget buildListTile({required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header/Profile Info
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/Profile.png'), // Your asset/profile image
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("John Doe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("john.doe@email.com", style: TextStyle(color: Colors.black87)),
                    ],
                  ),
                ],
              ),
            ),

            // List Sections
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  buildListTile(
                    icon: Icons.person,
                    title: "My Details",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MyDetailsPage()));
                    },
                  ),
                  buildListTile(
                    icon: Icons.shopping_bag,
                    title: "Orders",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => OrdersPage()));
                    },
                  ),
                  buildListTile(
                    icon: Icons.location_on,
                    title: "Delivery Address",
                    // onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (_) => DeliveryAddressPage()));
                    // },
                  ),
                  buildListTile(
                    icon: Icons.settings,
                    title: "Settings",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage()));
                    },
                  ),
                  buildListTile(
                    icon: Icons.notifications,
                    title: "Notifications",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage(notificationType: '',)));
                    },
                  ),
                  buildListTile(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => HelpSupportPage()));
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(height: 1, color: Colors.grey),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text("Logout", style: TextStyle(color: Colors.red)),
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
