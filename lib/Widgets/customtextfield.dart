import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.onTap,
      this.character = ' ',
      this.validate,
      this.inputAction,
      this.textInputType,
      this.hintText,
      this.sufixIcon,
      this.prefixIcon,
      this.paddingLeft,
      this.paddingRight,
      this.inputparameter,
      this.style,
      required this.boderColor,
      this.readonly = false,
      this.textCapitalization = TextCapitalization.none,
      required this.controller,
      this.focusNode,
      this.onChanged,
      this.label,
      this.errorText,
      this.obscureText = false,
      this.fieldValidationkey});

  Widget? sufixIcon;
  String character;
  TextEditingController controller;
  GlobalKey<FormFieldState>? fieldValidationkey;
  TextInputType? textInputType;
  TextInputAction? inputAction;
  TextCapitalization textCapitalization;
  bool obscureText;
  final Color boderColor;
  String? hintText;
  double? paddingLeft;
  double? paddingRight;
  Widget? prefixIcon;
  bool readonly;
  String? label;
  String? errorText;
  FocusNode? focusNode;
  var validate;
  VoidCallback? onTap;
  TextStyle? style;
  List<TextInputFormatter>? inputparameter;
  ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(
          left: paddingLeft ?? size.width * .05,
          right: paddingRight ?? size.width * .05),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        readOnly: readonly,
        inputFormatters: inputparameter,
        textCapitalization: textCapitalization,
        cursorColor: const Color(0xff0092ff),
        obscureText: obscureText,
        obscuringCharacter: character,
        onTap: onTap,
        style: style,
        onChanged: onChanged,
        keyboardType: textInputType,
        key: fieldValidationkey,
        controller: controller,
        validator: validate,
        textInputAction: inputAction,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          hintText: hintText,

          isDense: true,
          filled: true,
          //fillColor: Colors.white,
          hintStyle: const TextStyle(color: Color(0xFF97989e)),
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: boderColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: boderColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF0092ff), width: 1),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
