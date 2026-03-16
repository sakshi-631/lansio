import 'package:flutter/material.dart';

class UserNotificationsPage extends StatefulWidget {
  const UserNotificationsPage({super.key});

  @override
  State<UserNotificationsPage> createState() => _UserNotificationsPageState();
}

class _UserNotificationsPageState extends State<UserNotificationsPage> {
  final Color customGreen = const Color.fromARGB(255, 185, 250, 187);
  final Color darkGreen = const Color.fromARGB(255, 46, 151, 58);

  late List<Map<String, dynamic>> notifications = [
    {
      'avatar': Icons.person,
      'avatarColor': Colors.blue[300]!,
      'title': "New message from Sarah Chen",
      'subtitle': "Hey, did you get the floor plans?",
      'time': "10 min ago",
      'isRead': false,
    },
    {
      'avatar': Icons.build,
      'avatarColor': darkGreen,
      'title': "Project Update: Kitchen Remodel",
      'subtitle': "Your project timeline has been updated.",
      'time': "30 hour ago",
      'isRead': false,
    },
    {
      'avatar': Icons.engineering,
      'avatarColor': Colors.orange[300]!,
      'title': "New design draft from Alex",
      'subtitle': "He uploaded a new 3D model.",
      'time': "10 hour ago",
      'isRead': false,
    },
    {
      'avatar': Icons.person,
      'avatarColor': Colors.blue[300]!,
      'title': "Payment Received",
      'subtitle': "Invoice #2023-005 has been paid",
      'time': "1 day ago",
      'isRead': true,
    },
    {
      'avatar': Icons.done,
      'avatarColor': darkGreen,
      'title': "Meeting Confirmed",
      'subtitle': "Invoice #2023-005 has been paid",
      'time': "2 days ago",
      'isRead': true,
    },
    {
      'avatar': Icons.calendar_today_rounded,
      'avatarColor': customGreen,
      'title': "Meeting Reminder",
      'subtitle': "Don't forget tomorrow's site visit",
      'time': "3 days ago",
      'isRead': true,
    },
    {
      'avatar': Icons.design_services,
      'avatarColor': Colors.purple[300]!,
      'title': "New design suggestion available",
      'subtitle': "Check out the latest layout for your project",
      'time': "5 min ago",
      'isRead': false,
    },
    {
      'avatar': Icons.warning_amber,
      'avatarColor': Colors.red[400]!,
      'title': "Payment Overdue",
      'subtitle': "Invoice #2023-008 is pending",
      'time': "6 hours ago",
      'isRead': false,
    },
    {
      'avatar': Icons.person_add,
      'avatarColor': Colors.teal[400]!,
      'title': "Worker John Doe connected",
      'subtitle': "You are now connected for the landscaping project",
      'time': "Yesterday",
      'isRead': true,
    },
  ];

  void markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  void deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF2EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECF2EC),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: darkGreen),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // Mark all as read button
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: customGreen,
                  foregroundColor: darkGreen,
                  elevation: 1,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    for (var notif in notifications) {
                      notif['isRead'] = true;
                    }
                  });
                },
                child: Row(
                  children: [
                    const Text('Mark all as read'),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: darkGreen,
                      child: Text(
                        notifications
                            .where((n) => !n['isRead'])
                            .length
                            .toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (_) => deleteNotification(index),
                background: Container(
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: 1.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: notif['isRead'] ? Colors.white : customGreen,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: notif['isRead'] ? Colors.grey[300]! : darkGreen,
                        width: notif['isRead'] ? 0.7 : 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: customGreen.withOpacity(0.19),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => markAsRead(index),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: notif['avatarColor'],
                          child: Icon(notif['avatar'], color: Colors.white),
                        ),
                        title: Text(
                          notif['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: darkGreen,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notif['subtitle'],
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            if ((notif['time'] ?? '').isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  notif['time'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
