import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = true;
  bool _locationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Settings', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Account', [
              _buildSettingItem(
                Icons.person_outline,
                'Edit Profile',
                'Update your personal info',
                AppColors.primary,
                onTap: () => Navigator.pushNamed(
                  context,
                  '/profile',
                  arguments: 'USR001',
                ),
              ),
              _buildSettingItem(
                Icons.lock_outline,
                'Privacy & Security',
                'Manage your account security',
                AppColors.secondary,
                onTap: () {},
              ),
              _buildSettingItem(
                Icons.credit_card_outlined,
                'Payment Methods',
                'Manage cards and wallets',
                AppColors.accent,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('Preferences', [
              _buildSwitchItem(
                Icons.notifications_outlined,
                'Push Notifications',
                'Receive order updates',
                AppColors.info,
                _notificationsEnabled,
                (value) => setState(() => _notificationsEnabled = value),
              ),
              _buildSwitchItem(
                Icons.dark_mode_outlined,
                'Dark Mode',
                'Enable dark theme',
                AppColors.textPrimary,
                _darkModeEnabled,
                (value) => setState(() => _darkModeEnabled = value),
              ),
              _buildSwitchItem(
                Icons.fingerprint,
                'Biometric Login',
                'Use fingerprint or face ID',
                AppColors.secondary,
                _biometricEnabled,
                (value) => setState(() => _biometricEnabled = value),
              ),
              _buildSwitchItem(
                Icons.location_on_outlined,
                'Location Services',
                'Enable for nearby stores',
                AppColors.error,
                _locationEnabled,
                (value) => setState(() => _locationEnabled = value),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('App Settings', [
              _buildSettingItem(
                Icons.language_outlined,
                'Language',
                'English (US)',
                AppColors.primary,
                showChevron: true,
                onTap: () {},
              ),
              _buildSettingItem(
                Icons.currency_exchange_outlined,
                'Currency',
                'USD (\$)',
                AppColors.success,
                showChevron: true,
                onTap: () {},
              ),
              _buildSettingItem(
                Icons.storage_outlined,
                'Clear Cache',
                '245 MB used',
                AppColors.warning,
                showChevron: false,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('Support', [
              _buildSettingItem(
                Icons.help_outline,
                'Help Center',
                'FAQs and guides',
                AppColors.info,
                onTap: () {},
              ),
              _buildSettingItem(
                Icons.chat_bubble_outline,
                'Contact Us',
                'Get in touch with support',
                AppColors.secondary,
                onTap: () {},
              ),
              _buildSettingItem(
                Icons.star_outline,
                'Rate App',
                'Tell us what you think',
                AppColors.accent,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('About', [
              _buildSettingItem(
                Icons.description_outlined,
                'Terms of Service',
                'Read our terms',
                AppColors.textSecondary,
                onTap: () {},
              ),
              _buildSettingItem(
                Icons.privacy_tip_outlined,
                'Privacy Policy',
                'How we handle your data',
                AppColors.textSecondary,
                onTap: () {},
              ),
              _buildSettingItem(
                Icons.info_outline,
                'App Version',
                '1.0.0 (Build 100)',
                AppColors.textSecondary,
                showChevron: false,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 32),
            _buildLogoutButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
            children: children
                .asMap()
                .entries
                .map(
                  (entry) => Column(
                    children: [
                      entry.value,
                      if (entry.key < children.length - 1)
                        const Divider(height: 1, indent: 70),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle,
    Color color, {
    bool showChevron = true,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
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
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
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
              if (showChevron)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
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
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
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
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary,
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return null;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: AppColors.error),
                const SizedBox(width: 12),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
