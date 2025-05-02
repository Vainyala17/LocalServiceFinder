import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'SettingsPage.dart';
import 'notification_provider.dart';

class NotificationPage extends StatelessWidget {
  final String notificationType; // 'general' or 'recommended'

  const NotificationPage({Key? key, required this.notificationType}) : super(key: key);

  String? get currentUserId => null;


  Future<void> markAllAsRead(String userId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get unread notifications for the user
      QuerySnapshot snapshot = await firestore
          .collection('Notification')
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      WriteBatch batch = firestore.batch();

      for (var doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      await batch.commit();

      print("✅ All notifications marked as read");
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  Future<void> deleteAllNotifications() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final firestore = FirebaseFirestore.instance;

      final snapshot = await firestore
          .collection('Notification')
          .where('userId', isEqualTo: user.uid)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print('All notifications deleted');
    } catch (e) {
      print('Error deleting notifications: $e');
    }
  }

  void refreshNotifications() {
    // Logic to refresh the list
    print('Notifications refreshed');
  }

  void showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help'),
        content: const Text('This page shows all your app notifications.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String notificationType = 'general';
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade400,
        centerTitle: false,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1E1E1E)),
            onSelected: (String value) async {
              switch (value) {
                case 'mark_all_read':
                  await markAllAsRead(currentUserId!); // Replace with actual user ID
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Marked all as read')),
                  );
                  break;
                case 'delete_all':
                  deleteAllNotifications(); // Your custom method
                  break;
                case 'settings':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  break;
                case 'refresh':
                  Provider.of<NotificationProvider>(context, listen: false).refreshNotifications();
                  break;
                case 'help':
                  showHelpDialog(context); // Your custom method or dialog
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'mark_all_read', child: Text('Mark All as Read')),
              const PopupMenuItem(value: 'delete_all', child: Text('Delete All')),
              const PopupMenuItem(value: 'settings', child: Text('Notification Settings')),
              const PopupMenuItem(value: 'refresh', child: Text('Refresh')),
              const PopupMenuItem(value: 'help', child: Text('Help')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabSelector(context),
          Expanded(
            child: Consumer<NotificationProvider>(
              builder: (context, provider, child) {
                final notifications = provider.notifications
                    .where((n) => n['type'] == notificationType)
                    .toList();

                if (notifications.isEmpty) {
                  return _buildExampleNotifications();
                }

                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    return _buildNotificationCard(context, notif, notif['id']);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              context,
              'General',
              isActive: notificationType == 'general',
              onTap: () {
                if (notificationType != 'general') {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(notificationType: 'general'),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildTab(
              context,
              'Recommended',
              isActive: notificationType == 'recommended',
              onTap: () {
                if (notificationType != 'recommended') {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(notificationType: 'recommended'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String title, {required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4CAF50).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? const Color(0xFF4CAF50) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF8F8F8F),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, Map<String, dynamic> data, String docId) {
    final bool isUnread = data['isUnread'] ?? false;
    bool isFavorite = data['isFavorite'] ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isUnread)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 8, right: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
              ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data['imageUrl'] ?? 'https://via.placeholder.com/48',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 48,
                  height: 48,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] ?? 'Notification',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data['subtitle'] ?? 'No description available',
                    style: const TextStyle(
                      color: Color(0xFF8F8F8F),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTime(data['timestamp']),
                        style: const TextStyle(
                          color: Color(0xFFBBBBBB),
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          // Favorite button that toggles between heart border and filled heart
                          _buildActionButton(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            isFavorite ? Colors.red : const Color(0xFF8F8F8F),
                                () {
                              // Update favorite status
                              FirebaseFirestore.instance
                                  .collection('Notification')
                                  .doc(docId)
                                  .update({
                                'isFavorite': !isFavorite,
                              });
                            },
                          ),
                          const SizedBox(width: 16),
                          // Close button that shows a confirmation dialog before deleting
                          _buildActionButton(
                            Icons.close,
                            const Color(0xFFFF3B30),
                                () {
                              _showDeleteConfirmationDialog(context, docId);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
// Confirmation dialog for deletion
  void _showDeleteConfirmationDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Notification'),
          content: Text('Are you sure you want to delete this notification?'),
          actions: [
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Notification')
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
  Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 20,
          color: color,
        ),
      ),
    );
  }

  String _formatTime(dynamic timestamp) {
    if (timestamp == null) return 'Just now';

    if (timestamp is Timestamp) {
      final DateTime dateTime = timestamp.toDate();
      final DateTime now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${_getMonthAbbreviation(dateTime.month)} ${dateTime.day}';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } else if (timestamp is String) {
      return timestamp;
    }

    return 'Just now';
  }

  Widget _buildExampleNotifications() {
    // Example notification data
    final exampleNotifications = [
      {
        'isUnread': true,
        'imageUrl': 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=100&q=80',
        'title': 'New Message from Alex',
        'subtitle': 'Hey there! Just checking in about the project status. Can we schedule a call today?',
        'timestamp': Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 2))),
      },
      {
        'isUnread': false,
        'imageUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=100&q=80',
        'title': 'Sara liked your post',
        'subtitle': 'Your recent post "Flutter UI Design Tips" received a like',
        'timestamp': Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 1))),
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: exampleNotifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildNotificationCard(
          context,
          exampleNotifications[index],
          'example-${index}',
        );
      },
    );
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We\'ll notify you when something happens',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8F8F8F),
            ),
          ),
        ],
      ),
    );
  }
}

