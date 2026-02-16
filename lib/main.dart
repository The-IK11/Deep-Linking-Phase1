import 'package:deep_linking_test/core/router/app_router.dart';
import 'package:deep_linking_test/helper/deeplink_handler.dart';
import 'package:deep_linking_test/helper/error_screen.dart';
import 'package:deep_linking_test/screens/home/home_screen.dart';
import 'package:deep_linking_test/screens/product/product_details_screen.dart';
import 'package:deep_linking_test/screens/profile/user_profile_screen.dart';
import 'package:deep_linking_test/screens/order/order_details_screen.dart';
import 'package:deep_linking_test/screens/promotion/promotion_screen.dart';
import 'package:deep_linking_test/screens/settings/settings_screen.dart';
import 'core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       title: 'Deep Linking Demo',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       home: const HomeScreen(),
//       onGenerateRoute: AppRouter.generateRoute,
//     );
//   }
// }

class MainApp extends StatefulWidget{
  const MainApp({super.key});

  @override
  State<MainApp>createState()=>_MainAppState();
}

class _MainAppState extends State<MainApp>{


late final GoRouter _router;

late final DeepLinkHandler _deepLinkHandler;

 @override
  void initState() {
    super.initState();
    _router = _createRouter();
    _deepLinkHandler = DeepLinkHandler(_router);
    _deepLinkHandler.initDeepLinks();
  }

 GoRouter _createRouter() {
    return GoRouter(
      initialLocation: AppRouter.home,
      debugLogDiagnostics: true, // Enable logging to see navigation
      routes: [
        // Home
        GoRoute(
          path: AppRouter.home,
          builder: (context, state) => const HomeScreen(),
        ),
        
        // Product with ID parameter
        GoRoute(
          path: '/product/:productId',
          builder: (context, state) {
            final productId = state.pathParameters['productId'] ?? 'PROD001';
            return ProductDetailsScreen(productId: productId);
          },
        ),
        
        // Profile with user ID parameter
        GoRoute(
          path: '/profile/:userId',
          builder: (context, state) {
            final userId = state.pathParameters['userId'] ?? 'USR001';
            return UserProfileScreen(userId: userId);
          },
        ),
        
        // Order with order ID parameter
        GoRoute(
          path: '/order/:orderId',
          builder: (context, state) {
            final orderId = state.pathParameters['orderId'] ?? 'ORD001';
            return OrderDetailsScreen(orderId: orderId);
          },
        ),
        
        // Promotion with promo ID parameter
        GoRoute(
          path: '/promotion/:promoId',
          builder: (context, state) {
            final promoId = state.pathParameters['promoId'] ?? 'PROMO001';
            return PromotionScreen(promoId: promoId);
          },
        ),
        
        // Settings
        GoRoute(
          path: AppRouter.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
      errorBuilder: (context, state) => ErrorScreen(error: state.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deep Linking Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      
      routerConfig: _router,
    );
  }
}