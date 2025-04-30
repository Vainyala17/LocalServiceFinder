import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationProvider with ChangeNotifier {
  List<Map<String, dynamic>> _notifications = [];

  List<Map<String, dynamic>> get notifications => _notifications;

  Future<void> fetchNotifications() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('Notification')
          .where('userId', isEqualTo: user.uid)
          .get();

      _notifications = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching notifications: $e');
      // Optionally notifyListeners with error state if needed
    }
  }


  void refreshNotifications() {
    fetchNotifications(); // Just calls fetch again
  }
}
