import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NoConnectionPage extends StatefulWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  State<NoConnectionPage> createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFca8e2e),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: isloading
                      ? const SpinKitFadingCircle(
                          color: Color(0xFF0092ff),
                        )
                      // LoadingAnimationWidget.discreteCircle(
                      //     color: Colors.white,
                      //     size: 50,
                      //     secondRingColor: Colors.black,
                      //     thirdRingColor: Colors.purple)
                      : const Image(
                          // height: height*.3,

                          fit: BoxFit.cover,
                          image: AssetImage('assets/dis.gif')),
                ),
              ),
              SizedBox(
                  height: height * .04,
                  width: width,
                  child: Center(
                    child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isloading = true;
                          });
                          await Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              setState(() {
                                isloading = false;
                              });
                            },
                          );
                        },
                        child: const Text(
                          "Try Again",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ))
            ],
          )),
    );
  }
}
