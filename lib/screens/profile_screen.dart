import 'package:flutter/material.dart';
import 'package:wallet_wise/theme/app_theme.dart';
import 'package:wallet_wise/widgets/glass_container.dart';
import 'package:wallet_wise/services/finance_service.dart';
import 'package:wallet_wise/screens/welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FinanceService();

    return Scaffold(
      body: Container(
        decoration: AppTheme.mainGradient,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 32),
                _buildProfileCard(service),
                const SizedBox(height: 32),
                _buildMenuSection(),
                const SizedBox(height: 48),
                _buildLogoutButton(context, service),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(FinanceService service) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 32,
      child: Column(
        children: [
          const Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a'),
                radius: 50,
              ),
              CircleAvatar(
                backgroundColor: AppTheme.primaryColor,
                radius: 16,
                child: Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            service.currentUser ?? 'User',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            '${service.currentUser?.toLowerCase() ?? "user"}@premium.wise',
            style: TextStyle(color: Colors.white.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return GlassContainer(
      padding: const EdgeInsets.all(12),
      borderRadius: 32,
      child: Column(
        children: [
          _buildProfileOption(Icons.account_balance_rounded, 'Bank Accounts', '2 Connected'),
          _buildProfileOption(Icons.notifications_active_outlined, 'Smart Alerts', 'On'),
          _buildProfileOption(Icons.security_rounded, 'Security & Bio', 'Enabled'),
          _buildProfileOption(Icons.help_outline_rounded, 'Premium Support', '24/7'),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppTheme.primaryColor, size: 22),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
      trailing: Icon(Icons.chevron_right_rounded, color: Colors.white.withOpacity(0.2)),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(BuildContext context, FinanceService service) {
    return GlassContainer(
      borderRadius: 20,
      opacity: 0.05,
      border: Border.all(color: AppTheme.expenseColor.withOpacity(0.2)),
      child: ListTile(
        onTap: () async {
          await service.logout();
          if (context.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              (route) => false,
            );
          }
        },
        leading: const Icon(Icons.logout_rounded, color: AppTheme.expenseColor),
        title: const Text(
          'Sign Out',
          style: TextStyle(color: AppTheme.expenseColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
