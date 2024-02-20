import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../Widgets/connectivity_check.dart';
import '../../Widgets/glassmorplic_container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore_for_file: use_build_context_synchronously

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, must_be_immutable

class MapScreen extends StatefulWidget {
  dynamic user_id;

  MapScreen({
    Key? key,
    this.user_id,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? _currentPosition;

  bool isCheck = false;
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = <Marker>{};

  // location handle permissions
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      return true;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      return false;
    }
    return true;
  }

  // get user current location function
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      // _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress =
  //           '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  // initstate function
  @override
  void initState() {
    super.initState();
    // getIcon();
    _getCurrentPosition().then((value) {
      isCheck = true;
      addMarkers();
    }).whenComplete(() async {
      log("user_id in MapScreen: ${widget.user_id}");
      log("late in MapScreen:${_currentPosition?.latitude.toString() ?? _currentPosition!.latitude.toString()}");
      log("long in MapScreen:${_currentPosition?.longitude.toString() ?? _currentPosition!.longitude.toString()}");

      await Future.delayed(const Duration(seconds: 6));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => CheckConnectivityCallScreen(
                  userId: widget.user_id,
                  lat: _currentPosition?.latitude.toString() ??
                      _currentPosition!.latitude.toString(),
                  long: _currentPosition?.longitude.toString() ??
                      _currentPosition!.longitude.toString(),
                )),
        (route) => false,
      );
    });
  }

  // add markers on google map
  addMarkers() async {
    _markers.add(Marker(
      //add start location marker
      markerId: const MarkerId('1'),
      position: LatLng(_currentPosition?.latitude ?? _currentPosition!.latitude,
          _currentPosition?.longitude ?? _currentPosition!.longitude),
      icon: BitmapDescriptor.defaultMarker,
    ));
    setState(() {
      //refresh UI
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: SizedBox(
            height: height,
            width: width,
            child: isCheck
                ? Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        liteModeEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              _currentPosition?.latitude ??
                                  _currentPosition!.latitude,
                              _currentPosition?.longitude ??
                                  _currentPosition!.longitude),
                          zoom: 14,
                        ),
                        markers: _markers,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                      Positioned(
                        top: height * 0.06,
                        right: 2,
                        left: 2,
                        child: CustomGlassmorpicContainer(
                          width: width,
                          height: height * 0.08,
                          boderRadius: 5,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "One Moment Please",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "We Are Pinpointing Your Location.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                          child: SpinKitDualRing(
                        size: 70,
                        // borderWidth: 8.0,
                        color: Color(0xFF0092ff),
                      )
                          //  LoadingAnimationWidget.discreteCircle(
                          //     color: const Color(0xFF0092ff),
                          //     size: 50,
                          //     secondRingColor: Colors.deepOrangeAccent,
                          //     thirdRingColor: Colors.purple),
                          ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * .05),
                        child: const Text(
                          "Please wait. We Are Searching Your Location.",
                          style: TextStyle(color: Colors.black54),
                        ),
                      )
                    ],
                  )));
  }
}
