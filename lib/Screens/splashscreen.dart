import 'package:flutter/material.dart';
import '../bloc/connectivity_bloc.dart';
import '../Utils/no_connection_page.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/services/splash_services.dart';
import 'package:vacation_ownership_advisor/Utils/Notification_Services/notification_services.dart';

class CheckConnectivitySplashScreen extends StatelessWidget {
  const CheckConnectivitySplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return const SplashScreen();
        } else if (state is DisConnectedState) {
          return const NoConnectionPage();
        } else {
          return Container();
        }
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    notificationService.getToken().then((value) {
      notificationService.tokenSaver(value.toString()).then((_) {
        notificationService.tokenRetriever();
      });
      splashServices.checkAuthentication(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // mediaQuery add
    // double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        //backgroundColor: const Color(0xffca8e2e),
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // app logo
          FadeInDown(
            duration: const Duration(milliseconds: 1500),
            child: Image.asset(
              "assets/logo.png",
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03, top: 2),
            child: FadeInUp(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 1000),
                child: const Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "VACATION OWNERSHIP ADVISOR",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                )),
          ),
        ],
      ),
    ));
  }
}
