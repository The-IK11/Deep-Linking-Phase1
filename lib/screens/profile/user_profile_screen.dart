import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final user = _getUserData(userId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Profile',
        showBackButton: true,
        actions: [
          CopyLinkButton(link: DeepLinkHelper.getProfileLink(userId)),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(user),
            const SizedBox(height: 24),
            _buildStats(user),
            const SizedBox(height: 24),
            _buildProfileInfo(user),
            const SizedBox(height: 24),
            _buildActions(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getUserData(String id) {
    final users = {
      'USR001': {
        'name': 'Abraham Williams',
        'email': 'abraham@example.com',
        'phone': '+1 (555) 123-4567',
        'location': 'San Francisco, CA',
        'joinDate': 'January 2024',
        'orders': 24,
        'wishlist': 12,
        'reviews': 8,
        'tier': 'Gold Member',
      },
      'USR002': {
        'name': 'Sarah Johnson',
        'email': 'sarah.j@example.com',
        'phone': '+1 (555) 987-6543',
        'location': 'New York, NY',
        'joinDate': 'March 2023',
        'orders': 56,
        'wishlist': 34,
        'reviews': 22,
        'tier': 'Platinum Member',
      },
    };

    return users[id] ?? users['USR001']!;
  }

  Widget _buildProfileHeader(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Center(
              child: Text(
                user['name'].toString().split(' ').map((e) => e[0]).join(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user['name'] as String,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user['email'] as String,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                const SizedBox(width: 6),
                Text(
                  user['tier'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(Map<String, dynamic> user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildStatItem('Orders', '${user['orders']}', Icons.shopping_bag_outlined),
          const SizedBox(width: 12),
          _buildStatItem('Wishlist', '${user['wishlist']}', Icons.favorite_border),
          const SizedBox(width: 12),
          _buildStatItem('Reviews', '${user['reviews']}', Icons.rate_review_outlined),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(Map<String, dynamic> user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          InfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: user['email'] as String,
            iconColor: AppColors.primary,
          ),
          const Divider(),
          InfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: user['phone'] as String,
            iconColor: AppColors.secondary,
          ),
          const Divider(),
          InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: user['location'] as String,
            iconColor: AppColors.accent,
          ),
          const Divider(),
          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Member Since',
            value: user['joinDate'] as String,
            iconColor: AppColors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildActionItem(
            Icons.edit_outlined,
            'Edit Profile',
            'Update your personal information',
            AppColors.primary,
            () {},
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            Icons.lock_outline,
            'Change Password',
            'Update your security settings',
            AppColors.secondary,
            () {},
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            Icons.credit_card_outlined,
            'Payment Methods',
            'Manage your payment options',
            AppColors.accent,
            () {},
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            Icons.location_on_outlined,
            'Saved Addresses',
            'Manage delivery addresses',
            AppColors.info,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
