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
  String getContactId;
  CheckConnectivityTabsScreen(
      {Key? key, required this.userId, required this.getContactId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return TabsMainScreen(
            userId: userId,
            getContactId: getContactId,
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
  String getContactId;
  TabsMainScreen({Key? key, required this.userId, required this.getContactId})
      : super(key: key);

  @override
  State<TabsMainScreen> createState() => _TabsMainScreenState();
}

class _TabsMainScreenState extends State<TabsMainScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
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
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CheckConnectivityHomeScreen(userId: widget.userId),
                    ),
                    (route) => false);
              }),
          centerTitle: true,
          title: const Text(
            "Vacation Ownership Advisor",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),

          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(70),
          //   child: Flexible(
          //     child: TabBar(
          //         indicatorSize: TabBarIndicatorSize.label,
          //         //isScrollable: true,
          //         unselectedLabelColor: Colors.grey.shade600,
          //         physics: const BouncingScrollPhysics(),
          //         controller: _tabController,
          //         tabAlignment: TabAlignment.fill,
          //         dividerColor: Colors.grey.shade500,
          //         tabs: const [
          //           FittedBox(
          //             fit: BoxFit.contain,
          //             child: Tab(
          //               icon: Icon(
          //                 Icons.hotel,
          //               ),
          //               text: "Hotel",
          //             ),
          //           ),
          //           FittedBox(
          //             fit: BoxFit.contain,
          //             child: Tab(
          //               icon: Icon(
          //                 Icons.car_rental_sharp,
          //               ),
          //               text: "Car Rental",
          //             ),
          //           ),
          //           FittedBox(
          //             fit: BoxFit.contain,
          //             child: Tab(
          //               icon: Icon(
          //                 FontAwesomeIcons.plane,
          //                 size: 20,
          //               ),
          //               text: "Flights",
          //             ),
          //           ),
          //           FittedBox(
          //             fit: BoxFit.contain,
          //             child: Tab(
          //               icon: Icon(
          //                 Icons.wallet_travel,
          //               ),
          //               text: "Cruise",
          //             ),
          //           ),
          //           FittedBox(
          //             fit: BoxFit.contain,
          //             child: Tab(
          //               icon: Icon(
          //                 Icons.tour,
          //               ),
          //               text: "Tour",
          //             ),
          //           ),
          //         ]),
          //   ),
          // ),
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
                              _tabController.animateTo(currentIndex);
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
                child: TabBarView(controller: _tabController, children: [
                  HotelFormScreen(
                    userId: widget.userId,
                    getContactId: widget.getContactId,
                  ),
                  CarRentalFormScreen(
                    userId: widget.userId,
                    getContactId: widget.getContactId,
                  ),
                  AirFairFormScreen(
                    userId: widget.userId,
                    getContactId: widget.getContactId,
                  ),
                  CruiseFormScreen(
                    userId: widget.userId,
                    getContactId: widget.getContactId,
                  ),
                  ToursFormScreen(
                    userId: widget.userId,
                    getContactId: widget.getContactId,
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
