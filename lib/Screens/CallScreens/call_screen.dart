import 'dart:developer';
import '../../modals/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import '../../repository/homepage_auth.dart';
import '../../database/datamodel_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../view_model/services/splash_services.dart';
import 'package:vacation_ownership_advisor/Screens/home_screen.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:vacation_ownership_advisor/Utils/Notification_Services/notification_services.dart';

// ignore_for_file: non_constant_identifier_names

// ignore_for_file: prefer_typing_uninitialized_variables

// ignore_for_file: deprecated_member_use

// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison, must_be_immutable
List<String> url = <String>[
  "assets/1.jpg",
  "assets/2.jpg",
  "assets/3.jpg",
  "assets/5.jpg",
];

class CallScreen extends StatefulWidget {
  dynamic user_id;
  dynamic lat;
  dynamic long;
  CallScreen(
      {Key? key, required this.user_id, required this.lat, required this.long})
      : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  // variables
  String? firstName;
  String? id;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? token;

  String? getemail;

  List<DataModel>? models;
  DataModelProvider dataModelProvider = DataModelProvider();
  SplashServices splashServices = SplashServices();
  DataModel? latestData;
  late CarouselController _controller;

  NotificationService notificationService = NotificationService();

  List<String> servicesName = <String>[
    'Flights',
    'Tours',
    'Activities',
    'Excursions',
    'Cruises',
    'Car Rental',
    'Hotel Bookings',
    'Restaurant Reservations',
    'Security Call',
  ];

  final List<Widget> imageSliders = url
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                  ],
                )),
          ))
      .toList();

  // fetch data from database
  Future fetch() async {
    var models = await dataModelProvider.fetchData();
    if (models != null) {
      setState(() {
        this.models = models;
        latestData = models.isNotEmpty ? models.last : null;
        id = latestData!.user_id.toString();
        log("user_id : $id");
        firstName = latestData!.firstName.toString();
        log("name : $firstName");

        phoneNumber = latestData!.phoneNumber.toString();
        log("phone : $phoneNumber");
        email = latestData!.email.toString();
        log("email : $email");
      });
    } else {
      setState(() {
        this.models = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    log("late In CallScreen   : ${widget.lat}");
    log("long in CallScreen   : ${widget.long}");
    log("User_id in CallScreen   : ${widget.user_id}");
    // notificationService.requestNotificationPermission();
    // notificationService.firebaseInit(context);
    // notificationService.setupInteractMessage(context);
    _controller = CarouselController();
    if (widget.user_id == null || widget.user_id.isEmpty) {
      splashServices.updateDataToDataBase(context).whenComplete(() {
        fetch();
      }).whenComplete(() async {
        // accessToken method call
        await accesstoken();
        // tabBarScreensViewModal.accessToken(context);
      }).whenComplete(() async {
        // searchEmail method call
        await getSearchThroughEmail(email: email.toString());
      }).whenComplete(() {
        // getEmail method call
        getemail = getEmail();
      });
    } else {
      splashServices.sendUserDataToDataBase(context).whenComplete(() {
        fetch();
      }).whenComplete(() async {
        // accessToken method call
        await accesstoken();
        // tabBarScreensViewModal.accessToken(context);
      }).whenComplete(() async {
        // searchEmail method call
        await getSearchThroughEmail(email: email.toString());
      }).whenComplete(() {
        // getEmail method call
        getemail = getEmail();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CupertinoButton(
            child: const Icon(Icons.arrow_back,
                size: 30, color: Color(0xFF0092ff)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CheckConnectivityHomeScreen(userId: widget.user_id),
                  ),
                  (route) => false);
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * .06,
                ),
                FadeInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Center(
                      child: Image.asset(
                        // width: width,
                        "assets/logo.png",
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(
                  height: height * .01,
                  width: width,
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 1000),
                  duration: const Duration(milliseconds: 1000),
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
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
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
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
                  height: height * .01,
                ),
                FadeInLeft(
                  delay: const Duration(milliseconds: 1300),
                  duration: const Duration(milliseconds: 1000),
                  child: CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        aspectRatio: 16 / 9,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 0.8),
                    //carouselController: _controller,
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1400),
                  duration: const Duration(milliseconds: 1000),
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "How can we help you today?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      if (getemail != email) {
                        // sendData method call
                        await senddata(
                                firstname: firstName.toString(),
                                phonenumber: phoneNumber.toString(),
                                email: email.toString(),
                                latitude: widget.lat.toString(),
                                longitude: widget.long.toString())
                            .whenComplete(() async {
                          // DirectPhoneCall  method call

                          await FlutterPhoneDirectCaller.callNumber(
                              "1(888)752-0050");
                        });
                      } else {
                        // updateData method call
                        await updateData(
                                latitude: widget.lat.toString(),
                                longitude: widget.long.toString())
                            .whenComplete(() async {
                          // DirectPhoneCall  method call

                          await FlutterPhoneDirectCaller.callNumber(
                              "1(888)752-0050");
                        });
                        log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                      }
                    } catch (e) {
                      log("Something went wrong");
                    }
                  },
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 1600),
                    duration: const Duration(milliseconds: 1000),
                    child: Center(
                      child: Container(
                        height: height * .08,
                        width: width * .80,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 4)
                          ],
                          color: const Color(0xFF0092ff),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CarouselSlider(
                          items: servicesName
                              .map((e) => Center(
                                    child: Text(
                                      e.toString(),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 2,
                              scrollDirection: Axis.vertical,
                              autoPlayCurve: Curves.easeInOut),
                          carouselController: _controller,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1800),
                  duration: const Duration(milliseconds: 1000),
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Click the button above to connect",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1800),
                  duration: const Duration(milliseconds: 1000),
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        textAlign: TextAlign.center,
                        "with your live concierge and let them",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 2000),
                  duration: const Duration(milliseconds: 1000),
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        textAlign: TextAlign.center,
                        "know how we can best serve you today.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
