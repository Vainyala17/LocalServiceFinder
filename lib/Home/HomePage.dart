
import 'package:flutter/material.dart';
import '../BottomNavBar/ChatPage.dart';
import '../BottomNavBar/FavouritePage.dart';
import '../Notifications/NotificationPage.dart';
import '../BottomNavBar/OrdersPage.dart';
import '../BottomNavBar/ProfilePage.dart';
import '../SearchPage.dart';
import 'HomeMainPage.dart';
import 'package:provider/provider.dart';
import '../BottomNavBar/CustomBottomNavBar.dart';
import '../Notifications/notification_provider.dart';

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

  final TextEditingController _searchController = TextEditingController();
  List<String> _allItems = ['Electrician', 'Mahadbt', 'Form Assistance', 'Electric Bill', 'Online Booking', 'Bank Form']; // dummy searchable data
  List<String> _suggestions = [];
  List<String> _history = [];
  String _searchResult = '';
  bool _showSuggestions = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _suggestions = _history.reversed.toList();
        _searchResult = '';
        _showSuggestions = true;
      });
      return;
    }
    List<String> matchQuery = _allItems.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      _suggestions = matchQuery;
      _searchResult = matchQuery.isEmpty ? 'No matching results found.' : '';
      _showSuggestions = true;
    });
  }

  void _onSuggestionTap(String suggestion) {
    _searchController.text = suggestion;
    if (!_history.contains(suggestion)) _history.add(suggestion);
    setState(() {
      _showSuggestions = false;
      _searchResult = 'Found: $suggestion';
    });
  }

  void _onSearchTap() {
    setState(() {
      _suggestions = _history.reversed.toList();
      _showSuggestions = true;
    });
  }

  void _removeHistoryItem(String item) {
    setState(() {
      _history.remove(item);
      if (_searchController.text.isEmpty) _suggestions = _history.reversed.toList();
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
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                    if (result != null) {
                      print("User searched: $result");
                    }
                  },
                  child: IgnorePointer(
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Search....",
                        border: InputBorder.none,
                      ),
                    ),
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
      body: Stack(
        children: [
          (_selectedIndex >= 0 && _selectedIndex < _pages.length)
              ? _pages[_selectedIndex]
              : _pages[0],
          if (_showSuggestions)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                elevation: 4,
                color: Colors.white,
                child: Container(
                  height: _suggestions.isNotEmpty ? 200 : 60,
                  child: _suggestions.isNotEmpty
                      ? ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      return ListTile(
                        title: Text(suggestion),
                        trailing: _history.contains(suggestion)
                            ? IconButton(
                          icon: Icon(Icons.close, size: 18),
                          onPressed: () => _removeHistoryItem(suggestion),
                        )
                            : null,
                        onTap: () => _onSuggestionTap(suggestion),
                      );
                    },
                  )
                      : Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_searchResult),
                  )),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
