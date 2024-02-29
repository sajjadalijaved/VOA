import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../bloc/connectivity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation_ownership_advisor/Screens/home_screen.dart';
import 'package:vacation_ownership_advisor/Utils/no_connection_page.dart';
import 'package:vacation_ownership_advisor/Screens/TabForms/hotel_form.dart';
import 'package:vacation_ownership_advisor/Screens/TabForms/tours_form.dart';
import 'package:vacation_ownership_advisor/Screens/TabForms/cruise_form.dart';
import 'package:vacation_ownership_advisor/Screens/TabForms/air_fair_form.dart';
import 'package:vacation_ownership_advisor/Screens/TabForms/car_rental_form.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

class CheckConnectivityTabsScreen extends StatelessWidget {
  dynamic userId;

  CheckConnectivityTabsScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return TabsMainScreen(
            userId: userId,
          );
        } else if (state is DisConnectedState) {
          return const NoConnectionPage();
        } else {
          return Container();
        }
      },
    );
  }
}

class TabsMainScreen extends StatefulWidget {
  dynamic userId;

  TabsMainScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<TabsMainScreen> createState() => _TabsMainScreenState();
}

class _TabsMainScreenState extends State<TabsMainScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int currentIndex = 0;
  List<String> name = [
    "Hotel",
    "Car Rental",
    "Flights",
    "Cruise",
    "Tour",
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("UserId in TabsScreen:${widget.userId}");
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          // backgroundColor: const Color(0xFF0092ff),
          leading: CupertinoButton(
              child: const Icon(
                Icons.arrow_back_sharp,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(-1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.easeIn;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(seconds: 1),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return CheckConnectivityHomeScreen(
                        userId: widget.userId,
                      );
                    },
                  ),
                );
              }),
          centerTitle: true,
          title: const Text(
            "Vacation Ownership Advisor",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: 70,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                              _pageController.animateToPage(
                                currentIndex,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            margin: const EdgeInsets.only(
                                top: 6, left: 8, right: 8, bottom: 4),
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.white
                                    : Colors.grey.shade100,
                                border: currentIndex == index
                                    ? Border.all(color: Colors.blue, width: 3)
                                    : null,
                                borderRadius: currentIndex == index
                                    ? BorderRadius.circular(10)
                                    : BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                name[index],
                                style: TextStyle(
                                    color: currentIndex == index
                                        ? Colors.blue
                                        : Colors.black87,
                                    fontWeight: currentIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: currentIndex == index,
                            child: Container(
                              width: 60,
                              height: 4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue),
                            ))
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: PageView(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    controller: _pageController,
                    children: [
                      HotelFormScreen(
                        userId: widget.userId,
                      ),
                      CarRentalFormScreen(
                        userId: widget.userId,
                      ),
                      AirFairFormScreen(
                        userId: widget.userId,
                      ),
                      CruiseFormScreen(
                        userId: widget.userId,
                      ),
                      ToursFormScreen(
                        userId: widget.userId,
                      )
                    ]),
              )
            ],
          ),
        ));
  }
}
