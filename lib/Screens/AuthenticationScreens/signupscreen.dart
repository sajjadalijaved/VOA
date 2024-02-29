import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custombutton.dart';
import '../../view_model/view_modal.dart';
import '../../bloc/connectivity_bloc.dart';
import '../../Widgets/customtextfield.dart';
import 'package:animate_do/animate_do.dart';
import '../../Utils/no_connection_page.dart';
import '../../Utils/Validation/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacation_ownership_advisor/Screens/AuthenticationScreens/login.dart';
import 'package:vacation_ownership_advisor/view_model/textformfield_change_color_view_model.dart';

// ignore_for_file: unused_local_variable

// ignore_for_file: use_build_context_synchronously

class CheckConnectivitySignUp extends StatelessWidget {
  const CheckConnectivitySignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return const SignUpScreen();
        } else if (state is DisConnectedState) {
          return const NoConnectionPage();
        } else {
          return Container();
        }
      },
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // controllers
  late TextEditingController firstNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumberController;
  late TextEditingController confirmPasswordController;
  // global keys
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> emailFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> confirmPasswordFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> firstNameFieldKey =
      GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> phoneNumberFieldKey =
      GlobalKey<FormFieldState>();
  // show password icon control provider
  ValueNotifier<bool> passwordobsureText = ValueNotifier<bool>(true);
  ValueNotifier<bool> confirmPasswordObscureText = ValueNotifier<bool>(true);

  static String storeToken = "";

  _tokenRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storeToken = prefs.getString('token') ?? '';

    log("Get Token in RegisterScreen: $storeToken");
  }

  @override
  void initState() {
    super.initState();
    _tokenRetriever();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TextFieldColorChangeViewModel>(context, listen: false)
          .setPassworSignUpdFieldColor(Colors.black26);
      Provider.of<TextFieldColorChangeViewModel>(context, listen: false)
          .setEmailSignUpFieldColor(Colors.black26);
      Provider.of<TextFieldColorChangeViewModel>(context, listen: false)
          .setNameFieldColor(Colors.black26);
      Provider.of<TextFieldColorChangeViewModel>(context, listen: false)
          .setPhoneFieldColor(Colors.black26);
      Provider.of<TextFieldColorChangeViewModel>(context, listen: false)
          .setPasswordConfirmFieldColor(Colors.black26);
    });
  }

// dispose method
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final authViewModal = Provider.of<AuthViewModal>(context);
    final textfieldColor =
        Provider.of<TextFieldColorChangeViewModel>(context, listen: false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // scaffold
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                SizedBox(
                  height: height * .10,
                ),
                // image container background
                FadeInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Center(
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.fill,
                      ),
                    )),
                SizedBox(
                  height: height * .01,
                  width: width,
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  duration: const Duration(milliseconds: 1000),
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Color(0xFF0092ff),
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1200),
                  duration: const Duration(milliseconds: 1000),
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Please enter details below to continue.",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                // first name text field
                Consumer<TextFieldColorChangeViewModel>(
                  builder: (context, value, child) => FadeInRight(
                    delay: const Duration(milliseconds: 1300),
                    duration: const Duration(milliseconds: 1000),
                    child: CustomTextField(
                      textCapitalization: TextCapitalization.words,
                      inputparameter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                      ],
                      onTap: () {
                        value.setEmailSignUpFieldColor(Colors.black26);
                        value.setNameFieldColor(const Color(0xff0092ff));
                        value.setPassworSignUpdFieldColor(Colors.black26);
                        value.setPasswordConfirmFieldColor(Colors.black26);
                        value.setPhoneFieldColor(Colors.black26);
                      },
                      validate: (value) {
                        return FieldValidator.validateName(value.toString());
                      },
                      prefixIcon: Icon(
                        Icons.person,
                        color: value.nameFieldColor,
                      ),
                      controller: firstNameController,
                      fieldValidationkey: firstNameFieldKey,
                      hintText: "Full Name",
                      textInputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {
                        firstNameFieldKey.currentState!.validate();
                      },
                      boderColor: value.nameFieldColor,
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .01,
                ),

                // phone number text field
                Consumer<TextFieldColorChangeViewModel>(
                  builder: (context, value, child) => FadeInRight(
                    delay: const Duration(milliseconds: 1400),
                    duration: const Duration(milliseconds: 1000),
                    child: CustomTextField(
                      onTap: () {
                        value.setEmailSignUpFieldColor(Colors.black26);
                        value.setNameFieldColor(Colors.black26);
                        value.setPassworSignUpdFieldColor(Colors.black26);
                        value.setPasswordConfirmFieldColor(Colors.black26);
                        value.setPhoneFieldColor(const Color(0xff0092ff));
                      },
                      validate: (value) {
                        return FieldValidator.validatePhoneNumber(
                            value.toString());
                      },
                      prefixIcon: Icon(
                        Icons.phone_android_outlined,
                        color: value.phoneFieldColor,
                      ),
                      controller: phoneNumberController,
                      fieldValidationkey: phoneNumberFieldKey,
                      hintText: "Phone Number",
                      textInputType: TextInputType.phone,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {
                        phoneNumberFieldKey.currentState!.validate();
                      },
                      boderColor: value.phoneFieldColor,
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .01,
                ),
                // email text field
                Consumer<TextFieldColorChangeViewModel>(
                  builder: (context, value, child) => FadeInRight(
                    delay: const Duration(milliseconds: 1500),
                    duration: const Duration(milliseconds: 1000),
                    child: CustomTextField(
                      onTap: () {
                        value.setEmailSignUpFieldColor(const Color(0xff0092ff));
                        value.setNameFieldColor(Colors.black26);
                        value.setPassworSignUpdFieldColor(Colors.black26);
                        value.setPasswordConfirmFieldColor(Colors.black26);
                        value.setPhoneFieldColor(Colors.black26);
                      },
                      validate: (value) {
                        return FieldValidator.validateEmail(value.toString());
                      },
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: value.emailSignUpFieldColor,
                      ),
                      controller: emailController,
                      fieldValidationkey: emailFieldKey,
                      hintText: "User Email",
                      textInputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {
                        emailFieldKey.currentState!.validate();
                      },
                      boderColor: value.emailSignUpFieldColor,
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .01,
                ),
                // password text field
                ValueListenableBuilder(
                  valueListenable: passwordobsureText,
                  builder: (context, value, child) =>
                      Consumer<TextFieldColorChangeViewModel>(
                    builder: (context, value, child) => FadeInRight(
                      delay: const Duration(milliseconds: 1600),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomTextField(
                        onTap: () {
                          value.setEmailSignUpFieldColor(Colors.black26);
                          value.setNameFieldColor(Colors.black26);
                          value.setPassworSignUpdFieldColor(
                              const Color(0xff0092ff));
                          value.setPasswordConfirmFieldColor(Colors.black26);
                          value.setPhoneFieldColor(Colors.black26);
                        },
                        character: '*',
                        onChanged: (value) {
                          passwordFieldKey.currentState!.validate();
                        },
                        prefixIcon: Icon(
                          Icons.lock,
                          color: value.passwordSignUpFieldColor,
                        ),
                        controller: passwordController,
                        fieldValidationkey: passwordFieldKey,
                        hintText: "User Password",
                        textInputType: TextInputType.visiblePassword,
                        validate: (value) {
                          return FieldValidator.validatePassword(
                              value.toString());
                        },
                        obscureText: passwordobsureText.value,
                        sufixIcon: InkWell(
                          onTap: () {
                            passwordobsureText.value =
                                !passwordobsureText.value;
                          },
                          child: Icon(
                              passwordobsureText.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              color: value.passwordSignUpFieldColor),
                        ),
                        boderColor: value.passwordFieldColor,
                      ),
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .01,
                ),
                // confirm password text field
                ValueListenableBuilder(
                  valueListenable: confirmPasswordObscureText,
                  builder: (context, value, child) =>
                      Consumer<TextFieldColorChangeViewModel>(
                    builder: (context, value, child) => FadeInRight(
                      delay: const Duration(milliseconds: 1700),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomTextField(
                        onTap: () {
                          value.setEmailSignUpFieldColor(Colors.black26);
                          value.setNameFieldColor(Colors.black26);
                          value.setPassworSignUpdFieldColor(Colors.black26);
                          value.setPasswordConfirmFieldColor(
                              const Color(0xff0092ff));
                          value.setPhoneFieldColor(Colors.black26);
                        },
                        character: '*',
                        onChanged: (value) {
                          confirmPasswordFieldKey.currentState!.validate();
                        },
                        prefixIcon: Icon(
                          Icons.password,
                          color: value.passwordConfirmFieldColor,
                        ),
                        controller: confirmPasswordController,
                        fieldValidationkey: confirmPasswordFieldKey,
                        hintText: "Confirm Password",
                        textInputType: TextInputType.visiblePassword,
                        validate: (value) {
                          return FieldValidator.validatePasswordMatch(
                              value.toString(),
                              passwordController.text.toString());
                        },
                        obscureText: confirmPasswordObscureText.value,
                        sufixIcon: InkWell(
                          onTap: () {
                            confirmPasswordObscureText.value =
                                !confirmPasswordObscureText.value;
                          },
                          child: Icon(
                              confirmPasswordObscureText.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,
                              color: value.passwordConfirmFieldColor),
                        ),
                        boderColor: value.passwordConfirmFieldColor,
                      ),
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .03,
                ),
                // sign up button
                FadeInUp(
                  delay: const Duration(milliseconds: 1900),
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.10),
                    child: CustomButton(
                        loading: authViewModal.signinLoading,
                        width: width,
                        height: height * 0.07,
                        press: () async {
                          if (key.currentState!.validate()) {
                            Map data = {
                              'first_name': firstNameController.text.trim(),
                              'mobile': phoneNumberController.text.trim(),
                              'email': emailController.text.trim(),
                              'password': passwordController.text.trim(),
                              'device_token': storeToken,
                            };
                            authViewModal.registerApi(data, context);
                          }
                        },
                        title: "SIGN UP"),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .03,
                ),
                FadeInUp(
                    delay: const Duration(milliseconds: 2000),
                    duration: const Duration(milliseconds: 1000),
                    child: const Divider()),
                SizedBox(
                  height: height * .01,
                ),
                // have already account text
                FadeInUp(
                  delay: const Duration(milliseconds: 2100),
                  duration: const Duration(milliseconds: 1000),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: RichText(
                        text: TextSpan(children: <InlineSpan>[
                      const TextSpan(
                          text: "Already have an account! ",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      TextSpan(
                          text: "Sign in",
                          style: const TextStyle(
                              color: Color(0xFF0092ff),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(-1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.easeIn;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(seconds: 1),
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const CheckConnectivityLogin();
                                    },
                                  ),
                                  (route) => false);
                            })
                    ])),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
