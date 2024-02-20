import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../bloc/connectivity_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  late TabController _tabController;

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
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFF0092ff),
        leading: CupertinoButton(
            child: const Icon(
              Icons.arrow_back_sharp,
              size: 30,
              color: Color(0xFF0092ff),
            ),
            onPressed: () {
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
              color: Color(0xFF0092ff),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Flexible(
            child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                unselectedLabelColor: Colors.grey.shade600,
                physics: const BouncingScrollPhysics(),
                controller: _tabController,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.grey.shade500,
                tabs: const [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Tab(
                      icon: Icon(
                        Icons.hotel,
                      ),
                      text: "Hotel",
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Tab(
                      icon: Icon(
                        Icons.car_rental_sharp,
                      ),
                      text: "Car Rental",
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Tab(
                      icon: Icon(
                        FontAwesomeIcons.plane,
                        size: 20,
                      ),
                      text: "Flights",
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Tab(
                      icon: Icon(
                        Icons.wallet_travel,
                      ),
                      text: "Cruise",
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Tab(
                      icon: Icon(
                        Icons.tour,
                      ),
                      text: "Tour",
                    ),
                  ),
                ]),
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
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
    );
  }
}
