import 'package:flutter/material.dart';
import 'package:web_app_template/presentation/router/rout_names_dart.dart';
import 'package:web_app_template/presentation/screens/shared/splash_screen.dart';
import 'package:web_app_template/presentation/screens/shared/web_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutNamesDart.rSplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutNamesDart.rWebScreen:
        return MaterialPageRoute(builder: (_) => const WebScreen());

      default:
        return null;
    }
  }
}
