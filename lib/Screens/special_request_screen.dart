import 'dart:developer';
import '../modals/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../modals/contact_id_model.dart';
import 'package:animate_do/animate_do.dart';
import '../view_model/tabs_view_model.dart';
import '../database/datamodel_provider.dart';
import 'package:vacation_ownership_advisor/Utils/utils.dart';
import 'package:vacation_ownership_advisor/Screens/home_screen.dart';
import 'package:vacation_ownership_advisor/Widgets/custombutton.dart';
import 'package:vacation_ownership_advisor/Utils/Validation/validation.dart';

// ignore_for_file: must_be_immutable

// ignore_for_file: unnecessary_null_comparison

class SpecialRequestScreen extends StatefulWidget {
  dynamic userId;

  SpecialRequestScreen({
    super.key,
    required this.userId,
  });

  @override
  State<SpecialRequestScreen> createState() => _SpecialRequestScreenState();
}

class _SpecialRequestScreenState extends State<SpecialRequestScreen> {
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

  late TextEditingController specialFieldController;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> specialFieldKey = GlobalKey<FormFieldState>();

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
          log("contactIdFetch in special : $getContact");
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
    specialFieldController = TextEditingController();

    fetch().whenComplete(() async {
      await fetchContactId();
    });
  }

  @override
  void dispose() {
    specialFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("User_id in SpecialRequestScreen   : ${widget.userId}");

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    TabsViewModel tabsViewModel = Provider.of<TabsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
            child: const Icon(
              Icons.arrow_back_sharp,
              size: 30,
              color: Color(0xFF0092ff),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CheckConnectivityHomeScreen(userId: widget.userId),
                  ),
                  (route) => false);
            }),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.10,
              ),
              // image container
              FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: Center(
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.fill,
                    ),
                  )),
              SizedBox(
                height: height * 0.04,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: const Text(
                    "Special Request Information",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1200),
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                  ),
                  child: TextFormField(
                    key: specialFieldKey,
                    controller: specialFieldController,
                    maxLength: 1000,
                    maxLines: 8,
                    validator: (value) {
                      return FieldValidator.validateSpecialRequest(value);
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "Enter Special Information",
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
              ),
              SizedBox(
                height: height * 0.04,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1400),
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: CustomButton(
                      loading: tabsViewModel.specialRequestloading,
                      width: width * 0.4,
                      height: height * 0.06,
                      press: () async {
                        FocusScope.of(context).unfocus();
                        if (key.currentState!.validate() &&
                            specialFieldKey.currentState!.validate()) {
                          String firstname = firstName.toString();
                          String email1 = email.toString();
                          String mobile = phoneNumber.toString();
                          String specialRequest =
                              specialFieldController.text.trim().toString();
                          await tabsViewModel.specialRequestMethod(
                              context: context,
                              firstname: firstname,
                              email: email1,
                              id: widget.userId.toString(),
                              mobile: mobile,
                              contactid: getContact.toString(),
                              userId: getContact.toString(),
                              specialRequestData: specialRequest);
                          specialFieldController.clear();
                        } else {
                          Utils.errorMessageFlush(
                              "Please fill  Required Field", context);
                        }
                      },
                      title: "Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
