import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final String username;
  final void Function(int tabIndex) onNavigateTab;

  const Dashboard({
    super.key,
    required this.username,
    required this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Banner Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.tertiary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white,
                      child: Text(
                        username.isNotEmpty ? username[0].toUpperCase() : 'U',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.verified, size: 16, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Active Session',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome, $username!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Explore your central hub. Navigate to notifications, browse contacts, or manage your profile below.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Section Title
          Text(
            'Quick Navigation Hub',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Navigation Cards Grid
          Row(
            children: [
              Expanded(
                child: _buildNavigationCard(
                  context,
                  title: 'Notifications',
                  subtitle: '4 unread alerts',
                  icon: Icons.notifications_active_rounded,
                  color: Colors.amber.shade700,
                  onTap: () => onNavigateTab(1), // Tab 1: Notifications
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNavigationCard(
                  context,
                  title: 'Contacts',
                  subtitle: '5 team members',
                  icon: Icons.contacts_rounded,
                  color: Colors.teal.shade600,
                  onTap: () => onNavigateTab(2), // Tab 2: Contacts
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildNavigationCard(
                  context,
                  title: 'My Profile',
                  subtitle: 'Account details',
                  icon: Icons.person_rounded,
                  color: Colors.indigo.shade600,
                  onTap: () => onNavigateTab(3), // Tab 3: Profile
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNavigationCard(
                  context,
                  title: 'App Overview',
                  subtitle: 'Navigation info',
                  icon: Icons.navigation_rounded,
                  color: Colors.deepPurple.shade600,
                  onTap: () => _showOverviewDialog(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Live Navigation Features Card
          Text(
            'Navigation Features in This Project',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildFeatureRow(
                    icon: Icons.layers_rounded,
                    title: 'Stack Navigation (Push & Pop)',
                    description:
                        'Login → Registration flow with data passed back via Navigator.pop.',
                  ),
                  const Divider(height: 20),
                  _buildFeatureRow(
                    icon: Icons.dashboard_customize_rounded,
                    title: 'Bottom Navigation Bar',
                    description:
                        'Seamless 4-tab switching (Dashboard, Notifications, Contacts, Profile).',
                  ),
                  const Divider(height: 20),
                  _buildFeatureRow(
                    icon: Icons.menu_open_rounded,
                    title: 'Side Navigation Drawer',
                    description:
                        'Slide-out drawer navigation to jump to any page or trigger logout.',
                  ),
                  const Divider(height: 20),
                  _buildFeatureRow(
                    icon: Icons.call_to_action_rounded,
                    title: 'Modal Sheets & Dialogs',
                    description:
                        'Interactive bottom sheets in Contacts and modal dialogs in Notifications.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color,
              foregroundColor: Colors.white,
              child: Icon(icon, size: 22),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_forward_rounded, size: 14, color: color),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: Colors.deepPurple),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showOverviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.navigation_rounded, color: Colors.deepPurple),
            SizedBox(width: 8),
            Text('Navigation Architecture'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This application demonstrates the four core navigation architectures of Flutter:',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            Text('1. Imperative Stack (Push & Pop)'),
            Text('2. Tabbed Navigation (BottomNavigationBar & IndexedStack)'),
            Text('3. Drawer Navigation (Side Drawer)'),
            Text('4. Contextual Modals (Dialogs, Bottom Sheets & SnackBars)'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
