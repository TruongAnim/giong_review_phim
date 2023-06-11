import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Background extends StatefulWidget {
  const Background({super.key, required this.child});
  final Widget child;

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // At the end of the video i will show you
          // How to create that animation on Rive
          // Let's add blur
          Positioned(
            // height: 100,
            width: MediaQuery.of(context).size.width * 1.3,
            top: 0,
            left: -15,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          // Positioned.fill(
          //   child: BackdropFilter(
          //     // Now it's looks perfect
          //     // See how easy
          //     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
          //     child: const SizedBox(),
          //   ),
          // ),
          const RiveAnimation.asset(
            "assets/RiveAssets/shapes.riv",
            fit: BoxFit.cover,
          ),
          // Positioned.fill(
          //   child: BackdropFilter(
          //     // Now it's looks perfect
          //     filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          //     child: const SizedBox(),
          //   ),
          // ),
          // Let's add text
          widget.child,
        ],
      ),
    );
  }
}
