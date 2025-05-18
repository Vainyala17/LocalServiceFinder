import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _allItems = [
    'Form A',
    'Form B',
    'Form C',
    'Scholarship',
    'Bank Form',
    'Health Registration',
    'Aadhar Card',
    'PAN Form',
    'Driving License',
    'Job Application',
    'Hostel Form',
    'Domicile Certificate',
  ];

  List<String> _filteredItems = [];
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = [];
    _searchController.addListener(() {
      _filterSearch(_searchController.text);
    });
  }

  void _filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = [];
      });
    } else {
      final results = _allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        _filteredItems = results;
      });
    }
  }

  void _addToRecentSearches(String item) {
    setState(() {
      _recentSearches.remove(item); // remove if already exists
      _recentSearches.insert(0, item);
      if (_recentSearches.length > 10) {
        _recentSearches.removeLast(); // limit to last 10
      }
    });
  }

  void _removeRecentItem(String item) {
    setState(() {
      _recentSearches.remove(item);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return ListTile(
          title: Text(item),
          onTap: () {
            _addToRecentSearches(item);
            Navigator.pop(context, item);
          },
        );
      },
    );
  }

  Widget _buildRecentSearches() {
    if (_recentSearches.isEmpty) {
      return Center(child: Text('No recent searches'));
    }
    return ListView.builder(
      itemCount: _recentSearches.length,
      itemBuilder: (context, index) {
        final item = _recentSearches[index];
        return ListTile(
          leading: Icon(Icons.history),
          title: Text(item),
          trailing: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _removeRecentItem(item),
          ),
          onTap: () {
            _searchController.text = item;
            _filterSearch(item);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
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
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: isSearching ? _buildSearchResults() : _buildRecentSearches(),
    );
  }
}
