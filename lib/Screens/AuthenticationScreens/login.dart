import '../../Utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custombutton.dart';
import '../../view_model/view_modal.dart';
import '../../bloc/connectivity_bloc.dart';
import '../../Utils/routes/routesname.dart';
import '../../Widgets/customtextfield.dart';
import 'package:animate_do/animate_do.dart';
import '../../Utils/no_connection_page.dart';
import '../../Utils/Validation/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/textformfield_change_color_view_model.dart';

// ignore_for_file: unnecessary_null_comparison

class CheckConnectivityLogin extends StatelessWidget {
  const CheckConnectivityLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return const LoginScreen();
        } else if (state is DisConnectedState) {
          return const NoConnectionPage();
        } else {
          return Container();
        }
      },
    );
  }
}

// login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> emailFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordFieldKey =
      GlobalKey<FormFieldState>();
  // show password icon provider
  ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
// field colors

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TextFieldColorChangeViewModel>(context, listen: false)
          .setPasswordFieldColor(Colors.black26);
      Provider.of<TextFieldColorChangeViewModel>(context, listen: false)
          .setEmailFieldColor(Colors.black26);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final authViewModal = Provider.of<AuthViewModal>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // scaffold
      child: Scaffold(
        // backgroundColor
        backgroundColor: Colors.white,
        // singlechildscrollview
        body: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
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
                  height: height * .01,
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  duration: const Duration(milliseconds: 1000),
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Login Now",
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
                  height: height * .03,
                ),
                // email text-field
                Consumer<TextFieldColorChangeViewModel>(
                  builder: (context, value, child) => FadeInRight(
                    delay: const Duration(milliseconds: 1400),
                    duration: const Duration(milliseconds: 1000),
                    child: CustomTextField(
                      onTap: () {
                        value.setEmailFieldColor(const Color(0xff0092ff));
                        value.setPasswordFieldColor(Colors.black26);
                      },
                      validate: (value) {
                        return FieldValidator.validateEmail(value.toString());
                      },
                      style: const TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: value.emailFieldColor,
                      ),
                      controller: emailController,
                      fieldValidationkey: emailFieldKey,
                      hintText: "User Email",
                      onChanged: (value) {
                        emailFieldKey.currentState!.validate();
                      },
                      textInputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      boderColor: value.emailFieldColor,
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .01,
                ),
                // password text-field
                ValueListenableBuilder(
                  valueListenable: obscureText,
                  builder: (context, value, child) => FadeInRight(
                    delay: const Duration(milliseconds: 1600),
                    duration: const Duration(milliseconds: 1000),
                    child: Consumer<TextFieldColorChangeViewModel>(
                      builder: (context, value, child) => CustomTextField(
                        onTap: () {
                          value.setEmailFieldColor(Colors.black26);
                          value.setPasswordFieldColor(const Color(0xff0092ff));
                        },
                        character: '*',
                        prefixIcon:
                            Icon(Icons.lock, color: value.passwordFieldColor),
                        controller: passwordController,
                        fieldValidationkey: passwordFieldKey,
                        hintText: "User Password",
                        textInputType: TextInputType.visiblePassword,
                        validate: (value) {
                          return FieldValidator.validatePassword(
                              value.toString());
                        },
                        obscureText: obscureText.value,
                        sufixIcon: InkWell(
                            onTap: () {
                              obscureText.value = !obscureText.value;
                            },
                            child: Icon(
                                obscureText.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility,
                                color: value.passwordFieldColor)),
                        boderColor: value.passwordFieldColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .005,
                ),
                // forget password button
                FadeInRight(
                  delay: const Duration(milliseconds: 1700),
                  duration: const Duration(milliseconds: 1000),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: EdgeInsets.only(left: width * .55),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesName.checkConnectivityForgetPassword,
                                (route) => false);
                          },
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF0092ff),
                                decorationThickness: 2,
                                color: Color(0xFF0092ff),
                                fontSize: 16),
                          )),
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .02,
                ),
                // login button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.10),
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 1900),
                    duration: const Duration(milliseconds: 1000),
                    child: CustomButton(
                        loading: authViewModal.loginloading,
                        width: width,
                        height: height * 0.06,
                        press: () {
                          FocusScope.of(context).unfocus();
                          if (key.currentState!.validate()) {
                            Map data = {
                              'email': emailController.text.trim(),
                              'password': passwordController.text.trim()
                            };
                            authViewModal.loginApi(data, context);
                          } else {
                            Utils.errorMessageFlush("Failed to login", context);
                          }
                        },
                        title: "LOGIN"),
                  ),
                ),

                // space
                SizedBox(
                  height: height * .03,
                ),
                FadeInUp(
                    delay: const Duration(milliseconds: 2100),
                    duration: const Duration(milliseconds: 1000),
                    child: const Divider()),
                SizedBox(
                  height: height * .01,
                ),
                // don't have account text
                FadeInUp(
                  delay: const Duration(milliseconds: 2200),
                  duration: const Duration(milliseconds: 1000),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: RichText(
                        text: TextSpan(children: <InlineSpan>[
                      const TextSpan(
                          text: "Don't have an account! ",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      TextSpan(
                          text: "Register",
                          style: const TextStyle(
                              color: Color(0xFF0092ff),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RoutesName.checkConnectivitysignUpScreen,
                                  (route) => false);
                            })
                    ])),
                  ),
                ),
                // space
                SizedBox(
                  height: height * .05,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
