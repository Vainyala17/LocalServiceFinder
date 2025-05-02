// lib/Search/SearchPage.dart

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
  ];

  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _filterSearch(String query) {
    final results = _allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search forms...",
            border: InputBorder.none,
          ),
          onChanged: _filterSearch,
        ),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView.builder(
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_filteredItems[index]),
            onTap: () {
              // You can return selected result back if needed
              Navigator.pop(context, _filteredItems[index]);
            },
          );
        },
      ),
    );
  }
}
