
import 'package:deep_linking_test/core/router/app_router.dart';
import 'package:deep_linking_test/core/widgets/common_widgets.dart';
import 'package:deep_linking_test/helper/error_screen.dart';
import 'package:deep_linking_test/screens/home/home_screen.dart';
import 'package:deep_linking_test/screens/product/product_details_screen.dart';
import 'package:deep_linking_test/screens/settings/settings_screen.dart';
import 'core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:app_links/app_links.dart';
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

//late final DeepLinkHandler _deepLinkHandler;

 @override
  void initState() {
    super.initState();
    _router = _createRouter();
    // _deepLinkHandler = DeepLinkHandler(_router);
    // _deepLinkHandler.initDeepLinks();
  }

  GoRouter _createRouter() {
    return GoRouter(
      initialLocation: AppRouter.home,
      routes: [

      GoRoute(path: AppRouter.home, builder: (context, state) => const HomeScreen()),
      GoRoute(path: AppRouter.product, builder: (context, state) {
        final productId = 'PROD001';
        return ProductDetailsScreen(productId: productId);
      }),
       GoRoute(path: AppRouter.settings, builder: (context, state) => const SettingsScreen()),
     ],
     
     errorBuilder: (context, state) => ErrorScreen(error: state.error),
     );}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Linking Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}