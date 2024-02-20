import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomGlassmorpicContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? boderRadius;
  final Widget child;
  const CustomGlassmorpicContainer(
      {super.key,
      this.width,
      this.height,
      this.boderRadius = 20,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width!,
      height: height!,
      borderRadius: boderRadius!,
      linearGradient: LinearGradient(colors: [
        const Color(0xFF000000).withOpacity(0.4),
        const Color(0xFF000000).withOpacity(0.4),
      ]),
      border: 2,
      blur: 2,
      borderGradient: LinearGradient(colors: [
        const Color(0xFF000000).withOpacity(0.1),
        const Color(0xFF000000).withOpacity(0.05),
      ]),
      child: child,
    );
  }
}
