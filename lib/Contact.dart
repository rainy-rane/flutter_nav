import 'package:flutter/material.dart';

class ContactModel {
  final String name;
  final String phone;
  final String email;
  final String role;

  const ContactModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
  });
}

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final List<ContactModel> _allContacts = const [
    ContactModel(
      name: 'Alex Rivera',
      phone: '09123456789',
      email: 'alex.rivera@example.com',
      role: 'Project Lead',
    ),
    ContactModel(
      name: 'Sarah Connor',
      phone: '9845123456',
      email: 'sarah.c@fluttertech.io',
      role: 'UI/UX Designer',
    ),
    ContactModel(
      name: 'David Miller',
      phone: '9123456789',
      email: 'david.m@mobiledev.org',
      role: 'Backend Architect',
    ),
    ContactModel(
      name: 'Priya Sharma',
      phone: '9876501234',
      email: 'priya.sharma@campus.edu',
      role: 'QA Engineer',
    ),
    ContactModel(
      name: 'John Doe',
      phone: '9001122334',
      email: 'john.doe@example.com',
      role: 'Mobile Developer',
    ),
  ];

  String _searchQuery = '';

  void _showContactBottomSheet(ContactModel contact) {
    // Navigation showcase: Show modal bottom sheet
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                CircleAvatar(
                  radius: 36,
                  backgroundColor: theme.colorScheme.primary,
                  child: Text(
                    contact.name[0],
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  contact.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  contact.role,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const Divider(height: 28),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(contact.phone),
                  subtitle: const Text('Mobile phone'),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () {
                      Navigator.pop(context);
                      _showActionSnackbar('Calling ${contact.name} (${contact.phone})...');
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(contact.email),
                  subtitle: const Text('Email address'),
                  trailing: IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                      _showActionSnackbar('Opening email client for ${contact.email}...');
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showActionSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredContacts = _allContacts.where((c) {
      final q = _searchQuery.toLowerCase();
      return c.name.toLowerCase().contains(q) ||
          c.phone.contains(q) ||
          c.email.toLowerCase().contains(q) ||
          c.role.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search contacts by name, role...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
          ),
        ),

        // Contacts list
        Expanded(
          child: filteredContacts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_off, size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 10),
                      Text(
                        'No matching contacts found',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  itemCount: filteredContacts.length,
                  itemBuilder: (context, index) {
                    final item = filteredContacts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        leading: CircleAvatar(
                          backgroundColor:
                              theme.colorScheme.primaryContainer,
                          foregroundColor: theme.colorScheme.primary,
                          child: Text(
                            item.name[0],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.role,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.phone,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(item.phone,
                                      style: TextStyle(color: Colors.grey.shade700)),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.email,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item.email,
                                      style: TextStyle(color: Colors.grey.shade700),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.grey,
                        ),
                        onTap: () => _showContactBottomSheet(item),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
