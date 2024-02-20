import '../../Utils/utils.dart';
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

class CheckConnectivityForgetPassword extends StatelessWidget {
  const CheckConnectivityForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectedState) {
          return const ForgetPassword();
        } else if (state is DisConnectedState) {
          return const NoConnectionPage();
        } else {
          return Container();
        }
      },
    );
  }
}

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _emailkey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Color emailColor = Colors.black26;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final authViewModal = Provider.of<AuthViewModal>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .10,
              ),
              FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: Center(
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.fill,
                    ),
                  )),
              SizedBox(
                height: height * .02,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1200),
                duration: const Duration(milliseconds: 1000),
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                      child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1400),
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .05),
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Pease enter the email address attached ",
                      style: TextStyle(
                          color: Colors.black38, fontSize: 17, height: 1),
                    ),
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1600),
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .10),
                  child: const Text(
                    "to your Vacation Ownership Advisor user account.",
                    style: TextStyle(
                        color: Colors.black38, fontSize: 17, height: 1),
                  ),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 1800),
                duration: const Duration(milliseconds: 1000),
                child: CustomTextField(
                  onTap: () {
                    setState(() {
                      emailColor = const Color(0xff0092ff);
                    });
                  },
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: emailColor,
                  ),
                  controller: _emailController,
                  fieldValidationkey: _emailkey,
                  validate: (value) {
                    return FieldValidator.validateEmail(value.toString());
                  },
                  onChanged: (value) {
                    _emailkey.currentState!.validate();
                  },
                ),
              ),
              SizedBox(
                height: height * .04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.10),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 2000),
                  duration: const Duration(milliseconds: 1000),
                  child: CustomButton(
                      loading: authViewModal.forgetPasswordloading,
                      width: width,
                      height: height * 0.07,
                      press: () {
                        if (_key.currentState!.validate()) {
                          Map data = {
                            'email': _emailController.text.trim(),
                          };
                          authViewModal.forgetPasswordApi(data, context);
                        } else {
                          // ignore: avoid_print
                          Utils.errorMessageFlush(
                              "Failed to Sent Email", context);
                        }
                      },
                      title: "CONFIRM"),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              FadeInUp(
                  delay: const Duration(milliseconds: 2300),
                  duration: const Duration(milliseconds: 1000),
                  child: const Divider()),
              FadeInUp(
                delay: const Duration(milliseconds: 2400),
                duration: const Duration(milliseconds: 1000),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesName.checkConnectivityloginScreen,
                          (route) => false);
                    },
                    child: const Text(
                      "Go Back",
                      style: TextStyle(color: Color(0xff0092ff), fontSize: 18),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
