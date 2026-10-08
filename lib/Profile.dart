import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String username;
  final VoidCallback onLogout;

  const Profile({
    super.key,
    required this.username,
    required this.onLogout,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String _displayName;
  late String _email;
  late String _phone;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _displayName = widget.username == 'admin' ? 'Administrator' : widget.username;
    _email = widget.username == 'admin'
        ? 'admin@mobiledemo.edu'
        : '${widget.username.toLowerCase()}@example.com';
    _phone = '+63 912 345 6789';
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _displayName);
    final emailController = TextEditingController(text: _email);
    final phoneController = TextEditingController(text: _phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.edit, color: Colors.deepPurple),
            SizedBox(width: 8),
            Text('Edit Profile'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _displayName = nameController.text.trim();
                _email = emailController.text.trim();
                _phone = phoneController.text.trim();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Profile Header Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 46,
                        backgroundColor: theme.colorScheme.primary,
                        child: Text(
                          _displayName.isNotEmpty
                              ? _displayName[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _showEditProfileDialog,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: theme.colorScheme.secondary,
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _displayName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '@${widget.username}',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Role: ${widget.username == 'admin' ? 'System Administrator' : 'Student / Developer'}',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Quick stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn('4', 'Alerts'),
                      Container(height: 24, width: 1, color: Colors.grey.shade300),
                      _buildStatColumn('5', 'Contacts'),
                      Container(height: 24, width: 1, color: Colors.grey.shade300),
                      _buildStatColumn('Flutter M3', 'UI Mode'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Information Details Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1.5,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.email_outlined, color: Colors.deepPurple),
                  title: const Text('Email Address'),
                  subtitle: Text(_email),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: _showEditProfileDialog,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone_outlined, color: Colors.deepPurple),
                  title: const Text('Phone Number'),
                  subtitle: Text(_phone),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: _showEditProfileDialog,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.badge_outlined, color: Colors.deepPurple),
                  title: const Text('Account Type'),
                  subtitle: Text(
                    widget.username == 'admin' ? 'Superuser' : 'Standard User',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Preferences & Actions
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1.5,
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.deepPurple,
                  ),
                  title: const Text('Push Notifications'),
                  subtitle: const Text('Receive announcements and alerts'),
                  value: _notificationsEnabled,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          val
                              ? 'Notifications turned ON'
                              : 'Notifications turned OFF',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: Colors.deepPurple),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password update feature: Navigate to Account Security',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: widget.onLogout,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
