import 'package:flutter/services.dart';

class FieldValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is Required';
    }
    if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
        .hasMatch(value)) {
      return 'Please enter a valid Email';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password is too short";
    return null;
  }

  static String? validatePasswordMatch(String value, String pass2) {
    if (value.isEmpty) return "Confirm password is required";
    if (value != pass2) {
      return "Password doesn't match";
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) return "First name is required";
    if (value.length <= 2) {
      return "First name is too short";
    }

    return null;
  }

  static String? validateLocation(String value) {
    if (value.isEmpty) return "Location is required";

    return null;
  }

  static String? validateTime(String value) {
    if (value.isEmpty) return "Time is required";

    return null;
  }

  static String? validateTypeCar(String value) {
    if (value.isEmpty) return "Type of car is required";

    return null;
  }

  static String? validatePreferredCompany(String value) {
    if (value.isEmpty) return "Preferred company is required";

    return null;
  }

  static String? validateDropDown(String value) {
    if (value.isEmpty) return "Type of way is required";

    return null;
  }

  static String? validateTypeCruise(String value) {
    if (value.isEmpty) return "Type of cruise is required";

    return null;
  }

  static String? validateNumberTravellers(String value) {
    if (value.isEmpty) return "Number of Travellers is required";
    if (value.length > 4) {
      return "Please Enter 4 or Less Digits";
    }

    return null;
  }

  static String? validateAirlinPrefeered(String value) {
    if (value.isEmpty) return "Prefered airline is required";
    return null;
  }

  static String? validatePreferdService(String value) {
    if (value.isEmpty) return "Perfered class service is required";

    return null;
  }

  static String? validateTypeTours(String value) {
    if (value.isEmpty) return "Type of tour is required";

    return null;
  }

  static String? validateDurationTour(String value) {
    if (value.isEmpty) return "Duration of tour is required";
    if (value.length > 3) {
      return "Please Enter 3 or less digits";
    }

    return null;
  }

  static String? validateNameTour(String value) {
    if (value.isEmpty) return "Name of tour is required";

    return null;
  }

  static String? validateNumberPeople(String value) {
    if (value.isEmpty) return "Number of People is required";
    if (value.length > 4) {
      return "Please Enter only 4 or less digits";
    }

    return null;
  }

  static String? validateDestinationTour(String value) {
    if (value.isEmpty) return "Destination of tour is required";

    return null;
  }

  static String? validatePreferdItinerary(String value) {
    if (value.isEmpty) return "Perfered itinerary is required";

    return null;
  }

  static String? validateCityName(String value) {
    if (value.isEmpty) return "City name is required";
    if (value.length <= 2) {
      return "City name is too short";
    }

    return null;
  }

  static String? validateCountryName(String value) {
    if (value.isEmpty) return "Country name is required";

    return null;
  }

  static String? validateHotelName(String value) {
    if (value.isEmpty) return "Hotel name is required";
    if (value.length <= 2) {
      return "Hotel name is too short";
    }

    return null;
  }

  static String? validateAdultsNumber(String value) {
    if (value.isEmpty) return "Number of adults is required";
    if (value.length > 4) {
      return "Please enter only 4 or less digits";
    }

    return null;
  }

  static String? validateNumberKids(String value) {
    if (value.isEmpty) return "Number of kids is required";
    if (value.length > 4) {
      return "Please enter only 4 or less digits";
    }
    return null;
  }

  static String? validateAccommodationNeeds1Field(String value) {
    if (value.isEmpty) return " Number of rooms field is required";
    if (value.length > 4) {
      return "Please enter only 4 or less digits";
    }
    return null;
  }

  static String? validateAccommodationNeeds2Field(String value) {
    if (value.isEmpty) return "Accommodation Needs field is required";

    return null;
  }

  static String? validateMeal(String value) {
    if (value.isEmpty) return "Meal field is required";

    return null;
  }

  static String? validateCruiseType(String value) {
    if (value.isEmpty) return "Cruise type field is required";

    return null;
  }

  static String? validateDestination(String value) {
    if (value.isEmpty) return "Destination field is required";

    return null;
  }

  static String? validateCruiseLenth(String value) {
    if (value.isEmpty) return "Cruise length field is required";
    if (value.length > 5) {
      return "Please enter only 5 or less digits";
    }
    return null;
  }

  static String? validateCruiseLine(String value) {
    if (value.isEmpty) return "Cruise line field is required";

    return null;
  }

  static String? validateShipName(String value) {
    if (value.isEmpty) return "Ship name field is required";

    return null;
  }

  static String? validateDepaturePort(String value) {
    if (value.isEmpty) return "Departure port field is required";

    return null;
  }

  static String? validateCabinType(String value) {
    if (value.isEmpty) return "Cabin type field is required";

    return null;
  }

  static String? validateCabinNumber(String value) {
    if (value.isEmpty) return "Cabin number field is required";
    if (value.length > 3) {
      return "Please enter only 3 or less digits";
    }

    return null;
  }

  static String? validateWith(String value) {
    if (value.isEmpty) return "With or Without field is required";

    return null;
  }

  static String? validateGratuity(String value) {
    if (value.isEmpty) return "Gratuity field is required";

    return null;
  }

  static String? validatePassangerNumber(String value) {
    if (value.isEmpty) return "Passangers number field is required";
    if (value.length > 4) {
      return "Please enter only 4 or less digits";
    }

    return null;
  }

  static String? validatePassangerAge(String value) {
    if (value.isEmpty) return "Passanger age field is required";
    if (value.length > 3) {
      return "Please enter only 3 or less digits";
    }

    return null;
  }

  static String? validateBudgetPerNight(String value) {
    if (value.isEmpty) return "Budget per night field is required";
    if (value.length > 7) {
      return "Please enter only 7 or less digits";
    }

    return null;
  }

  static String? validateStateName(String value) {
    if (value.isEmpty) return "State name is required";

    return null;
  }

  static String? validateLastName(String value) {
    if (value.isEmpty) return "Last name is required";
    if (value.length <= 1) {
      return "Last name is too short";
    }

    return null;
  }

  static String? validatePinCode(String? value) {
    if (value!.isEmpty) {
      return "Incorrect PIN CODE";
    }
    return null;
  }

  static String? validateSpecialRequest(String? value) {
    if (value!.isEmpty) {
      return "Special request field is required";
    }
    return null;
  }

  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) return "Phone number is required";

    String sanitizedValue = value.replaceAll(RegExp(r'[^\d+]'), '');
    bool startsWithPlus = sanitizedValue.startsWith('+');
    if (!startsWithPlus) {
      return "Please include country code";
    }
    sanitizedValue = sanitizedValue.substring(1);

    Pattern pattern = r'^\+?\d{1,3}\d{6,14}$';
    RegExp regex = RegExp(pattern.toString());

    if (!regex.hasMatch(sanitizedValue)) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  static String? validateDate(String? input) {
    RegExp dateRegex = RegExp(
      r'^\d{4}-\d{2}-\d{2}$',
    );
    if (input!.isEmpty) {
      return "Date field is required";
    }
    if (!dateRegex.hasMatch(input)) {
      return 'Invalid date format';
    }

    final parts = input.split('-');
    if (parts.length != 3) {
      return 'Invalid date format';
    }

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);

    if (year == null || month == null || day == null) {
      return 'Invalid date format';
    }

    if (month < 1 || month > 12) {
      return 'Month Must be between 01 to 12';
    }

    if (day < 1 || day > 31) {
      return 'Day Must be between 01 to 31';
    }

    // Check for February and leap years
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        // Leap year
        if (day > 29) {
          return 'Invalid day for February in a leap year';
        }
      } else {
        // Not a leap year
        if (day > 28) {
          return 'Invalid day for February';
        }
      }
    }

    return null;
  }

  // static String? validateDate(String? input) {
  //   RegExp dateRegex = RegExp(
  //     r'^\d{2}-\d{2}-\d{4}$',
  //   );
  //   if (input!.isEmpty) {
  //     return "Date field is required";
  //   }
  //   if (!dateRegex.hasMatch(input)) {
  //     return 'Invalid date format';
  //   }

  //   final parts = input.split('-');
  //   if (parts.length != 3) {
  //     return 'Invalid date format';
  //   }

  //   final day = int.tryParse(parts[0]);
  //   final month = int.tryParse(parts[1]);
  //   final year = int.tryParse(parts[2]);

  //   if (day == null || month == null || year == null) {
  //     return 'Invalid date format';
  //   }

  //   // if (year < 1600 || year > 3100) {
  //   //   errorText = 'Year Must be between 1600 to 3100';
  //   //   return false;
  //   // }

  //   if (month < 1 || month > 12) {
  //     return 'Month Must be between 01 to 12';
  //   }

  //   if (day < 1 || day > 31) {
  //     return 'Day Must be between 01 to 31';
  //   }

  //   // Check for February and leap years
  //   if (month == 2) {
  //     if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
  //       // Leap year
  //       if (day > 29) {
  //         return 'Invalid day for February in a leap year';
  //       }
  //     } else {
  //       // Not a leap year
  //       if (day > 28) {
  //         return 'Invalid day for February';
  //       }
  //     }
  //   }

  //   return null;
  // }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is shorter than the old value, check and adjust the formatting
    if (oldValue.text.length > newValue.text.length) {
      // Check if the last character is "-" and remove it along with the previous digit
      if (oldValue.text.endsWith('-') && oldValue.text.length > 1) {
        final newString = oldValue.text.substring(0, oldValue.text.length - 2);
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(offset: newString.length),
        );
      }
    }

    // If the new value is longer than the old value, apply the usual formatting
    if (newValue.text.length == 4 || newValue.text.length == 7) {
      final newText = '${newValue.text}-';
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue;
  }
}

// class DateInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // If the new value is shorter than the old value, check and adjust the formatting
//     if (oldValue.text.length > newValue.text.length) {
//       // Check if the last character is "/" and remove it along with the previous digit
//       if (oldValue.text.endsWith('-') && oldValue.text.length > 1) {
//         final newString = oldValue.text.substring(0, oldValue.text.length - 2);
//         return TextEditingValue(
//           text: newString,
//           selection: TextSelection.collapsed(offset: newString.length),
//         );
//       }
//     }

//     // If the new value is longer than the old value, apply the usual formatting
//     if (newValue.text.length == 2 || newValue.text.length == 5) {
//       final newText = '${newValue.text}-';
//       return newValue.copyWith(
//         text: newText,
//         selection: TextSelection.collapsed(offset: newText.length),
//       );
//     }

//     return newValue;
//   }
// }
