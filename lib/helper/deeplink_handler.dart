import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeepLinkHandler {
  final GoRouter router;
  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  DeepLinkHandler(this.router);

  Future<void> initDeepLinks() async {
    // Handle initial link when app is opened from terminated state
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink);
      }
    } catch (e) {
      debugPrint('Error getting initial link: $e');
    }

    // Handle links while app is running (foreground/background)
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        _handleDeepLink(uri);
      },
      onError: (err) {
        debugPrint('Error listening to link stream: $err');
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    debugPrint('Received deep link: $uri');
    debugPrint('Scheme: ${uri.scheme}');
    debugPrint('Host: ${uri.host}');
    debugPrint('Path: ${uri.path}');
    debugPrint('Path Segments: ${uri.pathSegments}');
    
    // For custom scheme like myapp://settings or myapp://product/123
    // The structure is: scheme://host/path
    // myapp://settings -> host = "settings", path = ""
    // myapp://product/123 -> host = "product", path = "/123"
    
    String host = uri.host;
    List<String> pathSegments = uri.pathSegments;
    
    // Route based on the host (which acts as the main route)
    switch (host) {
      case 'product':
        // myapp://product/PROD001 -> pathSegments = ["PROD001"]
        if (pathSegments.isNotEmpty) {
          final productId = pathSegments[0];
          debugPrint('Navigating to product: $productId');
          router.go('/product/$productId');
        } else {
          router.go('/product/PROD001'); // Default product
        }
        break;
        
      case 'profile':
        if (pathSegments.isNotEmpty) {
          final userId = pathSegments[0];
          debugPrint('Navigating to profile: $userId');
          router.go('/profile/$userId');
        } else {
          router.go('/profile/USR001'); // Default user
        }
        break;
        
      case 'order':
        if (pathSegments.isNotEmpty) {
          final orderId = pathSegments[0];
          debugPrint('Navigating to order: $orderId');
          router.go('/order/$orderId');
        } else {
          router.go('/order/ORD001'); // Default order
        }
        break;
        
      case 'promotion':
        if (pathSegments.isNotEmpty) {
          final promoId = pathSegments[0];
          debugPrint('Navigating to promotion: $promoId');
          router.go('/promotion/$promoId');
        } else {
          router.go('/promotion/PROMO001'); // Default promo
        }
        break;
        
      case 'settings':
        debugPrint('Navigating to settings');
        router.go('/settings');
        break;
        
      case 'home':
      case '':
        debugPrint('Navigating to home');
        router.go('/');
        break;
        
      default:
        debugPrint('Unknown deep link host: $host, going to home');
        router.go('/');
        break;
    }
  }

  void dispose() {
    _linkSubscription?.cancel();
  }
}