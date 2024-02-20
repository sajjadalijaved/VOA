import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      this.loading = false,
      required this.width,
      required this.height,
      required this.press,
      required this.title})
      : super(key: key);
  double height;
  double width;
  String title;
  VoidCallback press;
  bool loading;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF0092ff)),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
