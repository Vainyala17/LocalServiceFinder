import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(title: Text("Help & Support"),
        backgroundColor: Colors.green.shade400,),
      body: Center(child: Text("This is the My Details page")),
    );
  }
}
