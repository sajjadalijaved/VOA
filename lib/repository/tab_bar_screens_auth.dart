import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:vacation_ownership_advisor/repository/appurl.dart';

// ignore_for_file: non_constant_identifier_names

// ignore_for_file: prefer_final_fields
String? contactId;
String? id;
String? token;

class TabsScreenAuth {
  // get access token
  Future tabsScreensAccessToken() async {
    try {
      Response response = await post(Uri.parse(AppUlr.accessTokenUrl), body: {
        'refresh_token':
            "1000.21bf77a9181f05f43949c92be95be19d.bffdf6871c8be672977250370c104f7f",
        'client_id': "1000.9AAA1BAJQZT4EW9O1GGYM2FVEIPZIX",
        'client_secret': "8555f558d5fb84313209ebd182939cf28d88bcb5b5",
        'grant_type': "refresh_token"
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log("AccessData : $data");
        token = data['access_token'];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

// search contact id
  Future getContactIdMethod({required String email}) async {
    try {
      Map<String, String> headers = {
        "Authorization": "Zoho-oauthtoken $token",
        "orgId": "753177605"
      };

      var response = await get(
          Uri.parse(
              "https://desk.zoho.com/api/v1/contacts/search?email=$email"),
          headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        log("Get ContactId Data : $data");
        contactId = data['data'][0]['id'];

        log("ContactId  : $contactId");
      } else {
        log("response statusCode :${response.statusCode}");
      }
    } catch (e) {
      log("err0r : $e");
    }
  }

// create contact method
  Future contactCreateMethod({
    required String firstname,
    required String email,
    required String mobile,
  }) async {
    try {
      log("token : $token");
      Map<String, String> headers = {
        "Authorization": "Zoho-oauthtoken $token",
        "orgId": "753177605"
      };

      Map<String, dynamic> data = {
        "lastName": firstname,
        "email": email,
        "mobile": mobile
      };
      var response = await post(Uri.parse(AppUlr.createContactUrl),
          body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        log("createContactData : $data");
        id = data['id'];
        log("createContact Id in contact method : $id");
      } else {
        log("Error :${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        log("Error in create method : $e");
      }
    }
  }

// create hostel method
  Future ticketCreateMethodAuth({
    required String firstname,
    required String email,
    required String mobile,
    required String hostalName,
    required String checkInDate,
    required String checkOutDate,
    required String state,
    required String city,
    required String contactid,
    required String country,
    required String address,
    required String adults,
    required String kids,
    required String meal,
    required String budget,
    required String userId,
    required int numberroom,
    required String roomperfance,
    required String additionalInformation,
  }) async {
    try {
      log("token : $token");
      Map<String, String> headers = {
        "Authorization": "Zoho-oauthtoken $token",
        "orgId": "753177605"
      };

      Map<String, dynamic> data = {
        "subject": hostalName,
        "departmentId": "616993000000006907",
        "layoutId": "616993000000811178",
        "contactId": contactid,
        "phone": mobile,
        "email": email,
        "cf": {
          "cf_check_in_date": checkInDate,
          "cf_check_out_date": checkOutDate,
          "cf_state": state,
          "cf_city": city,
          "cf_country": country,
          "cf_address": address,
          "cf_hotel_name": hostalName,
          "cf_number_of_adults": adults,
          "cf_number_of_kids": kids,
          "cf_number_of_rooms": numberroom,
          "cf_room_preferences": roomperfance,
          "cf_meal_inclusion": meal,
          "cf_budget_per_night": budget,
          "cf_user_id": userId,
          "cf_full_name": firstname,
          "cf_additional_information": additionalInformation,
        },
        "description":
            "Check in Date : $checkInDate <br> Check out Date : $checkOutDate <br> State : $state <br> City : $city <br> Country : $country <br> Address : $address <br> Hotel Name : $hostalName <br> Number of Adults : $adults <br> Number of Kids : $kids <br> Number of Rooms : $numberroom <br> Room Preferences : $roomperfance <br> Meal Inclusion : $meal <br> Approximate Budget Per Night : $budget <br> User Id : $userId <br> Full Name : $firstname <br> Phone : $mobile <br> Email : $email <br> Additional Information : $additionalInformation <br> Subject: $hostalName"
      };
      var response = await post(Uri.parse(AppUlr.creatTicketUrl),
          body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        log("createHostalData : $data");
        return data;
      } else {
        log("Error :${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        log("err0r : $e");
      }
    }
  }

// create car rental method
  Future carRentCreateMethodAuth({
    required String firstname,
    required String email,
    required String mobile,
    required String typeCar,
    required String pickUpDate,
    required String dropoffDate,
    required String pickupTime,
    required String dropOffTime,
    required String contactid,
    required String preferredCompany,
    required String pickUpLocation,
    required String dropOffLocation,
    required String userId,
    required String additionalInformation,
  }) async {
    try {
      log("token : $token");
      Map<String, String> headers = {
        "Authorization": "Zoho-oauthtoken $token",
        "orgId": "753177605"
      };

      Map<String, dynamic> data = {
        "subject": typeCar,
        "departmentId": "616993000000006907",
        "layoutId": "616993000000839344",
        "contactId": contactid,
        "phone": mobile,
        "email": email,
        "cf": {
          "cf_location": pickUpLocation,
          "cf_pickup_date": pickUpDate,
          "cf_pickup_time": pickupTime,
          "cf_drop_location": dropOffLocation,
          "cf_dropoff_date": dropoffDate,
          "cf_dropoff_time": dropOffTime,
          "cf_type_of_car": typeCar,
          "cf_preferred_company": preferredCompany,
          "cf_additional_information": additionalInformation,
          "cf_user_id": userId,
          "cf_full_name": firstname
        },
        "description":
            "Pick Location : $pickUpLocation <br> Pickup Date : $pickUpDate <br> Pickup Time : $pickupTime <br> Drop Location : $dropOffLocation <br> Dropoff Date : $dropoffDate <br> Dropoff Time : $dropOffTime <br> Type Of Car : $typeCar <br> Preferred Company : $preferredCompany <br> Additional Information : $additionalInformation <br> User Id : $userId <br> Full Name : $firstname <br> Phone : $mobile <br> Email : $email <br> Subject: $typeCar"
      };
      var response = await post(Uri.parse(AppUlr.creatTicketUrl),
          body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        log("createCarRentalData : $data");
        return data;
      } else {
        log("Error :${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        log("err0r : $e");
      }
    }
  }

// create air fair method
  Future airFairCreateMethodAuth({
    required String firstname,
    required String email,
    required String mobile,
    required String type,
    required String toDate,
    required String contactid,
    required String fromDate,
    required String preferredAirline,
    required String fromLocation,
    required String toLocation,
    required String preferredServices,
    required String numberOfTravellers,
    required String userId,
    required String additionalInformation,
  }) async {
    try {
      log("token : $token");
      Map<String, String> headers = {
        "Authorization": "Zoho-oauthtoken $token",
        "orgId": "753177605"
      };

      Map<String, dynamic> data = {
        "subject": type,
        "departmentId": "616993000000006907",
        "layoutId": "616993000000843009",
        "contactId": contactid,
        "phone": mobile,
        "email": email,
        "cf": {
          "cf_type": type,
          "cf_airport_location": fromLocation,
          "cf_from_date": fromDate,
          "cf_to_airport_location": toLocation,
          "cf_to_date": toDate,
          "cf_number_of_travellers": numberOfTravellers,
          "cf_preferred_airline": preferredAirline,
          "cf_preferred_class_of_service": preferredServices,
          "cf_additional_information": additionalInformation,
          "cf_user_id": userId,
          "cf_full_name": firstname
        },
        "description":
            "Type : $type <br> From Airport Location : $fromLocation <br> From Date : $fromDate <br> To Airport Location : $toLocation <br> To Date : $toDate <br> Number Of Travellers : $numberOfTravellers <br> Preferred Airline : $preferredAirline <br> Preferred Class Of Service : $preferredServices <br> Additional Information : $additionalInformation <br> User Id : $userId <br> Full Name : $firstname <br> Phone : $mobile <br> Email : $email <br> Subject: $type"
      };
      var response = await post(Uri.parse(AppUlr.creatTicketUrl),
          body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        log("createAirFairData : $data");
        return data;
      } else {
        log("Error :${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        log("err0r : $e");
      }
    }
  }

// create cruise method
  Future cruiseCreateMethodAuth({
    required String userId,
    required String firstname,
    required String email,
    required String mobile,
    required String typeCruise,
    required String contactid,
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
    try {
      log("token : $token");
      Map<String, String> headers = {
        "Authorization": "Zoho-oauthtoken $token",
        "orgId": "753177605"
      };

      Map<String, dynamic> data = {
        "subject": typeCruise,
        "departmentId": "616993000000006907",
        "layoutId": "616993000000870711",
        "contactId": contactid,
        "phone": mobile,
        "email": email,
        "cf": {
          "cf_type_of_cruise": typeCruise,
          "cf_destination": destinationCruise,
          "cf_sailing_date": sailingDate,
          "cf_return_date": returnDate,
          "cf_length_of_cruise": lengthCruise,
          "cf_cruise_line_preferred": cruiseLinePreferred,
          "cf_ship_name": shipName,
          "cf_departure_port": departurePort,
          "cf_cabin_type": cabinType,
          "cf_number_of_cabin": numberCabin,
          "cf_with_without": withOrwithout,
          "cf_gratuity": gratuity,
          "cf_number_of_passengers": numberPassangers,
          "cf_passenger_s_age": passangerAge,
          "cf_additional_information": additionalInformation,
          "cf_user_id": userId,
          "cf_full_name": firstname
        },
        "description":
            "Type of Cruise : $typeCruise <br> Destination : $destinationCruise <br> Sailing Date : $sailingDate <br> Return Date : $returnDate <br> Length of Cruise : $lengthCruise <br> Cruise Line Preferred : $cruiseLinePreferred <br> Ship Name : $shipName <br> Departure Port : $departurePort <br> Cabin Type : $cabinType <br> Number of Cabin : $numberCabin <br> With/Without : $withOrwithout <br> Gratuity : $gratuity <br> Number of Passengers : $numberPassangers <br> Passenger's Age : $passangerAge <br> Additional Information : $additionalInformation <br> User Id : $userId <br> Full Name : $firstname <br> Phone : $mobile <br> Email : $email  <br> Subject: $typeCruise"
      };
      var response = await post(Uri.parse(AppUlr.creatTicketUrl),
          body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        log("createCruiseData : $data");
        return data;
      } else {
        log("Error :${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        log("err0r : $e");
      }
    }
  }

// create tour method
  Future toursCreateMethodAuth({
    required String firstname,
    required String email,
    required String mobile,
    required String typeTour,
    required String startDate,
    required String endingDate,
    required String contactid,
    required String preferredItinerary,
    required String durationTour,
    required String nameTour,
    required String numberPeople,
    required String destinationTour,
    required String budgetTour,
    required String userId,
    required String additionalInformation,
  }) async {
    try {
      log("token : $token");
      Map<String, String> headers = {
        "Authorization": "Zoho-oauthtoken $token",
        "orgId": "753177605"
      };

      Map<String, dynamic> data = {
        "subject": nameTour,
        "departmentId": "616993000000006907",
        "layoutId": "616993000000850906",
        "contactId": contactid,
        "phone": mobile,
        "email": email,
        "cf": {
          "cf_type_of_tours": typeTour,
          "cf_duration_of_tour": durationTour,
          "cf_name_of_tour": nameTour,
          "cf_starting_date": startDate,
          "cf_ending_date": endingDate,
          "cf_number_of_people": numberPeople,
          "cf_destination_of_tour": destinationTour,
          "cf_budget_of_tour": budgetTour,
          "cf_preferred_itinerary": preferredItinerary,
          "cf_additional_information": additionalInformation,
          "cf_user_id": userId,
          "cf_full_name": firstname
        },
        "description":
            "Type Of Tours : $typeTour <br> Duration Of Tour : $durationTour <br> Name Of Tour : $nameTour <br> Starting Date : $startDate <br> Ending Date : $endingDate <br> Number Of People : $numberPeople <br> Destination Of Tour : $destinationTour <br> Budget Of Tour : $budgetTour <br> Preferred Itinerary : $preferredItinerary <br> Additional Information : $additionalInformation <br> User Id : $userId <br> Full Name : $firstname <br> Phone : $mobile <br> Email : $email <br> Subject: $nameTour"
      };
      var response = await post(Uri.parse(AppUlr.creatTicketUrl),
          body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        log("createTourData : $data");
        return data;
      } else {
        log("Error :${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        log("err0r : $e");
      }
    }
  }

// create tour method
  Future specialRequestMethodAuth({
    required String firstname,
    required String email,
    required String mobile,
    required String userId,
    required String contactid,
    required String specialRequestData,
  }) async {
    try {
      log("token : $token");
      Map<String, String> headers = {
        "Authorization": "Zoho-oauthtoken $token",
        "orgId": "753177605"
      };

      Map<String, dynamic> data = {
        "subject": "Special Request",
        "departmentId": "616993000000006907",
        "layoutId": "616993000000989456",
        "contactId": contactid,
        "phone": mobile,
        "email": email,
        "cf": {
          "cf_request_description": specialRequestData,
          "cf_user_id": userId,
          "cf_full_name": firstname
        },
        "description":
            "Request Description : $specialRequestData  <br> Subject : Special Request"
      };
      var response = await post(Uri.parse(AppUlr.creatTicketUrl),
          body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        log("specialRequestData : $data");
        return data;
      } else {
        log("Error :${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        log("error : $e");
      }
    }
  }

// get contactId method
  String? getContactMethod() {
    return contactId;
  }

  // get contactCreateId method
  String? getContactCreateIdMethod() {
    return id;
  }
}
