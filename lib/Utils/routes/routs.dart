import 'routesname.dart';
import 'package:flutter/material.dart';
import '../../Screens/splashscreen.dart';

class Routes {
  static Route<dynamic>? generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.checkConnectivitysplashScreen:
        return MaterialPageRoute(
          builder: (context) => const CheckConnectivitySplashScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No route define'),
            ),
          ),
        );
    }
  }
}
