import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../database/datamodel_provider.dart';
import '../../view_model/services/splash_services.dart';
import '../../view_model/error_controll_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacation_ownership_advisor/Utils/utils.dart';
import 'package:vacation_ownership_advisor/modals/data_model.dart';
import 'package:vacation_ownership_advisor/Widgets/custombutton.dart';
import 'package:vacation_ownership_advisor/Widgets/customtextfield.dart';
import 'package:vacation_ownership_advisor/view_model/tabs_view_model.dart';
import 'package:vacation_ownership_advisor/Utils/Validation/validation.dart';
import 'package:vacation_ownership_advisor/view_model/drop_down_view_model.dart';
import 'package:vacation_ownership_advisor/view_model/textformfield_change_color_view_model.dart';

// ignore_for_file: must_be_immutable

// ignore_for_file: unnecessary_null_comparison

class AirFairFormScreen extends StatefulWidget {
  dynamic userId;

  AirFairFormScreen({
    super.key,
    this.userId,
  });

  @override
  State<AirFairFormScreen> createState() => _AirFairFormScreenState();
}

class _AirFairFormScreenState extends State<AirFairFormScreen> {
  String? firstName;
  String? phoneNumber;
  String? email;
  late String getContact;

  DateTime? _fromDate;
  DateTime? _toDate;

  List<DataModel>? models;
  DataModelProvider dataModelProvider = DataModelProvider();
  SplashServices splashServices = SplashServices();
  DataModel? latestData;

  late TextEditingController fromLocationController;
  late TextEditingController fromDateController;
  late TextEditingController toLocationController;
  late TextEditingController toDateController;
  late TextEditingController numberofTravellersController;
  late TextEditingController preferredAirlineController;
  late TextEditingController prefeeredServicesController;
  late TextEditingController additionalFieldController;

  // focus node
  late FocusNode fromDate;
  late FocusNode toDate;
  late FocusNode toLocation;
  late FocusNode travellersDate;

  // global keys
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> fromDateFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> fromLocationFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> toLocationFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> toDateFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> preferedAirlineFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> preferredServiceFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> numberTravellersFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> dropDownFieldKey =
      GlobalKey<FormFieldState>();

  // fetch data from database
  Future fetch() async {
    var models = await dataModelProvider.fetchData();
    if (models != null) {
      log("Fetch method in hostel screen");
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

  Future<void> fromDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _fromDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _fromDate) {
        setState(() {
          _fromDate = picked;
          fromDateController.text = "${_fromDate!.toLocal()}".split(' ')[0];
          log("FromDate:${fromDateController.text.toString()}");
        });
      }
    } catch (e) {
      log("FromDate Error:$e");
    }
  }

  Future<void> toDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _toDate ?? _fromDate,
        firstDate: _fromDate!,
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _toDate) {
        setState(() {
          _toDate = picked;
          toDateController.text = "${_toDate!.toLocal()}".split(' ')[0];
          log("toDate:${toDateController.text.toString()}");
        });
      }
    } catch (e) {
      log("toDate:$e");
    }
  }

  // contactId get through sharePreferences
  Future<String> contactIdRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('contactId') ?? '';

    return id;
  }

  List dropDownListData = [
    {"title": "Round", "value": "Round"},
    {"title": "One Way", "value": "One Way"},
  ];

  @override
  void initState() {
    super.initState();

    fromLocationController = TextEditingController();
    fromDateController = TextEditingController();
    toLocationController = TextEditingController();
    toDateController = TextEditingController();
    numberofTravellersController = TextEditingController();
    preferredAirlineController = TextEditingController();
    prefeeredServicesController = TextEditingController();
    additionalFieldController = TextEditingController();

    // focus node
    fromDate = FocusNode();
    toDate = FocusNode();
    toLocation = FocusNode();
    travellersDate = FocusNode();

    if (widget.userId == null || widget.userId.isEmpty) {
      splashServices.updateDataToDataBase(context).whenComplete(() {
        fetch();
      }).whenComplete(() async {
        getContact = await contactIdRetriever();
        log("Get Contact Id From ContactRetriver Method Flights Screen: $getContact");
      });
    } else {
      splashServices.sendUserDataToDataBase(context).whenComplete(() {
        fetch();
      }).whenComplete(() async {
        getContact = await contactIdRetriever();
        log("Get Contact Id From ContactRetriver Method Flights Screen: $getContact");
      });
    }
  }

  @override
  void dispose() {
    fromLocationController.dispose();
    fromDateController.dispose();
    toLocationController.dispose();
    toDateController.dispose();
    numberofTravellersController.dispose();
    preferredAirlineController.dispose();
    prefeeredServicesController.dispose();
    additionalFieldController.dispose();

    // focus node
    fromDate.dispose();
    toDate.dispose();
    toLocation.dispose();
    travellersDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    TabsViewModel tabsViewModel = Provider.of<TabsViewModel>(context);
    ErrorModelClass errorModelClass =
        Provider.of<ErrorModelClass>(context, listen: false);
    DropDownViewModel dropDownViewModel =
        Provider.of<DropDownViewModel>(context, listen: false);
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
                    "Type (Round/One Way)",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<DropDownViewModel>(
                  builder: (context, value, child) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: DropdownButtonFormField<String>(
                        key: dropDownFieldKey,
                        isDense: true,
                        iconSize: 30,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
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
                          filled: true,
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        value: value.dropdownValueFlights,
                        isExpanded: true,
                        menuMaxHeight: 350,
                        items: [
                          const DropdownMenuItem(
                              value: "",
                              child: Text(
                                "Select Your Way",
                              )),
                          ...dropDownListData
                              .map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem(
                                value: e['value'], child: Text(e['title']));
                          }).toList(),
                        ],
                        onChanged: (newValue) {
                          value.dropDownValueFlightsMethod = newValue!;

                          log(value.dropdownValueFlights);
                        },
                        validator: (value) {
                          return FieldValidator.validateDropDown(
                              value.toString());
                        }),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "From",
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
                            paddingLeft: size.width * 0.05,
                            paddingRight: size.width * 0.01,
                            controller: fromLocationController,
                            validate: (value) {
                              return FieldValidator.validateLocation(value);
                            },
                            textCapitalization: TextCapitalization.words,
                            textInputType: TextInputType.streetAddress,
                            inputAction: TextInputAction.next,
                            hintText: "Airport Location",
                            fieldValidationkey: fromLocationFieldKey),
                      ),
                      Consumer<TextFieldColorChangeViewModel>(
                        builder: (context, value, child) => Expanded(
                          child: CustomTextField(
                              boderColor: value.fromDateColor,
                              onTap: () {
                                value.setToDateFieldColor(Colors.black26);
                                value.setFromDateFieldColor(
                                    const Color(0xff0092ff));

                                fromDateMethod(context);
                              },
                              paddingLeft: size.width * 0.01,
                              controller: fromDateController,
                              sufixIcon: Icon(
                                Icons.calendar_today_sharp,
                                color: value.fromDateColor,
                              ),
                              inputparameter: [DateInputFormatter()],
                              validate: (value) {
                                return FieldValidator.validateDate(value);
                              },
                              hintText: "From Date",
                              focusNode: fromDate,
                              readonly: true,
                              fieldValidationkey: fromDateFieldKey),
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
                    "To",
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
                                  .setFromDateFieldColor(Colors.black26);
                            },
                            boderColor: const Color(0xff0092ff),
                            paddingRight: size.width * 0.01,
                            controller: toLocationController,
                            inputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            textInputType: TextInputType.streetAddress,
                            validate: (value) {
                              return FieldValidator.validateLocation(value);
                            },
                            hintText: "Airport Location",
                            focusNode: toLocation,
                            fieldValidationkey: toLocationFieldKey),
                      ),
                      Consumer<ErrorModelClass>(
                        builder: (context, value, child) =>
                            Consumer<TextFieldColorChangeViewModel>(
                          builder: (context, value, child) => Expanded(
                            child: CustomTextField(
                                boderColor: value.toFieldColor,
                                onTap: () {
                                  value.setFromDateFieldColor(Colors.black26);
                                  value.setToDateFieldColor(
                                      const Color(0xff0092ff));
                                  if (_fromDate == null) {
                                    errorModelClass.setErrorFlightsText(
                                        "First Fill From Date");
                                  } else {
                                    errorModelClass.setErrorFlightsText("");
                                  }

                                  toDateMethod(context);
                                },
                                controller: toDateController,
                                errorText:
                                    errorModelClass.errorFlightsText.isNotEmpty
                                        ? errorModelClass.errorFlightsText
                                        : null,
                                paddingLeft: size.width * 0.01,
                                inputparameter: [DateInputFormatter()],
                                sufixIcon: Icon(
                                  Icons.calendar_today_sharp,
                                  color: value.toFieldColor,
                                ),
                                validate: (value) {
                                  return FieldValidator.validateDate(value);
                                },
                                hintText: "To Date",
                                focusNode: toDate,
                                readonly: true,
                                fieldValidationkey: toDateFieldKey),
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
                    "Number Of Travellers",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    onTap: () {
                      textFieldColorChangeViewModel
                          .setToDateFieldColor(Colors.black26);
                    },
                    boderColor: const Color(0xff0092ff),
                    controller: numberofTravellersController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputparameter: [FilteringTextInputFormatter.digitsOnly],
                    validate: (value) {
                      return FieldValidator.validateNumberTravellers(value);
                    },
                    hintText: "Enter Number Of Travellers ",
                    focusNode: travellersDate,
                    onChanged: (value) {
                      numberTravellersFieldKey.currentState!.validate();
                    },
                    fieldValidationkey: numberTravellersFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Preferred Airline",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    boderColor: const Color(0xff0092ff),
                    controller: preferredAirlineController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validateAirlinPrefeered(value);
                    },
                    hintText: "Enter Preferred Airline",
                    fieldValidationkey: preferedAirlineFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Preferred Class Of Services",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                    boderColor: const Color(0xff0092ff),
                    controller: prefeeredServicesController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validatePreferdService(value);
                    },
                    hintText: "Enter Preferred Class Of Services ",
                    fieldValidationkey: preferredServiceFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                  ),
                  child: const Text(
                    "Additional Information (optional)",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5,
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
                      loading: tabsViewModel.airFairloading,
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      press: () async {
                        FocusScope.of(context).unfocus();
                        if (key.currentState!.validate() &&
                            dropDownFieldKey.currentState!.validate() &&
                            fromDateFieldKey.currentState!.validate() &&
                            fromLocationFieldKey.currentState!.validate() &&
                            toDateFieldKey.currentState!.validate() &&
                            toLocationFieldKey.currentState!.validate() &&
                            numberTravellersFieldKey.currentState!.validate() &&
                            preferedAirlineFieldKey.currentState!.validate() &&
                            preferredServiceFieldKey.currentState!.validate()) {
                          String firstname = firstName.toString();
                          String email1 = email.toString();
                          String mobile = phoneNumber.toString();

                          String fromDate =
                              fromDateController.text.trim().toString();
                          String fromlocation =
                              fromLocationController.text.trim().toString();
                          String toLocation =
                              toLocationController.text.trim().toString();
                          String toDate =
                              toDateController.text.trim().toString();
                          String preferredAirline =
                              preferredAirlineController.text.trim().toString();
                          String numberTravellers =
                              numberofTravellersController.text.toString();
                          String preferedServices =
                              prefeeredServicesController.text.toString();

                          String additionalInformation =
                              additionalFieldController.text.toString();

                          await tabsViewModel.airFairMethod(
                              id: widget.userId.toString(),
                              context: context,
                              firstname: firstname,
                              contactid: getContact.toString(),
                              email: email1,
                              mobile: mobile,
                              type: dropDownViewModel.dropdownValueFlights,
                              toDate: toDate,
                              fromDate: fromDate,
                              preferredAirline: preferredAirline,
                              fromLocation: fromlocation,
                              toLocation: toLocation,
                              preferredServices: preferedServices,
                              numberOfTravellers: numberTravellers,
                              userId: getContact.toString(),
                              additionalInformation: additionalInformation);
                          dropDownViewModel.dropDownValueFlightsMethod = '';
                          fromLocationController.clear();
                          toLocationController.clear();
                          fromDateController.clear();
                          toDateController.clear();
                          numberofTravellersController.clear();
                          preferredAirlineController.clear();
                          prefeeredServicesController.clear();

                          additionalFieldController.clear();
                        } else {
                          Utils.errorMessageFlush(
                              "Please fill all required fields", context);
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
