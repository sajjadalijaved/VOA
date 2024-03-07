import 'dart:developer';
import '../../Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../modals/contact_id_model.dart';
import '../../database/datamodel_provider.dart';
import '../../view_model/error_controll_view_model.dart';
import 'package:vacation_ownership_advisor/modals/data_model.dart';
import '../../view_model/textformfield_change_color_view_model.dart';
import 'package:vacation_ownership_advisor/Widgets/custombutton.dart';
import 'package:vacation_ownership_advisor/Widgets/customtextfield.dart';
import 'package:vacation_ownership_advisor/view_model/tabs_view_model.dart';
import 'package:vacation_ownership_advisor/Utils/Validation/validation.dart';
import 'package:vacation_ownership_advisor/view_model/drop_down_view_model.dart';

// ignore_for_file: must_be_immutable

// ignore_for_file: unnecessary_null_comparison

class CruiseFormScreen extends StatefulWidget {
  dynamic userId;

  CruiseFormScreen({
    super.key,
    this.userId,
  });

  @override
  State<CruiseFormScreen> createState() => _CruiseFormScreenState();
}

class _CruiseFormScreenState extends State<CruiseFormScreen> {
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

  DateTime? _saillingDate;
  DateTime? _returnDate;

  late TextEditingController saillingDateController;
  late TextEditingController returnDateController;

  late TextEditingController destinationController;
  late TextEditingController lenthCruiseController;
  late TextEditingController cruiseLinePreferredController;
  late TextEditingController shipNameController;
  late TextEditingController departurePortController;
  late TextEditingController cabinTypeController;
  late TextEditingController numberOfCabinController;
  late TextEditingController withOrWithoutController;
  late TextEditingController gratuityController;
  late TextEditingController numberOfPassengersController;
  late TextEditingController passengersAgeController;
  late TextEditingController additionalFieldController;

  // focus node
  late FocusNode returnDateFocusNode;
  late FocusNode sailingDateFocusNode;
  late FocusNode lenthFocusNode;

  // global keys
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> saillingDateFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> returnDateFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> typeOfCruiseFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> destinationFieldKey =
      GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> lenthOfCruiseFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> cruiseLineFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> shipNameFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> depatureFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> cabinTypeFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> numberOfCabinFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> withOrwithOutFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> gratuityFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> numberOfPassangersFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passangerAgeFieldKey =
      GlobalKey<FormFieldState>();

  // fetch data from database
  Future fetch() async {
    var models = await dataModelProvider.fetchData();
    if (mounted) {
      if (models != null) {
        setState(() {
          this.models = models;
          latestData = models.isNotEmpty ? models.last : null;
          if (latestData != null) {
            firstName = latestData!.firstName.toString();
            log("name : $firstName");
            phoneNumber = latestData!.phoneNumber.toString();
            log("phone : $phoneNumber");
            email = latestData!.email.toString();
            log("email : $email");
          }
        });
      } else {
        setState(() {
          this.models = [];
        });
      }
    }
  }

  List dropDownListData = [
    {"title": "River Cruise", "value": "River Cruise"},
    {"title": "Ocean", "value": "Ocean"},
  ];

  Future<void> sailingDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _saillingDate ?? DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: _returnDate == null ? DateTime.now() : _returnDate!,
      );
      if (picked != null && picked != _saillingDate) {
        setState(() {
          _saillingDate = picked;
          saillingDateController.text =
              "${_saillingDate!.toLocal()}".split(' ')[0];
          log("sailingDate:${saillingDateController.text.toString()}");
        });
      }
    } catch (e) {
      log("sailingDate Eroor:$e");
    }
  }

  Future<void> returnDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _returnDate ?? DateTime.now(),
        firstDate: DateTime.parse(saillingDateController.text),
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _returnDate) {
        setState(() {
          _returnDate = picked;
          returnDateController.text = "${_returnDate!.toLocal()}".split(' ')[0];
          log("returnDate :${returnDateController.text.toString()}");
        });
      }
    } catch (e) {
      log('Error returing date: $e');
    }
  }

  // fetch Contactid from database
  Future fetchContactId() async {
    var contactDataModels = await dataModelProvider.fetchContactIdMethod();
    if (mounted) {
      if (contactDataModels != null) {
        setState(() {
          this.contactDataModels = contactDataModels;
          latestContactIdData =
              contactDataModels.isNotEmpty ? contactDataModels.last : null;

          if (latestContactIdData != null) {
            getContact = latestContactIdData!.contactId.toString();
            log("contactIdFetch in Cruse : $getContact");
            contactUserIdFetch =
                latestContactIdData!.contact_user_Id.toString();
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
  }

  @override
  void initState() {
    super.initState();

    destinationController = TextEditingController();
    saillingDateController = TextEditingController();
    returnDateController = TextEditingController();
    shipNameController = TextEditingController();
    departurePortController = TextEditingController();
    lenthCruiseController = TextEditingController();
    cruiseLinePreferredController = TextEditingController();
    cabinTypeController = TextEditingController();
    numberOfCabinController = TextEditingController();
    withOrWithoutController = TextEditingController();
    gratuityController = TextEditingController();
    numberOfPassengersController = TextEditingController();
    passengersAgeController = TextEditingController();
    additionalFieldController = TextEditingController();
// focus node
    returnDateFocusNode = FocusNode();
    sailingDateFocusNode = FocusNode();
    lenthFocusNode = FocusNode();

    fetch().whenComplete(() async {
      await fetchContactId();
    });
  }

  @override
  void dispose() {
    destinationController.dispose();
    saillingDateController.dispose();
    returnDateController.dispose();
    lenthCruiseController.dispose();
    cruiseLinePreferredController.dispose();
    shipNameController.dispose();
    departurePortController.dispose();
    cabinTypeController.dispose();
    numberOfCabinController.dispose();
    withOrWithoutController.dispose();
    gratuityController.dispose();
    numberOfPassengersController.dispose();
    passengersAgeController.dispose();
    additionalFieldController.dispose();
    // focus node dispose
    returnDateFocusNode.dispose();
    sailingDateFocusNode.dispose();
    lenthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    TabsViewModel tabsViewModel = Provider.of<TabsViewModel>(context);
    ErrorModelClass errorModelClass =
        Provider.of<ErrorModelClass>(context, listen: false);
    DropDownViewModel dropdownViewModel =
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
                    "Type Of Cruise",
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
                        isDense: true,
                        iconSize: 30,
                        key: typeOfCruiseFieldKey,
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
                        value: value.dropdownValue,
                        isExpanded: true,
                        menuMaxHeight: 350,
                        items: [
                          const DropdownMenuItem(
                              value: "",
                              child: Text(
                                "Select Cruise Type",
                              )),
                          ...dropDownListData
                              .map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem(
                                value: e['value'], child: Text(e['title']));
                          }).toList(),
                        ],
                        onChanged: (newValue) {
                          dropdownViewModel.dropDownValueMethod = newValue!;

                          log(dropdownViewModel.dropdownValue);
                        },
                        validator: (value) {
                          return FieldValidator.validateTypeCruise(
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
                    "Destination",
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
                    controller: destinationController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    validate: (value) {
                      return FieldValidator.validateDestination(value);
                    },
                    hintText: "Enter Destination",
                    fieldValidationkey: destinationFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Sailing Date",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<TextFieldColorChangeViewModel>(
                  builder: (context, value, child) => CustomTextField(
                      boderColor: value.sailingDateFieldColor,
                      onTap: () {
                        value.setSailingDateFieldColor(const Color(0xff0092ff));
                        value.setReturnDateFieldColor(Colors.black26);

                        sailingDateMethod(context);
                      },
                      controller: saillingDateController,
                      readonly: true,
                      inputparameter: [DateInputFormatter()],
                      validate: (value) {
                        return FieldValidator.validateDate(value);
                      },
                      sufixIcon: Icon(
                        Icons.calendar_today_sharp,
                        color: value.sailingDateFieldColor,
                      ),
                      focusNode: sailingDateFocusNode,
                      hintText: "Enter Sailing Date",
                      fieldValidationkey: saillingDateFieldKey),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Return Date",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<ErrorModelClass>(
                  builder: (context, value, child) =>
                      Consumer<TextFieldColorChangeViewModel>(
                    builder: (context, value, child) => CustomTextField(
                        boderColor: value.returnDateFieldColor,
                        onTap: () {
                          value.setSailingDateFieldColor(Colors.black26);
                          value
                              .setReturnDateFieldColor(const Color(0xff0092ff));
                          if (_saillingDate == null) {
                            errorModelClass
                                .setErrorCruiseText("First Fill Sailing Date");
                          } else {
                            errorModelClass.setErrorCruiseText("");
                          }

                          returnDateMethod(context);
                        },
                        controller: returnDateController,
                        readonly: true,
                        errorText: errorModelClass.errorCruiseText.isNotEmpty
                            ? errorModelClass.errorCruiseText
                            : null,
                        sufixIcon: Icon(
                          Icons.calendar_today_sharp,
                          color: value.returnDateFieldColor,
                        ),
                        inputparameter: [DateInputFormatter()],
                        validate: (value) {
                          return FieldValidator.validateDate(value);
                        },
                        hintText: "Enter Return Date",
                        focusNode: returnDateFocusNode,
                        fieldValidationkey: returnDateFieldKey),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Length Of Cruise",
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
                      lenthFocusNode.attach(context);
                      textFieldColorChangeViewModel
                          .setReturnDateFieldColor(Colors.black26);
                    },
                    boderColor: const Color(0xff0092ff),
                    controller: lenthCruiseController,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputparameter: [FilteringTextInputFormatter.digitsOnly],
                    validate: (value) {
                      return FieldValidator.validateCruiseLenth(value);
                    },
                    hintText: "Enter Number Of Nights",
                    focusNode: lenthFocusNode,
                    onChanged: (value) {
                      lenthOfCruiseFieldKey.currentState!.validate();
                    },
                    fieldValidationkey: lenthOfCruiseFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Cruise Line Preferred",
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
                    controller: cruiseLinePreferredController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validateCruiseLine(value);
                    },
                    hintText: "Enter Cruise Line Preferred",
                    fieldValidationkey: cruiseLineFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Ship Name",
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
                    controller: shipNameController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    validate: (value) {
                      return FieldValidator.validateShipName(value);
                    },
                    hintText: "Enter Ship Name",
                    fieldValidationkey: shipNameFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05, top: size.height * 0.01),
                  child: const Text(
                    "Departure Port",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05, vertical: 5),
                  child: TextFormField(
                    key: depatureFieldKey,
                    validator: (value) {
                      return FieldValidator.validateDepaturePort(
                          value.toString());
                    },
                    controller: departurePortController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Enter Departure Port",
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
                    "Cabin Type",
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
                    controller: cabinTypeController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    validate: (value) {
                      return FieldValidator.validateCabinType(value);
                    },
                    hintText: "Enter Cabin Type",
                    fieldValidationkey: cabinTypeFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Number of Cabin",
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
                    controller: numberOfCabinController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputparameter: [FilteringTextInputFormatter.digitsOnly],
                    validate: (value) {
                      return FieldValidator.validateCabinNumber(value);
                    },
                    onChanged: (value) {
                      numberOfCabinFieldKey.currentState!.validate();
                    },
                    hintText: "Enter Number Cabin",
                    fieldValidationkey: numberOfCabinFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "With/WithOut (Free At Sea)",
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
                    controller: withOrWithoutController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validateWith(value);
                    },
                    hintText: "e.g, Bervage, Dinig, Wifi & Excursion ",
                    fieldValidationkey: withOrwithOutFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Gratuity",
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
                    controller: gratuityController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    validate: (value) {
                      return FieldValidator.validateGratuity(value);
                    },
                    hintText: "Enter Gratuity",
                    fieldValidationkey: gratuityFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Number Of Passangers",
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
                    controller: numberOfPassengersController,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputparameter: [FilteringTextInputFormatter.digitsOnly],
                    validate: (value) {
                      return FieldValidator.validatePassangerNumber(value);
                    },
                    hintText: "Enter Number Of Passangers",
                    onChanged: (value) {
                      numberOfPassangersFieldKey.currentState!.validate();
                    },
                    fieldValidationkey: numberOfPassangersFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Passanger's Age",
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
                    controller: passengersAgeController,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputparameter: [FilteringTextInputFormatter.digitsOnly],
                    validate: (value) {
                      return FieldValidator.validatePassangerAge(value);
                    },
                    hintText: "Enter Passanger's Age",
                    onChanged: (value) {
                      passangerAgeFieldKey.currentState!.validate();
                    },
                    fieldValidationkey: passangerAgeFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                  ),
                  child: const Text(
                    "Additional Information (Optional)",
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
                      loading: tabsViewModel.cruiseloading,
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      press: () async {
                        FocusScope.of(context).unfocus();
                        if (key.currentState!.validate() &&
                            typeOfCruiseFieldKey.currentState!.validate() &&
                            depatureFieldKey.currentState!.validate() &&
                            saillingDateFieldKey.currentState!.validate() &&
                            returnDateFieldKey.currentState!.validate() &&
                            shipNameFieldKey.currentState!.validate() &&
                            lenthOfCruiseFieldKey.currentState!.validate() &&
                            cruiseLineFieldKey.currentState!.validate() &&
                            depatureFieldKey.currentState!.validate() &&
                            cabinTypeFieldKey.currentState!.validate() &&
                            numberOfCabinFieldKey.currentState!.validate() &&
                            withOrwithOutFieldKey.currentState!.validate() &&
                            numberOfPassangersFieldKey.currentState!
                                .validate() &&
                            passangerAgeFieldKey.currentState!.validate()) {
                          String firstname = firstName.toString();
                          String email1 = email.toString();
                          String mobile = phoneNumber.toString();
                          String cabinType =
                              cabinTypeController.text.toString();
                          String sailingDate =
                              saillingDateController.text.toString();
                          String returnDate =
                              returnDateController.text.toString();
                          String destination =
                              destinationController.text.toString();
                          String lenthCruise =
                              lenthCruiseController.text.toString();
                          String cruiseLine =
                              cruiseLinePreferredController.text.toString();
                          String shipName = shipNameController.text.toString();
                          String departurePort =
                              departurePortController.text.toString();

                          String numberCabin =
                              numberOfCabinController.text.toString();
                          String withOrwithout =
                              withOrWithoutController.text.toString();

                          String numberPassanger =
                              numberOfPassengersController.text.toString();
                          String agePassanger =
                              passengersAgeController.text.toString();
                          String gratuity = gratuityController.text.toString();
                          String additionalInformation =
                              additionalFieldController.text.toString();
                          // cruise method call

                          await tabsViewModel.cruiseMethod(
                              context: context,
                              id: widget.userId.toString(),
                              userId: getContact.toString(),
                              contactid: getContact.toString(),
                              firstname: firstname,
                              email: email1,
                              mobile: mobile,
                              typeCruise: dropdownViewModel.dropdownValue,
                              destinationCruise: destination,
                              sailingDate: sailingDate,
                              returnDate: returnDate,
                              lengthCruise: lenthCruise,
                              cruiseLinePreferred: cruiseLine,
                              shipName: shipName,
                              departurePort: departurePort,
                              cabinType: cabinType,
                              numberCabin: numberCabin,
                              withOrwithout: withOrwithout,
                              gratuity: gratuity,
                              numberPassangers: numberPassanger,
                              passangerAge: agePassanger,
                              additionalInformation: additionalInformation);

                          // clear text fields
                          dropdownViewModel.dropDownValueMethod = '';
                          destinationController.clear();
                          saillingDateController.clear();
                          returnDateController.clear();
                          lenthCruiseController.clear();
                          cruiseLinePreferredController.clear();
                          shipNameController.clear();
                          departurePortController.clear();
                          withOrWithoutController.clear();
                          cabinTypeController.clear();
                          numberOfCabinController.clear();
                          passengersAgeController.clear();
                          numberOfPassengersController.clear();
                          gratuityController.clear();
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
