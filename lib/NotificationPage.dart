import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatelessWidget {
  final String notificationType; // 'general' or 'recommended'

  NotificationPage({required this.notificationType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('type', isEqualTo: notificationType)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
            return Center(child: Text('No notifications found.'));

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data['imageUrl']),
                ),
                title: Text(data['title']),
                subtitle: Text(data['subtitle']),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('notifications')
                            .doc(doc.id)
                            .delete();
                      },
                    ),
                    Text(data['time'] ?? ''),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
