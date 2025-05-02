
import 'package:flutter/material.dart';
import 'ChatPage.dart';
import 'FavouritePage.dart';
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
    HomeMainPage(),       // index 0 -> Home
    OrdersPage(),         // index 1 -> Orders
    ChatPage(),           // index 2 -> Chat
    FavouritePage(),      // index 3 -> Favourite
    ProfilePage(),        // index 4 -> Profile
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
              Icon(Icons.search, color: Colors.black),
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
      body: (_selectedIndex >= 0 && _selectedIndex < _pages.length)
          ? _pages[_selectedIndex]
          : _pages[0], // ← Swaps between Home, Orders, Chat, Profile
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
