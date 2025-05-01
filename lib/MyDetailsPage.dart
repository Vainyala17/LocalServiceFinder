import 'package:flutter/material.dart';

class MyDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(title: Text("My Details"),
        backgroundColor: Colors.green.shade400,),
      body: Center(child: Text("This is the My Details page")),
    );
  }
}
