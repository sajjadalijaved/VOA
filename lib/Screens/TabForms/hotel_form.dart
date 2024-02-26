import 'dart:developer';
import '../../Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../modals/contact_id_model.dart';
import '../../database/datamodel_provider.dart';
import 'package:vacation_ownership_advisor/modals/data_model.dart';
import 'package:vacation_ownership_advisor/Widgets/custombutton.dart';
import 'package:vacation_ownership_advisor/Widgets/customtextfield.dart';
import 'package:vacation_ownership_advisor/view_model/tabs_view_model.dart';
import 'package:vacation_ownership_advisor/Utils/Validation/validation.dart';
import 'package:vacation_ownership_advisor/view_model/error_controll_view_model.dart';
import 'package:vacation_ownership_advisor/view_model/textformfield_change_color_view_model.dart';

// ignore_for_file: must_be_immutable

// ignore_for_file: unnecessary_null_comparison

class HotelFormScreen extends StatefulWidget {
  dynamic userId;

  HotelFormScreen({
    super.key,
    this.userId,
  });

  @override
  State<HotelFormScreen> createState() => _HotelFormScreenState();
}

class _HotelFormScreenState extends State<HotelFormScreen> {
  String? firstName;
  String? phoneNumber;
  String? email;
  String? getContact;
  String? contactUserIdFetch;

  List<DataModel>? models;
  List<ContactIdModel>? contactDataModels;
  DataModelProvider dataModelProvider = DataModelProvider();
  DataModel? latestData;
  ContactIdModel? latestContactIdData;

  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  late TextEditingController checkInDateController;
  late TextEditingController checkOutController;
  late TextEditingController stateController;
  late TextEditingController cityController;
  late TextEditingController countryController;
  late TextEditingController addreesController;
  late TextEditingController hotelNameController;
  late TextEditingController adultNumberController;
  late TextEditingController kidController;
  late TextEditingController accommodationNeeds1Controller;
  late TextEditingController accommodationNeeds2Controller;
  late TextEditingController mealController;
  late TextEditingController budgetController;
  late TextEditingController additionalFieldController;

  // focus node
  late FocusNode checkInDate;
  late FocusNode checkOutDate;
  late FocusNode state;

  // global keys
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> checkInDateFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> checkOutFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> stateFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> cityFieldKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> countryFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> hotelNameFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> adultsFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> kidsFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> accudation1FieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> accudatuion2FieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> mealFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> budgetFieldKey = GlobalKey<FormFieldState>();

  // fetch data from database
  Future fetch() async {
    var models = await dataModelProvider.fetchData();

    if (models != null) {
      setState(() {
        this.models = models;
        latestData = models.isNotEmpty ? models.last : null;
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

  Future<void> checkInDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _checkInDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _checkInDate) {
        setState(() {
          _checkInDate = picked;
          checkInDateController.text =
              "${_checkInDate!.toLocal()}".split(' ')[0];
          log("checkInDate:${checkInDateController.text.toString()}");
        });
      }
    } catch (e) {
      log("checkInDate Error:$e");
    }
  }

  Future<void> checkOutDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _checkInDate!,
        firstDate: _checkInDate!,
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _checkOutDate) {
        setState(() {
          _checkOutDate = picked;
          checkOutController.text = "${_checkOutDate!.toLocal()}".split(' ')[0];
          log("checkInDate:${checkOutController.text.toString()}");
        });
      }
    } catch (e) {
      log("checkInDate Error:$e");
    }
  }

  // fetch Contactid from database
  Future fetchContactId() async {
    var contactDataModels = await dataModelProvider.fetchContactIdMethod();
    if (contactDataModels != null) {
      setState(() {
        this.contactDataModels = contactDataModels;
        latestContactIdData =
            contactDataModels.isNotEmpty ? contactDataModels.last : null;

        if (latestContactIdData != null) {
          getContact = latestContactIdData!.contactId.toString();
          log("contactIdFetch in hotel : $getContact");
          contactUserIdFetch = latestContactIdData!.contact_user_Id.toString();
          log("contactUserIdFetch : $contactUserIdFetch");
        } else {
          getContact = " ";
          contactUserIdFetch = " ";

          log("latestContactIdData is null. Setting default values for contactIdFetch and contactUserIdFetch.");
        }
      });
    } else {
      setState(() {
        this.contactDataModels = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetch().whenComplete(() async {
      await fetchContactId();
    });

    checkInDateController = TextEditingController();
    checkOutController = TextEditingController();
    stateController = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    addreesController = TextEditingController();
    hotelNameController = TextEditingController();
    adultNumberController = TextEditingController();
    kidController = TextEditingController();
    accommodationNeeds1Controller = TextEditingController();
    accommodationNeeds2Controller = TextEditingController();
    mealController = TextEditingController();
    budgetController = TextEditingController();
    additionalFieldController = TextEditingController();

    // focus node
    checkInDate = FocusNode();
    checkOutDate = FocusNode();
    state = FocusNode();
  }

  @override
  void dispose() {
    checkInDateController.dispose();
    checkOutController.dispose();
    hotelNameController.dispose();
    cityController.dispose();
    countryController.dispose();
    stateController.dispose();
    addreesController.dispose();
    accommodationNeeds1Controller.dispose();
    accommodationNeeds2Controller.dispose();
    mealController.dispose();
    budgetController.dispose();
    adultNumberController.dispose();
    kidController.dispose();
    additionalFieldController.dispose();
    // focus node
    checkInDate.dispose();
    checkOutDate.dispose();
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    TabsViewModel tabsViewModel = Provider.of<TabsViewModel>(context);
    ErrorModelClass errorModelClass =
        Provider.of<ErrorModelClass>(context, listen: false);
    TextFieldColorChangeViewModel textFieldColorChangeViewModel =
        Provider.of<TextFieldColorChangeViewModel>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Travel Dates",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: size.width,
                  child: Row(
                    children: [
                      Consumer<TextFieldColorChangeViewModel>(
                        builder: (context, value, child) => Expanded(
                          child: CustomTextField(
                              onTap: () {
                                checkInDate.attach(context);
                                value.setCheckOUtFieldColor(Colors.black26);
                                value.setCheckInFieldColor(
                                    const Color(0xff0092ff));

                                checkInDateMethod(context);
                              },
                              paddingLeft: size.width * 0.05,
                              paddingRight: size.width * 0.01,
                              controller: checkInDateController,
                              focusNode: checkInDate,
                              inputparameter: [DateInputFormatter()],
                              validate: (value) {
                                return FieldValidator.validateDate(value);
                              },
                              sufixIcon: Icon(
                                Icons.calendar_today_sharp,
                                color: value.checkInFieldColor,
                                size: 20,
                              ),
                              textInputType: TextInputType.datetime,
                              hintText: "Check In",
                              readonly: true,
                              boderColor: value.checkInFieldColor,
                              fieldValidationkey: checkInDateFieldKey),
                        ),
                      ),
                      Consumer<ErrorModelClass>(
                        builder: (context, value, child) =>
                            Consumer<TextFieldColorChangeViewModel>(
                          builder: (context, value, child) => Expanded(
                            child: CustomTextField(
                                boderColor: value.checkOutFieldColor,
                                onTap: () {
                                  value.setCheckInFieldColor(Colors.black26);

                                  value.setCheckOUtFieldColor(
                                      const Color(0xff0092ff));
                                  if (_checkInDate == null) {
                                    errorModelClass
                                        .setErrorText("First Fill Check In");
                                  } else {
                                    errorModelClass.setErrorText("");
                                  }
                                  checkOutDateMethod(context);
                                },
                                paddingLeft: size.width * 0.01,
                                controller: checkOutController,
                                readonly: true,
                                sufixIcon: Icon(
                                  Icons.calendar_today_sharp,
                                  color: value.checkOutFieldColor,
                                  size: 20,
                                ),
                                focusNode: checkOutDate,
                                errorText: errorModelClass.errorText.isNotEmpty
                                    ? errorModelClass.errorText
                                    : null,
                                textInputType: TextInputType.datetime,
                                inputparameter: [DateInputFormatter()],
                                validate: (value) {
                                  return FieldValidator.validateDate(value);
                                },
                                onChanged: (value) {
                                  checkOutFieldKey.currentState!.validate();
                                },
                                hintText: "Check Out",
                                fieldValidationkey: checkOutFieldKey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Desired Location",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                            onTap: () {
                              textFieldColorChangeViewModel
                                  .setCheckOUtFieldColor(Colors.black26);
                            },
                            boderColor: const Color(0xff0092ff),
                            paddingRight: size.width * 0.01,
                            controller: stateController,
                            textCapitalization: TextCapitalization.words,
                            inputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            inputparameter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]'))
                            ],
                            validate: (value) {
                              return FieldValidator.validateStateName(value);
                            },
                            hintText: "Enter State Name",
                            focusNode: state,
                            fieldValidationkey: stateFieldKey),
                      ),
                      Expanded(
                        child: CustomTextField(
                            boderColor: const Color(0xff0092ff),
                            controller: cityController,
                            paddingLeft: size.width * 0.01,
                            textCapitalization: TextCapitalization.words,
                            inputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            inputparameter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]'))
                            ],
                            validate: (value) {
                              return FieldValidator.validateCityName(value);
                            },
                            hintText: "Enter City Name",
                            fieldValidationkey: cityFieldKey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                CustomTextField(
                    boderColor: const Color(0xff0092ff),
                    controller: countryController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validateCountryName(value);
                    },
                    hintText: "Enter Country Name",
                    fieldValidationkey: countryFieldKey),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05, top: size.height * 0.01),
                  child: const Text(
                    "Address is (optional)",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05, vertical: 5),
                  child: TextFormField(
                    controller: addreesController,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Enter Your Address",
                      filled: true,
                      hintStyle: const TextStyle(color: Color(0xFF97989e)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF0092ff), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF0092ff), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF0092ff), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Preferred Hotel or Brand",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextField(
                  controller: hotelNameController,
                  textCapitalization: TextCapitalization.words,
                  inputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  inputparameter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                  ],
                  validate: (value) {
                    return FieldValidator.validateHotelName(value);
                  },
                  hintText: "Enter Preferred Hotel or Brand",
                  fieldValidationkey: hotelNameFieldKey,
                  boderColor: const Color(0xff0092ff),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Number of Travelers",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: size.width,
                  child: Row(
                    children: [
                      Consumer<TextFieldColorChangeViewModel>(
                        builder: (context, value, child) => Expanded(
                          child: CustomTextField(
                            paddingRight: size.width * 0.01,
                            controller: adultNumberController,
                            textCapitalization: TextCapitalization.words,
                            inputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            inputparameter: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validate: (value) {
                              return FieldValidator.validateAdultsNumber(value);
                            },
                            onChanged: (value) {
                              adultsFieldKey.currentState!.validate();
                            },
                            hintText: "Adults Number",
                            fieldValidationkey: adultsFieldKey,
                            boderColor: const Color(0xff0092ff),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                            controller: kidController,
                            boderColor: const Color(0xff0092ff),
                            paddingLeft: size.width * 0.01,
                            textCapitalization: TextCapitalization.words,
                            inputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            inputparameter: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validate: (value) {
                              return FieldValidator.validateNumberKids(value);
                            },
                            onChanged: (value) {
                              kidsFieldKey.currentState!.validate();
                            },
                            hintText: "Kids Number",
                            fieldValidationkey: kidsFieldKey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Accommodation Needs",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                            boderColor: const Color(0xff0092ff),
                            paddingRight: size.width * 0.01,
                            controller: accommodationNeeds1Controller,
                            textCapitalization: TextCapitalization.words,
                            inputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                            inputparameter: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validate: (value) {
                              return FieldValidator
                                  .validateAccommodationNeeds1Field(value);
                            },
                            onChanged: (value) {
                              accudation1FieldKey.currentState!.validate();
                            },
                            hintText: "Rooms Number",
                            fieldValidationkey: accudation1FieldKey),
                      ),
                      Expanded(
                        child: CustomTextField(
                            boderColor: const Color(0xff0092ff),
                            paddingLeft: size.width * 0.01,
                            controller: accommodationNeeds2Controller,
                            textCapitalization: TextCapitalization.words,
                            inputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            inputparameter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]'))
                            ],
                            validate: (value) {
                              return FieldValidator
                                  .validateAccommodationNeeds2Field(value);
                            },
                            hintText: "Room Type",
                            fieldValidationkey: accudatuion2FieldKey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Meal Inclusion",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextField(
                    boderColor: const Color(0xff0092ff),
                    controller: mealController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validateMeal(value);
                    },
                    hintText: "Enter Meal Inclusion",
                    fieldValidationkey: mealFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Approximate Budget Per Night",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextField(
                    boderColor: const Color(0xff0092ff),
                    controller: budgetController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "Budget cannot be empty.";
                      } else if (!RegExp(r'^[0-9\$]*$').hasMatch(value)) {
                        return "Invalid input: Only digits and \$ sign are allowed.";
                      } else {
                        return FieldValidator.validateBudgetPerNight(value);
                      }
                    },
                    onChanged: (String value) {
                      budgetFieldKey.currentState!.validate();
                    },
                    hintText: "\$5 ",
                    fieldValidationkey: budgetFieldKey),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05, top: size.height * 0.01),
                  child: const Text(
                    "Additional Information (optional)",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: TextFormField(
                    controller: additionalFieldController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLength: 150,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter Additional Information",
                      filled: true,
                      hintStyle: const TextStyle(color: Color(0xFF97989e)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF0092ff), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF0092ff), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF0092ff), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                  child: CustomButton(
                      loading: tabsViewModel.hostelloading,
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      press: () async {
                        FocusScope.of(context).unfocus();
                        if (key.currentState!.validate() &&
                            checkInDateFieldKey.currentState!.validate() &&
                            checkOutFieldKey.currentState!.validate() &&
                            stateFieldKey.currentState!.validate() &&
                            cityFieldKey.currentState!.validate() &&
                            countryFieldKey.currentState!.validate() &&
                            hotelNameFieldKey.currentState!.validate() &&
                            adultsFieldKey.currentState!.validate() &&
                            kidsFieldKey.currentState!.validate() &&
                            mealFieldKey.currentState!.validate() &&
                            budgetFieldKey.currentState!.validate() &&
                            accudation1FieldKey.currentState!.validate() &&
                            accudatuion2FieldKey.currentState!.validate()) {
                          String firstname = firstName.toString();
                          String email1 = email.toString();
                          String mobile = phoneNumber.toString();
                          String hostalName =
                              hotelNameController.text.toString();
                          String checkInDate =
                              checkInDateController.text.toString();
                          String checkOutDate =
                              checkOutController.text.toString();
                          String state = stateController.text.toString();
                          String city = cityController.text.toString();
                          String country = countryController.text.toString();
                          String address = addreesController.text.toString();
                          String adults = adultNumberController.text.toString();
                          String kids = kidController.text.toString();
                          String meal = mealController.text.toString();
                          String budget = budgetController.text.toString();
                          int numberroom = int.parse(
                              accommodationNeeds1Controller.text.toString());
                          String roomperfance =
                              accommodationNeeds2Controller.text.toString();
                          String additionalInformation =
                              additionalFieldController.text.toString();
                          // hotel create method
                          tabsViewModel.ticketCreateMethod(
                              id: widget.userId.toString(),
                              context: context,
                              firstname: firstname,
                              email: email1,
                              contactid: getContact.toString(),
                              mobile: mobile,
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
                              userId: getContact.toString(),
                              numberroom: numberroom,
                              roomperfance: roomperfance,
                              additionalInformation: additionalInformation);
                          // field clear
                          checkInDateController.clear();
                          checkOutController.clear();
                          stateController.clear();
                          cityController.clear();
                          countryController.clear();
                          addreesController.clear();
                          hotelNameController.clear();
                          accommodationNeeds1Controller.clear();
                          accommodationNeeds2Controller.clear();
                          adultNumberController.clear();
                          kidController.clear();
                          mealController.clear();
                          budgetController.clear();
                          additionalFieldController.clear();
                        } else {
                          Utils.errorMessageFlush(
                              "Please Fill All Required Fields", context);
                        }
                      },
                      title: "Submit"),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
    );
  }
}
