import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final IconData icon;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
  });
}

class Viewnotification extends StatefulWidget {
  const Viewnotification({super.key});

  @override
  State<Viewnotification> createState() => _ViewnotificationState();
}

class _ViewnotificationState extends State<Viewnotification> {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Mobile Programming Class Update',
      description: 'Flutter navigation project guidelines and rubrics posted.',
      date: '12/10/2026',
      icon: Icons.school_rounded,
    ),
    NotificationModel(
      id: '2',
      title: 'System Maintenance Notice',
      description: 'Server will undergo scheduled maintenance tonight at 11 PM.',
      date: '10/10/2026',
      icon: Icons.build_rounded,
    ),
    NotificationModel(
      id: '3',
      title: 'Assignment Submission Verified',
      description: 'Your Flutter Login and Bottom Navigation task has been saved.',
      date: '08/10/2026',
      icon: Icons.check_circle_rounded,
    ),
    NotificationModel(
      id: '4',
      title: 'Welcome to the Navigation Demo',
      description: 'Explore the Bottom Navigation tabs and route transitions.',
      date: '01/10/2026',
      icon: Icons.campaign_rounded,
    ),
  ];

  void _showNotificationDetail(NotificationModel item) {
    // Navigation showcase: Show modal dialog for item details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(item.icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Date: ${item.date}',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              item.description,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _deleteNotification(int index) {
    final removed = _notifications[index];
    setState(() {
      _notifications.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed "${removed.title}"'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _notifications.insert(index, removed);
            });
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _addSampleNotification() {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    setState(() {
      _notifications.insert(
        0,
        NotificationModel(
          id: newId,
          title: 'New Announcement #${_notifications.length + 1}',
          description: 'Live test notification demonstrating state & navigation.',
          date: 'Just now',
          icon: Icons.notifications_active,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added new notification!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    size: 72,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No notifications left',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _addSampleNotification,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Test Notification'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor:
                          theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                      child: Icon(item.icon, color: theme.colorScheme.primary),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.date,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      tooltip: 'Delete notification',
                      onPressed: () => _deleteNotification(index),
                    ),
                    onTap: () => _showNotificationDetail(item),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSampleNotification,
        tooltip: 'Add Notification',
        child: const Icon(Icons.add),
      ),
    );
  }
}
