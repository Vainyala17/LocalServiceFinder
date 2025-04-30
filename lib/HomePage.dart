
import 'package:flutter/material.dart';
import 'ChatPage.dart';
import 'NotificationPage.dart';
import 'OrdersPage.dart';
import 'ProfilePage.dart';
import 'HomeMainPage.dart';
import 'package:provider/provider.dart';
import 'CustomBottomNavBar.dart';
import 'notification_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(context, listen: false).fetchNotifications();
    });
  }


  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeMainPage(),         // Index 0
    OrdersPage(),           // Index 1
    ChatPage(),             // Index 2
    ProfilePage(),          // Index 3
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade400,
        titleSpacing: 17.0,
        toolbarHeight: 60,
        title: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search....",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(notificationType: '',),
                ),
              );
            },
            icon: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: _pages[_selectedIndex], // ← Swaps between Home, Orders, Chat, Profile
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
