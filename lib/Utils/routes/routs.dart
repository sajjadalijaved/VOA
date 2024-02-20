import 'routesname.dart';
import 'package:flutter/material.dart';
import '../../Screens/splashscreen.dart';
import '../../Screens/AuthenticationScreens/login.dart';
import '../../Screens/AuthenticationScreens/signupscreen.dart';
import '../../Screens/AuthenticationScreens/forget_password.dart';

class Routes {
  static Route<dynamic>? generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.checkConnectivitysplashScreen:
        return MaterialPageRoute(
          builder: (context) => const CheckConnectivitySplashScreen(),
        );
      case RoutesName.checkConnectivityloginScreen:
        return MaterialPageRoute(
            builder: (context) => const CheckConnectivityLogin(),
            settings: routeSettings);
      case RoutesName.checkConnectivitysignUpScreen:
        return MaterialPageRoute(
            builder: (context) => const CheckConnectivitySignUp(),
            settings: routeSettings);

      case RoutesName.checkConnectivityForgetPassword:
        return MaterialPageRoute(
          builder: (context) => const CheckConnectivityForgetPassword(),
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
