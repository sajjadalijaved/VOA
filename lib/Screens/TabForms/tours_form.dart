import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../modals/contact_id_model.dart';
import '../../database/datamodel_provider.dart';
import '../../view_model/error_controll_view_model.dart';
import 'package:vacation_ownership_advisor/Utils/utils.dart';
import 'package:vacation_ownership_advisor/modals/data_model.dart';
import '../../view_model/textformfield_change_color_view_model.dart';
import 'package:vacation_ownership_advisor/Widgets/custombutton.dart';
import 'package:vacation_ownership_advisor/Widgets/customtextfield.dart';
import 'package:vacation_ownership_advisor/view_model/tabs_view_model.dart';
import 'package:vacation_ownership_advisor/Utils/Validation/validation.dart';

// ignore_for_file: must_be_immutable

// ignore_for_file: unnecessary_null_comparison

class ToursFormScreen extends StatefulWidget {
  dynamic userId;

  ToursFormScreen({
    super.key,
    this.userId,
  });

  @override
  State<ToursFormScreen> createState() => _ToursFormScreenState();
}

class _ToursFormScreenState extends State<ToursFormScreen> {
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

  DateTime? _startingDate;
  DateTime? _endingDate;

  late TextEditingController typeofToursController;
  late TextEditingController durationofTourController;
  late TextEditingController nameofTourController;
  late TextEditingController startingDateController;
  late TextEditingController endingDateController;
  late TextEditingController numberofPeopleController;
  late TextEditingController destinationofTourController;
  late TextEditingController preferredItineraryController;
  late TextEditingController budgetController;
  late TextEditingController additionalFieldController;

  // focus node
  late FocusNode endDateFocusNode;
  late FocusNode startDateFocusNode;
  late FocusNode peopleFocusNode;

  // global keys
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> typeTourFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> durationTourFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> nameTourFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> startedDateFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> endingDateFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> preferedItineraryFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> budgetFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> numberPeopleFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> destinationTourFieldKey =
      GlobalKey<FormFieldState>();

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

  Future<void> startDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startingDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _startingDate) {
        setState(() {
          _startingDate = picked;
          startingDateController.text =
              "${_startingDate!.toLocal()}".split(' ')[0];
          log("StartDate:${startingDateController.text.toString()}");
        });
      }
    } catch (e) {
      log("StartDate Error:$e");
    }
  }

  Future<void> endingDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _startingDate!,
        firstDate: _startingDate!,
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _endingDate) {
        setState(() {
          _endingDate = picked;
          endingDateController.text = "${_endingDate!.toLocal()}".split(' ')[0];
          log("EndingDate:${endingDateController.text.toString()}");
        });
      }
    } catch (e) {
      log("EndingDate Error:$e");
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
          log("contactIdFetch in tour : $getContact");
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

    typeofToursController = TextEditingController();
    durationofTourController = TextEditingController();
    nameofTourController = TextEditingController();
    startingDateController = TextEditingController();
    endingDateController = TextEditingController();
    numberofPeopleController = TextEditingController();
    destinationofTourController = TextEditingController();
    preferredItineraryController = TextEditingController();
    budgetController = TextEditingController();
    additionalFieldController = TextEditingController();
    //focus node
    endDateFocusNode = FocusNode();
    startDateFocusNode = FocusNode();
    peopleFocusNode = FocusNode();

    fetch().whenComplete(() async {
      await fetchContactId();
    });
  }

  @override
  void dispose() {
    typeofToursController.dispose();
    durationofTourController.dispose();
    nameofTourController.dispose();
    startingDateController.dispose();
    endingDateController.dispose();
    numberofPeopleController.dispose();
    destinationofTourController.dispose();
    preferredItineraryController.dispose();
    budgetController.dispose();
    additionalFieldController.dispose();
    // focus node
    endDateFocusNode.dispose();
    startDateFocusNode.dispose();
    peopleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("user_id in Tour Screen:${widget.userId}");

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
                    "Type Of Tour",
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
                    controller: typeofToursController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validateTypeTours(value);
                    },
                    hintText: "Enter Type Of Tour",
                    fieldValidationkey: typeTourFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Duration Of Tour",
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
                    controller: durationofTourController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    inputparameter: [FilteringTextInputFormatter.digitsOnly],
                    validate: (value) {
                      return FieldValidator.validateDurationTour(value);
                    },
                    onChanged: (value) {
                      durationTourFieldKey.currentState!.validate();
                    },
                    hintText: "Enter Days Of Tour",
                    fieldValidationkey: durationTourFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Name Of Tour",
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
                    controller: nameofTourController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validateNameTour(value);
                    },
                    hintText: "Enter Name Of Tour",
                    fieldValidationkey: nameTourFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Starting Date Of Tour",
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
                      boderColor: value.startDateFieldColor,
                      onTap: () {
                        value.setStartDateFieldColor(const Color(0xff0092ff));
                        value.setEndingDateFieldColor(Colors.black26);

                        startDateMethod(context);
                      },
                      controller: startingDateController,
                      focusNode: startDateFocusNode,
                      inputparameter: [DateInputFormatter()],
                      validate: (value) {
                        return FieldValidator.validateDate(value);
                      },
                      sufixIcon: Icon(
                        Icons.calendar_today_sharp,
                        color: value.startDateFieldColor,
                      ),
                      hintText: "Enter Starting Date Of Tour",
                      readonly: true,
                      fieldValidationkey: startedDateFieldKey),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Ending Date Of Tour",
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
                        boderColor: value.endingDateFieldColor,
                        onTap: () {
                          value
                              .setEndingDateFieldColor(const Color(0xff0092ff));
                          value.setStartDateFieldColor(Colors.black26);
                          if (_startingDate == null) {
                            errorModelClass
                                .setErrorTourText("First Fill Starting Date");
                          } else {
                            errorModelClass.setErrorTourText("");
                          }

                          endingDateMethod(context);
                        },
                        controller: endingDateController,
                        focusNode: endDateFocusNode,
                        readonly: true,
                        errorText: errorModelClass.errorTourText.isNotEmpty
                            ? errorModelClass.errorTourText
                            : null,
                        sufixIcon: Icon(
                          Icons.calendar_today_sharp,
                          color: value.endingDateFieldColor,
                        ),
                        inputparameter: [DateInputFormatter()],
                        validate: (value) {
                          return FieldValidator.validateDate(value);
                        },
                        hintText: "Enter Ending Date Of Tour",
                        fieldValidationkey: endingDateFieldKey),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Number Of People",
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
                          .setEndingDateFieldColor(Colors.black26);
                    },
                    boderColor: const Color(0xff0092ff),
                    controller: numberofPeopleController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    focusNode: peopleFocusNode,
                    inputparameter: [FilteringTextInputFormatter.digitsOnly],
                    validate: (value) {
                      return FieldValidator.validateNumberPeople(value);
                    },
                    hintText: "Enter Number Of Peolpe",
                    onChanged: (value) {
                      numberPeopleFieldKey.currentState!.validate();
                    },
                    fieldValidationkey: numberPeopleFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Location Of Tour",
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
                    controller: destinationofTourController,
                    inputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    textInputType: TextInputType.name,
                    validate: (value) {
                      return FieldValidator.validateDestinationTour(value);
                    },
                    hintText: "Enter Location Of Tour",
                    fieldValidationkey: destinationTourFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Preferred Itinerary",
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
                    controller: preferredItineraryController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validatePreferdItinerary(value);
                    },
                    hintText: "Enter Preferred Itinerary ",
                    fieldValidationkey: preferedItineraryFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Budget Of Tour",
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
                    controller: budgetController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "Budget cannot be empty.";
                      } else if (!RegExp(r'^[0-9\$]*$').hasMatch(value)) {
                        return "Invalid input:Only digits and \$ sign are allowed.";
                      } else {
                        return FieldValidator.validateBudgetPerNight(value);
                      }
                    },
                    onChanged: (String value) {
                      budgetFieldKey.currentState!.validate();
                    },
                    hintText: "\$",
                    fieldValidationkey: budgetFieldKey),
                const SizedBox(
                  height: 6,
                ),
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
                      loading: tabsViewModel.tourloading,
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      press: () async {
                        FocusScope.of(context).unfocus();
                        if (key.currentState!.validate() &&
                            typeTourFieldKey.currentState!.validate() &&
                            durationTourFieldKey.currentState!.validate() &&
                            nameTourFieldKey.currentState!.validate() &&
                            startedDateFieldKey.currentState!.validate() &&
                            endingDateFieldKey.currentState!.validate() &&
                            numberPeopleFieldKey.currentState!.validate() &&
                            destinationTourFieldKey.currentState!.validate() &&
                            preferedItineraryFieldKey.currentState!
                                .validate() &&
                            budgetFieldKey.currentState!.validate()) {
                          String firstname = firstName.toString();
                          String email1 = email.toString();
                          String mobile = phoneNumber.toString();
                          String typeofTour =
                              typeofToursController.text.trim().toString();
                          String durationofTour =
                              durationofTourController.text.trim().toString();
                          String nameofTour =
                              nameofTourController.text.trim().toString();
                          String statDate =
                              startingDateController.text.trim().toString();
                          String endDate =
                              endingDateController.text.trim().toString();
                          String numberofpeople =
                              numberofPeopleController.text.trim().toString();
                          String destinationTour =
                              destinationofTourController.text.toString();
                          String preferredItinerary =
                              preferredItineraryController.text.toString();
                          String budget = budgetController.text.toString();

                          String additionalInformation =
                              additionalFieldController.text.toString();

                          await tabsViewModel.toursMethod(
                              id: widget.userId.toString(),
                              context: context,
                              firstname: firstname,
                              email: email1,
                              contactid: getContact.toString(),
                              mobile: mobile,
                              typeTour: typeofTour,
                              startDate: statDate,
                              endingDate: endDate,
                              preferredItinerary: preferredItinerary,
                              durationTour: durationofTour,
                              nameTour: nameofTour,
                              numberPeople: numberofpeople,
                              destinationTour: destinationTour,
                              budgetTour: budget,
                              userId: getContact.toString(),
                              additionalInformation: additionalInformation);

                          // controler clear
                          typeofToursController.clear();
                          durationofTourController.clear();
                          nameofTourController.clear();
                          startingDateController.clear();
                          endingDateController.clear();
                          numberofPeopleController.clear();
                          destinationofTourController.clear();
                          preferredItineraryController.clear();
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
