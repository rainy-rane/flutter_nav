import 'package:flutter/material.dart';
import 'package:flutter_loginpage/Contact.dart';
import 'package:flutter_loginpage/Dashboard.dart';
import 'package:flutter_loginpage/Profile.dart';
import 'package:flutter_loginpage/Viewnotification.dart';

class Loginpage extends StatefulWidget {
  final String username;

  const Loginpage({super.key, this.username = 'admin'});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  // Defaults to 0 so the app routes to Dashboard upon login!
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Dashboard(
        username: widget.username,
        onNavigateTab: _onTabTapped,
      ),
      const Viewnotification(),
      const Contact(),
      Profile(
        username: widget.username,
        onLogout: _showLogoutDialog,
      ),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  String _getPageTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Notifications';
      case 2:
        return 'Contacts Directory';
      case 3:
        return 'My Profile';
      default:
        return 'Dashboard';
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.deepPurple),
            SizedBox(width: 8),
            Text('Confirm Logout'),
          ],
        ),
        content: Text('Are you sure you want to log out, ${widget.username}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Dismiss dialog
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Dismiss dialog
              Navigator.pop(context); // Pop back to Login Screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully.'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getPageTitle()),
        actions: [
          GestureDetector(
            onTap: () => _onTabTapped(3), // Navigate to Profile
            child: Chip(
              avatar: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  widget.username.isNotEmpty
                      ? widget.username[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              label: Text(widget.username),
              backgroundColor:
                  theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _showLogoutDialog,
          ),
          const SizedBox(width: 8),
        ],
      ),
      // Side Navigation Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.tertiary,
                  ],
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  widget.username.isNotEmpty
                      ? widget.username[0].toUpperCase()
                      : 'U',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              accountName: Text(
                widget.username == 'admin' ? 'Administrator' : widget.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                widget.username == 'admin'
                    ? 'admin@mobiledemo.edu'
                    : '${widget.username.toLowerCase()}@example.com',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_rounded),
              title: const Text('Dashboard'),
              selected: _currentIndex == 0,
              onTap: () {
                Navigator.pop(context); // Close drawer
                _onTabTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_rounded),
              title: const Text('Notifications'),
              selected: _currentIndex == 1,
              onTap: () {
                Navigator.pop(context); // Close drawer
                _onTabTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts_rounded),
              title: const Text('Contacts Directory'),
              selected: _currentIndex == 2,
              onTap: () {
                Navigator.pop(context); // Close drawer
                _onTabTapped(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_rounded),
              title: const Text('My Profile'),
              selected: _currentIndex == 3,
              onTap: () {
                Navigator.pop(context); // Close drawer
                _onTabTapped(3);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.pop(context); // Close drawer
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey.shade600,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications_rounded),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_outlined),
            activeIcon: Icon(Icons.contacts_rounded),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
