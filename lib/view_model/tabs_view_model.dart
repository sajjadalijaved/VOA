import 'dart:developer';
import '../Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:vacation_ownership_advisor/Screens/home_screen.dart';
import 'package:vacation_ownership_advisor/repository/tab_bar_screens_auth.dart';

// ignore_for_file: unnecessary_null_comparison

class TabsViewModel extends ChangeNotifier {
  final tabsScreenAuth = TabsScreenAuth();

  bool _hostelloading = false;
  bool _carRentalloading = false;
  bool _airFairloading = false;
  bool _tourloading = false;
  bool _cruiseloading = false;
  bool _specialRequestloading = false;

  bool get hostelloading => _hostelloading;
  bool get carRentalloading => _carRentalloading;
  bool get airFairloading => _airFairloading;
  bool get tourloading => _tourloading;
  bool get cruiseloading => _cruiseloading;
  bool get specialRequestloading => _specialRequestloading;

  sethostelLoading(bool value) {
    _hostelloading = value;
    notifyListeners();
  }

  setCarRentalLoading(bool value) {
    _carRentalloading = value;
    notifyListeners();
  }

  setAirFairLoading(bool value) {
    _airFairloading = value;
    notifyListeners();
  }

  setToursLoading(bool value) {
    _tourloading = value;
    notifyListeners();
  }

  setCruiseLoading(bool value) {
    _cruiseloading = value;
    notifyListeners();
  }

  setSpecialRequestLoading(bool value) {
    _specialRequestloading = value;
    notifyListeners();
  }

  Future ticketCreateMethod({
    required String id,
    required BuildContext context,
    required String firstname,
    required String email,
    required String mobile,
    required String hostalName,
    required String checkInDate,
    required String checkOutDate,
    required String state,
    required String city,
    required String country,
    required String address,
    required String adults,
    required String kids,
    required String meal,
    required String budget,
    required String userId,
    required int numberroom,
    required String contactid,
    required String roomperfance,
    required String additionalInformation,
  }) async {
    sethostelLoading(true);
    await tabsScreenAuth
        .ticketCreateMethodAuth(
            firstname: firstname,
            email: email,
            mobile: mobile,
            contactid: contactid,
            hostalName: hostalName,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            state: state,
            city: city,
            country: country,
            address: address,
            adults: adults,
            kids: kids,
            meal: meal,
            budget: budget,
            userId: userId,
            numberroom: numberroom,
            roomperfance: roomperfance,
            additionalInformation: additionalInformation)
        .then((value) {
      sethostelLoading(false);
      String depart = value['departmentId'];
      log("deart Id in hotel:$depart");
      if (depart != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CheckConnectivityHomeScreen(userId: id),
            ),
            (route) => false);
        Utils.successMessageFlush(
          "Submit Data Successfully",
          context,
        );
      } else {
        Utils.errorMessageFlush("Something went wrong", context);
      }
    }).onError((error, stackTrace) {
      sethostelLoading(false);

      Utils.errorMessageFlush("Something went wrong", context);
    });
  }

  Future carRentalMethod({
    required BuildContext context,
    required String id,
    required String firstname,
    required String email,
    required String mobile,
    required String typeCar,
    required String pickupTime,
    required String dropOffTime,
    required String pickUpDate,
    required String dropoffDate,
    required String contactid,
    required String preferredCompany,
    required String pickUpLocation,
    required String dropOffLocation,
    required String userId,
    required String additionalInformation,
  }) async {
    setCarRentalLoading(true);
    await tabsScreenAuth
        .carRentCreateMethodAuth(
            pickupTime: pickupTime,
            dropOffTime: dropOffTime,
            firstname: firstname,
            contactid: contactid,
            email: email,
            mobile: mobile,
            typeCar: typeCar,
            pickUpDate: pickUpDate,
            dropoffDate: dropoffDate,
            preferredCompany: preferredCompany,
            pickUpLocation: pickUpLocation,
            dropOffLocation: dropOffLocation,
            userId: userId,
            additionalInformation: additionalInformation)
        .then((value) {
      setCarRentalLoading(false);
      String depart = value['departmentId'];
      log("deart Id in Car Rental:$depart");
      if (depart != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CheckConnectivityHomeScreen(userId: id),
            ),
            (route) => false);
        Utils.successMessageFlush(
          "Submit Data Successfully",
          context,
        );
      } else {
        Utils.errorMessageFlush("Something went wrong", context);
      }
    }).onError((error, stackTrace) {
      sethostelLoading(false);

      Utils.errorMessageFlush("Something went wrong", context);
    });
  }

  Future airFairMethod({
    required BuildContext context,
    required String firstname,
    required String email,
    required String id,
    required String mobile,
    required String type,
    required String toDate,
    required String fromDate,
    required String contactid,
    required String preferredAirline,
    required String fromLocation,
    required String toLocation,
    required String preferredServices,
    required String numberOfTravellers,
    required String userId,
    required String additionalInformation,
  }) async {
    setAirFairLoading(true);
    await tabsScreenAuth
        .airFairCreateMethodAuth(
            firstname: firstname,
            contactid: contactid,
            email: email,
            mobile: mobile,
            type: type,
            toDate: toDate,
            fromDate: fromDate,
            preferredAirline: preferredAirline,
            fromLocation: fromLocation,
            toLocation: toLocation,
            preferredServices: preferredServices,
            numberOfTravellers: numberOfTravellers,
            userId: userId,
            additionalInformation: additionalInformation)
        .then((value) {
      setAirFairLoading(false);
      String depart = value['departmentId'];
      log("deart Id in Air Fair:$depart");
      if (depart != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CheckConnectivityHomeScreen(userId: id),
            ),
            (route) => false);
        Utils.successMessageFlush(
          "Submit Data Successfully",
          context,
        );
      } else {
        Utils.errorMessageFlush("Something went wrong", context);
      }
    }).onError((error, stackTrace) {
      setAirFairLoading(false);

      Utils.errorMessageFlush("Something went wrong", context);
    });
  }

  Future cruiseMethod({
    required BuildContext context,
    required String id,
    required String userId,
    required String firstname,
    required String email,
    required String mobile,
    required String contactid,
    required String typeCruise,
    required String destinationCruise,
    required String sailingDate,
    required String returnDate,
    required String lengthCruise,
    required String cruiseLinePreferred,
    required String shipName,
    required String departurePort,
    required String cabinType,
    required String numberCabin,
    required String withOrwithout,
    required String gratuity,
    required String numberPassangers,
    required String passangerAge,
    required String additionalInformation,
  }) async {
    setCruiseLoading(true);
    await tabsScreenAuth
        .cruiseCreateMethodAuth(
            userId: userId,
            contactid: contactid,
            firstname: firstname,
            email: email,
            mobile: mobile,
            typeCruise: typeCruise,
            destinationCruise: destinationCruise,
            sailingDate: sailingDate,
            returnDate: returnDate,
            lengthCruise: lengthCruise,
            cruiseLinePreferred: cruiseLinePreferred,
            shipName: shipName,
            departurePort: departurePort,
            cabinType: cabinType,
            numberCabin: numberCabin,
            withOrwithout: withOrwithout,
            gratuity: gratuity,
            numberPassangers: numberPassangers,
            passangerAge: passangerAge,
            additionalInformation: additionalInformation)
        .then((value) {
      setCruiseLoading(false);
      String depart = value['departmentId'];
      log("deart Id in Cruise:$depart");
      if (depart != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CheckConnectivityHomeScreen(userId: id),
            ),
            (route) => false);
        Utils.successMessageFlush(
          "Submit Data Successfully",
          context,
        );
      } else {
        Utils.errorMessageFlush("Something went wrong", context);
      }
    }).onError((error, stackTrace) {
      setCruiseLoading(false);

      Utils.errorMessageFlush("Something went wrong", context);
    });
  }

  Future toursMethod({
    required BuildContext context,
    required String firstname,
    required String email,
    required String id,
    required String mobile,
    required String typeTour,
    required String startDate,
    required String contactid,
    required String endingDate,
    required String preferredItinerary,
    required String durationTour,
    required String nameTour,
    required String numberPeople,
    required String destinationTour,
    required String budgetTour,
    required String userId,
    required String additionalInformation,
  }) async {
    setToursLoading(true);
    await tabsScreenAuth
        .toursCreateMethodAuth(
            firstname: firstname,
            contactid: contactid,
            email: email,
            mobile: mobile,
            typeTour: typeTour,
            startDate: startDate,
            endingDate: endingDate,
            preferredItinerary: preferredItinerary,
            durationTour: durationTour,
            nameTour: nameTour,
            numberPeople: numberPeople,
            destinationTour: destinationTour,
            budgetTour: budgetTour,
            userId: userId,
            additionalInformation: additionalInformation)
        .then((value) {
      setToursLoading(false);
      String depart = value['departmentId'];
      log("deart Id in Tour:$depart");
      if (depart != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CheckConnectivityHomeScreen(userId: id),
            ),
            (route) => false);
        Utils.successMessageFlush(
          "Submit Data Successfully",
          context,
        );
      } else {
        Utils.errorMessageFlush("Something went wrong", context);
      }
    }).onError((error, stackTrace) {
      setToursLoading(false);

      Utils.errorMessageFlush("Something went wrong", context);
    });
  }

  Future specialRequestMethod({
    required BuildContext context,
    required String firstname,
    required String email,
    required String id,
    required String mobile,
    required String contactid,
    required String userId,
    required String specialRequestData,
  }) async {
    setSpecialRequestLoading(true);
    await tabsScreenAuth
        .specialRequestMethodAuth(
            firstname: firstname,
            email: email,
            mobile: mobile,
            userId: userId,
            contactid: contactid,
            specialRequestData: specialRequestData)
        .then((value) {
      setSpecialRequestLoading(false);
      String depart = value['departmentId'];
      log("deart Id in specialRequest:$depart");
      if (depart != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CheckConnectivityHomeScreen(userId: id),
            ),
            (route) => false);
        Utils.successMessageFlush(
          "Submit Data Successfully",
          context,
        );
      } else {
        Utils.errorMessageFlush("Something went wrong", context);
      }
    }).onError((error, stackTrace) {
      setSpecialRequestLoading(false);

      Utils.errorMessageFlush("Something went wrong", context);
    });
  }
}
