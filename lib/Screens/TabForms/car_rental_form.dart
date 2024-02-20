import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import '../../Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../database/datamodel_provider.dart';
import '../../view_model/services/splash_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacation_ownership_advisor/modals/data_model.dart';
import 'package:vacation_ownership_advisor/Widgets/custombutton.dart';
import 'package:vacation_ownership_advisor/Widgets/customtextfield.dart';
import 'package:vacation_ownership_advisor/view_model/tabs_view_model.dart';
import 'package:vacation_ownership_advisor/Utils/Validation/validation.dart';
import 'package:vacation_ownership_advisor/repository/tab_bar_screens_auth.dart';
import 'package:vacation_ownership_advisor/view_model/error_controll_view_model.dart';
import 'package:vacation_ownership_advisor/view_model/textformfield_change_color_view_model.dart';

// ignore_for_file: must_be_immutable

// ignore_for_file: unnecessary_null_comparison

class CarRentalFormScreen extends StatefulWidget {
  dynamic userId;
  CarRentalFormScreen({super.key, this.userId});

  @override
  State<CarRentalFormScreen> createState() => _CarRentalFormScreenState();
}

class _CarRentalFormScreenState extends State<CarRentalFormScreen> {
  String? firstName;
  String? phoneNumber;
  String? email;
  String? id;

  String? getContact;
  String? getContactCreatId;

  DateTime? _pickDate;
  DateTime? _dropDate;

  List<DataModel>? models;
  DataModelProvider dataModelProvider = DataModelProvider();
  SplashServices splashServices = SplashServices();
  TabsScreenAuth tabsScreenAuth = TabsScreenAuth();
  DataModel? latestData;

  TimeOfDay? pickTime;
  TimeOfDay? dropTime;

  late TextEditingController pickLocationController;
  late TextEditingController pickDateController;
  late TextEditingController pickTimeController;
  late TextEditingController dropLocationController;
  late TextEditingController dropDateController;
  late TextEditingController dropTimeController;
  late TextEditingController typeCarController;
  late TextEditingController preferedCompanyController;
  late TextEditingController budgetController;
  late TextEditingController additionalFieldController;

  // focus node
  late FocusNode pickUpDate;
  late FocusNode dropOffDate;
  late FocusNode pickUpTime;
  late FocusNode dropOffTime;

  // global keys
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> pickDateFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> dropDateFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> pickLocationFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> dropLocationFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> typeCarFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> preferedCompanyFieldKey =
      GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> pickTimeFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> dropTimeFieldKey =
      GlobalKey<FormFieldState>();

// contactId get through sharePreferences
  contactIdRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getContactCreatId = prefs.getString('contactId') ?? '';

    log("Get getContactCreatId in carRentalScreen: $getContactCreatId");
  }

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
        id = latestData!.user_id.toString();
        log("name : $id");

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

  Future<void> pickUpDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _pickDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _pickDate) {
        setState(() {
          _pickDate = picked;
          pickDateController.text = "${_pickDate!.toLocal()}".split(' ')[0];
          log("pickDate:${pickDateController.text.toString()}");
        });
      }
    } catch (e) {
      log("pickDate Error:$e");
    }
  }

  Future<void> dropDateMethod(BuildContext context) async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _pickDate,
        firstDate: _pickDate!,
        lastDate: DateTime(3000),
      );
      if (picked != null && picked != _dropDate) {
        setState(() {
          _dropDate = picked;
          dropDateController.text = "${_dropDate!.toLocal()}".split(' ')[0];
          log("dropDate:${dropDateController.text.toString()}");
        });
      }
    } catch (e) {
      log("dropDate Error:$e");
    }
  }

  Future<void> pickTimeMethod(BuildContext context) async {
    try {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null && pickedTime != pickTime) {
        setState(() {
          pickTime = pickedTime;
          pickTimeController.text = pickTime!.format(context).toString();
          log("pickTime:${pickTimeController.text.toString()}");
        });
      }
    } catch (e) {
      log("pickTime Eror:$e");
    }
  }

  Future<void> dropTimeMethod(BuildContext context) async {
    TimeOfDay? dropedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (dropedTime != null && dropedTime != dropTime) {
      setState(() {
        dropTime = dropedTime;
        dropTimeController.text = dropTime!.format(context).toString();
        log("DropTime:${dropTimeController.text.toString()}");
      });
    }
  }

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
        getContact = data['data'][0]['id'];

        log("ContactId  : $getContact");
      } else {
        log("response statusCode :${response.statusCode}");
      }
    } catch (e) {
      log("err0r : $e");
    }
  }

  @override
  void initState() {
    super.initState();

    pickLocationController = TextEditingController();
    pickDateController = TextEditingController();
    pickTimeController = TextEditingController();
    dropLocationController = TextEditingController();
    dropDateController = TextEditingController();
    dropTimeController = TextEditingController();
    typeCarController = TextEditingController();
    preferedCompanyController = TextEditingController();
    budgetController = TextEditingController();
    additionalFieldController = TextEditingController();
    // focus node
    pickUpDate = FocusNode();
    dropOffDate = FocusNode();
    pickUpTime = FocusNode();
    dropOffTime = FocusNode();

    if (widget.userId == null || widget.userId.isEmpty) {
      splashServices.updateDataToDataBase(context).whenComplete(() {
        fetch();
      }).whenComplete(() async {
        // accessToken method call
        await tabsScreenAuth.tabsScreensAccessToken();
      }).whenComplete(() async {
        // searchEmail method call
        await getContactIdMethod(email: email!);
      }).whenComplete(() {
        contactIdRetriever();
      });
    } else {
      splashServices.sendUserDataToDataBase(context).whenComplete(() {
        fetch();
      }).whenComplete(() async {
        // accessToken method call
        await tabsScreenAuth.tabsScreensAccessToken();
      }).whenComplete(() async {
        // searchEmail method call
        await getContactIdMethod(email: email!);
      }).whenComplete(() {
        contactIdRetriever();
      });
    }
  }

  @override
  void dispose() {
    pickLocationController.dispose();
    pickDateController.dispose();
    pickTimeController.dispose();
    dropLocationController.dispose();
    dropDateController.dispose();
    dropTimeController.dispose();
    typeCarController.dispose();
    preferedCompanyController.dispose();
    budgetController.dispose();
    additionalFieldController.dispose();
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Pickup Location",
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
                    controller: pickLocationController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    validate: (value) {
                      return FieldValidator.validateLocation(value);
                    },
                    hintText: "Enter Pickup Location",
                    fieldValidationkey: pickLocationFieldKey),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: size.width,
                  child: Row(
                    children: [
                      Consumer<TextFieldColorChangeViewModel>(
                        builder: (context, value, child) => Expanded(
                          child: CustomTextField(
                              boderColor: value.pickDateFieldColor,
                              onTap: () {
                                value.setPickTimeFieldColor(Colors.black26);
                                value.setDropDateFieldColor(Colors.black26);
                                value.setDropTimeFieldColor(Colors.black26);
                                value.setPickDateFieldColor(
                                    const Color(0xff0092ff));
                                if (context != null) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                                pickUpDateMethod(context);
                              },
                              paddingLeft: size.width * 0.05,
                              paddingRight: size.width * 0.01,
                              controller: pickDateController,
                              focusNode: pickUpDate,
                              inputparameter: [DateInputFormatter()],
                              validate: (value) {
                                return FieldValidator.validateDate(value);
                              },
                              sufixIcon: Icon(
                                Icons.calendar_today_sharp,
                                color: value.pickDateFieldColor,
                              ),
                              inputAction: TextInputAction.none,
                              hintText: "Pickup Date",
                              fieldValidationkey: pickDateFieldKey),
                        ),
                      ),
                      Consumer<TextFieldColorChangeViewModel>(
                        builder: (context, value, child) => Expanded(
                          child: CustomTextField(
                              boderColor: value.pickTimeFieldColor,
                              onTap: () {
                                value.setPickDateFieldColor(Colors.black26);
                                value.setDropDateFieldColor(Colors.black26);
                                value.setDropTimeFieldColor(Colors.black26);
                                value.setPickTimeFieldColor(
                                    const Color(0xff0092ff));
                                if (context != null) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                                pickTimeMethod(context);
                              },
                              paddingLeft: size.width * 0.01,
                              controller: pickTimeController,
                              focusNode: pickUpTime,
                              sufixIcon: Icon(
                                Icons.timer,
                                color: value.pickTimeFieldColor,
                              ),
                              validate: (value) {
                                return FieldValidator.validateTime(value);
                              },
                              hintText: "Pickup Time",
                              fieldValidationkey: pickTimeFieldKey),
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
                    "Dropoff Location",
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
                          .setPickTimeFieldColor(Colors.black26);
                      textFieldColorChangeViewModel
                          .setPickDateFieldColor(Colors.black26);
                    },
                    boderColor: const Color(0xff0092ff),
                    controller: dropLocationController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    validate: (value) {
                      return FieldValidator.validateLocation(value);
                    },
                    hintText: "Enter Dropoff Location",
                    fieldValidationkey: dropLocationFieldKey),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: size.width,
                  child: Row(
                    children: [
                      Consumer<ErrorModelClass>(
                        builder: (context, value, child) =>
                            Consumer<TextFieldColorChangeViewModel>(
                          builder: (context, value, child) => Expanded(
                            child: CustomTextField(
                                boderColor: value.dropDateColor,
                                onTap: () {
                                  value.setPickTimeFieldColor(Colors.black26);
                                  value.setPickDateFieldColor(Colors.black26);
                                  value.setDropTimeFieldColor(Colors.black26);
                                  value.setDropDateFieldColor(
                                      const Color(0xff0092ff));
                                  if (_pickDate == null) {
                                    errorModelClass
                                        .setErrorText("First Fill PickUp Date");
                                  } else {
                                    errorModelClass.setErrorText("");
                                  }

                                  if (context != null) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  }
                                  dropDateMethod(context);
                                },
                                paddingRight: size.width * 0.01,
                                controller: dropDateController,
                                focusNode: dropOffDate,
                                errorText: errorModelClass.errorText.isNotEmpty
                                    ? errorModelClass.errorText
                                    : null,
                                inputparameter: [DateInputFormatter()],
                                validate: (value) {
                                  return FieldValidator.validateDate(value);
                                },
                                sufixIcon: Icon(
                                  Icons.calendar_today_sharp,
                                  color: value.dropDateColor,
                                ),
                                hintText: "Drop Date",
                                fieldValidationkey: dropDateFieldKey),
                          ),
                        ),
                      ),
                      Consumer<TextFieldColorChangeViewModel>(
                        builder: (context, value, child) => Expanded(
                          child: CustomTextField(
                              boderColor: value.dropTimeFieldColor,
                              onTap: () {
                                value.setPickTimeFieldColor(Colors.black26);
                                value.setDropDateFieldColor(Colors.black26);
                                value.setPickDateFieldColor(Colors.black26);
                                value.setDropTimeFieldColor(
                                    const Color(0xff0092ff));
                                if (context != null) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                                dropTimeMethod(context);
                              },
                              controller: dropTimeController,
                              paddingLeft: size.width * 0.01,
                              sufixIcon: Icon(
                                Icons.timer,
                                color: value.dropTimeFieldColor,
                              ),
                              validate: (value) {
                                return FieldValidator.validateTime(value);
                              },
                              hintText: "Drop Time",
                              focusNode: dropOffTime,
                              fieldValidationkey: dropTimeFieldKey),
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
                    "Type Of Car",
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
                          .setDropTimeFieldColor(Colors.black26);
                      textFieldColorChangeViewModel
                          .setDropDateFieldColor(Colors.black26);
                    },
                    boderColor: const Color(0xff0092ff),
                    controller: typeCarController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    inputparameter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                    ],
                    validate: (value) {
                      return FieldValidator.validateTypeCar(value);
                    },
                    hintText: "Enter Type Of Car ",
                    fieldValidationkey: typeCarFieldKey),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Text(
                    "Preferred Company",
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
                    controller: preferedCompanyController,
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    validate: (value) {
                      return FieldValidator.validatePreferredCompany(value);
                    },
                    hintText: "Enter Preferred Company ",
                    fieldValidationkey: preferedCompanyFieldKey),
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
                      loading: tabsViewModel.carRentalloading,
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      press: () async {
                        FocusScope.of(context).unfocus();
                        if (key.currentState!.validate() &&
                            pickLocationFieldKey.currentState!.validate() &&
                            pickDateFieldKey.currentState!.validate() &&
                            pickTimeFieldKey.currentState!.validate() &&
                            dropLocationFieldKey.currentState!.validate() &&
                            dropDateFieldKey.currentState!.validate() &&
                            dropTimeFieldKey.currentState!.validate() &&
                            typeCarFieldKey.currentState!.validate() &&
                            preferedCompanyFieldKey.currentState!.validate()) {
                          String firstname = firstName.toString();
                          String email1 = email.toString();
                          String mobile = phoneNumber.toString();
                          String pickLocation =
                              pickLocationController.text.trim().toString();
                          String pickUpDate =
                              pickDateController.text.trim().toString();
                          String pickUpTime =
                              pickTimeController.text.trim().toString();
                          String dropLocation =
                              dropLocationController.text.trim().toString();
                          String dropDate =
                              dropDateController.text.trim().toString();
                          String dropTime =
                              dropTimeController.text.trim().toString();
                          String typeCar =
                              typeCarController.text.trim().toString();
                          String preferedCompany =
                              preferedCompanyController.text.trim().toString();

                          String additionalInformation =
                              additionalFieldController.text.toString();

                          // car rental method
                          await tabsViewModel.carRentalMethod(
                              id: id!.toString(),
                              context: context,
                              contactid: getContact == null
                                  ? getContactCreatId!.toString()
                                  : getContact.toString(),
                              firstname: firstname,
                              email: email1,
                              mobile: mobile,
                              typeCar: typeCar,
                              pickupTime: pickUpTime,
                              dropOffTime: dropTime,
                              pickUpDate: pickUpDate,
                              dropoffDate: dropDate,
                              preferredCompany: preferedCompany,
                              pickUpLocation: pickLocation,
                              dropOffLocation: dropLocation,
                              userId: getContact == null
                                  ? getContactCreatId!.toString()
                                  : getContact.toString(),
                              additionalInformation: additionalInformation);
                          //  clear fields
                          dropLocationController.clear();
                          pickLocationController.clear();
                          pickDateController.clear();
                          pickTimeController.clear();
                          dropDateController.clear();
                          dropTimeController.clear();
                          typeCarController.clear();
                          preferedCompanyController.clear();
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
