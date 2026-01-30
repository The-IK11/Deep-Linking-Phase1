import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildWelcomeCard(context),
              const SizedBox(height: 28),
              const SectionHeader(
                title: 'Quick Actions',
                actionText: 'See All',
              ),
              const SizedBox(height: 16),
              _buildQuickActions(context),
              const SizedBox(height: 28),
              const SectionHeader(
                title: 'Featured Products',
                actionText: 'View All',
              ),
              const SizedBox(height: 16),
              _buildFeaturedProducts(context),
              const SizedBox(height: 28),
              const SectionHeader(
                title: 'Recent Orders',
                actionText: 'See All',
              ),
              const SizedBox(height: 16),
              _buildRecentOrders(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning! 👋',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Abraham',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            CopyLinkButton(
              link: DeepLinkHelper.getHomeLink(),
              showLabel: false,
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return GradientCard(
      gradient: AppColors.primaryGradient,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Special Offer',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Get 30% Off\nOn First Order!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/promotion', arguments: 'PROMO001');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Claim Now'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.local_offer_rounded,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        FeatureCard(
          icon: Icons.shopping_bag_rounded,
          title: 'Products',
          subtitle: 'Browse catalog',
          color: AppColors.primary,
          onTap: () => Navigator.pushNamed(context, '/product', arguments: 'PROD001'),
        ),
        FeatureCard(
          icon: Icons.receipt_long_rounded,
          title: 'Orders',
          subtitle: 'Track your orders',
          color: AppColors.secondary,
          onTap: () => Navigator.pushNamed(context, '/order', arguments: 'ORD001'),
        ),
        FeatureCard(
          icon: Icons.person_rounded,
          title: 'Profile',
          subtitle: 'View your profile',
          color: AppColors.accent,
          onTap: () => Navigator.pushNamed(context, '/profile', arguments: 'USR001'),
        ),
        FeatureCard(
          icon: Icons.settings_rounded,
          title: 'Settings',
          subtitle: 'App preferences',
          color: AppColors.info,
          onTap: () => Navigator.pushNamed(context, '/settings'),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildProductCard(
            context,
            'Wireless Headphones',
            '\$299.99',
            Icons.headphones_rounded,
            AppColors.primary,
            'PROD001',
          ),
          _buildProductCard(
            context,
            'Smart Watch Pro',
            '\$499.99',
            Icons.watch_rounded,
            AppColors.secondary,
            'PROD002',
          ),
          _buildProductCard(
            context,
            'Laptop Stand',
            '\$79.99',
            Icons.laptop_mac_rounded,
            AppColors.accent,
            'PROD003',
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String name,
    String price,
    IconData icon,
    Color color,
    String productId,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product', arguments: productId),
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 50),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              price,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrders(BuildContext context) {
    return Column(
      children: [
        _buildOrderItem(
          context,
          'ORD-2024-001',
          'Delivered',
          'Jan 28, 2024',
          AppColors.success,
          'ORD001',
        ),
        const SizedBox(height: 12),
        _buildOrderItem(
          context,
          'ORD-2024-002',
          'In Transit',
          'Jan 29, 2024',
          AppColors.warning,
          'ORD002',
        ),
        const SizedBox(height: 12),
        _buildOrderItem(
          context,
          'ORD-2024-003',
          'Processing',
          'Jan 30, 2024',
          AppColors.info,
          'ORD003',
        ),
      ],
    );
  }

  Widget _buildOrderItem(
    BuildContext context,
    String orderId,
    String status,
    String date,
    Color statusColor,
    String orderArg,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/order', arguments: orderArg),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.inventory_2_rounded,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderId,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            StatusBadge(text: status, color: statusColor),
          ],
        ),
      ),
    );
  }
}
