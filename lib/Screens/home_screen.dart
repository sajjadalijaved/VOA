import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/connectivity_bloc.dart';
import '../Utils/no_connection_page.dart';
import 'package:animate_do/animate_do.dart';
import '../../Utils/routes/routesname.dart';
import '../../view_model/user_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vacation_ownership_advisor/Widgets/custombutton.dart';
import 'package:vacation_ownership_advisor/Screens/CallScreens/mapscreen.dart';
import 'package:vacation_ownership_advisor/Screens/special_request_screen.dart';
import 'package:vacation_ownership_advisor/Screens/TabForms/tabs_main_screen.dart';
// ignore_for_file: deprecated_member_use

// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

class CheckConnectivityHomeScreen extends StatelessWidget {
  dynamic userId;
  CheckConnectivityHomeScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return HomeScreen(userId: userId);
        } else if (state is DisConnectedState) {
          return const NoConnectionPage();
        } else {
          return Container();
        }
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  dynamic userId;

  HomeScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    log("User_id in HomeScreen   : ${widget.userId}");
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    UserViewModel userPraferance = Provider.of<UserViewModel>(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  // show dialog for logout
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: [
                              Image(
                                image: const AssetImage("assets/logo.png"),
                                height: height * 0.05,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Vacation Ownership Advisor',
                              ),
                            ],
                          ),
                        ),
                        content: const Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          MaterialButton(
                            minWidth: 20,
                            elevation: 5,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            colorBrightness: Brightness.dark,
                            splashColor: Colors.white12,
                            animationDuration:
                                const Duration(milliseconds: 500),
                            textColor: Colors.white,
                            color: const Color(0xFF0092ff),
                            child: const Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          MaterialButton(
                            minWidth: 20,
                            elevation: 5,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            colorBrightness: Brightness.dark,
                            splashColor: Colors.white12,
                            animationDuration:
                                const Duration(milliseconds: 500),
                            textColor: Colors.white,
                            color: const Color(0xFF0092ff),
                            child: const Text('Yes'),
                            onPressed: () {
                              setState(() {
                                userPraferance.remove().then((value) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RoutesName.checkConnectivityloginScreen,
                                      (route) => false);
                                });
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.logout_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
          centerTitle: true,
          title: const Text(
            "Vacation Ownership Advisor",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF0092ff),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: Center(
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(
                height: height * .02,
                width: width,
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 1000),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                    child: Text(
                      "Welcome to",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 1200),
                duration: const Duration(milliseconds: 1000),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                    child: Text(
                      "Vacation Ownership Advisor",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .08,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1400),
                duration: const Duration(milliseconds: 1000),
                child: CustomButton(
                    height: height * .08,
                    width: width * .80,
                    press: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              user_id: widget.userId,
                            ),
                          ),
                          (route) => false);
                    },
                    title: "Connect With Concierge"),
              ),
              SizedBox(
                height: height * .02,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1600),
                duration: const Duration(milliseconds: 1000),
                child: CustomButton(
                    height: height * .08,
                    width: width * .80,
                    press: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckConnectivityTabsScreen(
                              userId: widget.userId,
                            ),
                          ),
                          (route) => false);
                    },
                    title: "Reservation Request"),
              ),
              SizedBox(
                height: height * .02,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1800),
                duration: const Duration(milliseconds: 1000),
                child: CustomButton(
                    height: height * .08,
                    width: width * .80,
                    press: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SpecialRequestScreen(
                                    userId: widget.userId,
                                  )),
                          (route) => false);
                    },
                    title: "Special Request"),
              ),
              SizedBox(
                height: height * .02,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // on will pop function
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press again to exit the app!');

      return Future.value(false);
    }
    return Future.value(true);
  }
}
