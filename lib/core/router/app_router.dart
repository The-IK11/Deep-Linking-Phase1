import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/product/product_details_screen.dart';
import '../../screens/profile/user_profile_screen.dart';
import '../../screens/order/order_details_screen.dart';
import '../../screens/promotion/promotion_screen.dart';
import '../../screens/settings/settings_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String product = '/product';
  static const String profile = '/profile';
  static const String order = '/order';
  static const String promotion = '/promotion';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRoute(const HomeScreen(), settings);

      case product:
        final productId = settings.arguments as String? ?? 'PROD001';
        return _buildRoute(ProductDetailsScreen(productId: productId), settings);

      case profile:
        final userId = settings.arguments as String? ?? 'USR001';
        return _buildRoute(UserProfileScreen(userId: userId), settings);

      case order:
        final orderId = settings.arguments as String? ?? 'ORD001';
        return _buildRoute(OrderDetailsScreen(orderId: orderId), settings);

      case promotion:
        final promoId = settings.arguments as String? ?? 'PROMO001';
        return _buildRoute(PromotionScreen(promoId: promoId), settings);

      case AppRouter.settings:
        return _buildRoute(const SettingsScreen(), settings);

      default:
        return _buildRoute(const HomeScreen(), settings);
    }
  }

  static PageRouteBuilder _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Parse deep link and return appropriate route
  static RouteSettings parseDeepLink(Uri uri) {
    final pathSegments = uri.pathSegments;
    
    if (pathSegments.isEmpty) {
      return const RouteSettings(name: home);
    }

    final path = pathSegments.first;
    final id = pathSegments.length > 1 ? pathSegments[1] : null;

    switch (path) {
      case 'product':
        return RouteSettings(name: product, arguments: id ?? 'PROD001');
      case 'profile':
        return RouteSettings(name: profile, arguments: id ?? 'USR001');
      case 'order':
        return RouteSettings(name: order, arguments: id ?? 'ORD001');
      case 'promotion':
        return RouteSettings(name: promotion, arguments: id ?? 'PROMO001');
      case 'settings':
        return const RouteSettings(name: settings);
      default:
        return const RouteSettings(name: home);
    }
  }
}
