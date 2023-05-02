import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    Key? key,
    required rive.RiveAnimationController btnAnimationColtroller,
    required this.press,
    required this.text,
    required this.icon,
  })  : _btnAnimationColtroller = btnAnimationColtroller,
        super(key: key);

  final String text;
  final Widget icon;
  final rive.RiveAnimationController _btnAnimationColtroller;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            // Just a button no animation
            // Let's fix that
            rive.RiveAnimation.asset(
              "assets/RiveAssets/button.riv",
              // Once we restart the app it shows the animation
              controllers: [_btnAnimationColtroller],
            ),
            Positioned(
              // But it's not center
              top: 10,
              left: 22,
              child: Container(
                height: 52,
                width: 224,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.green],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
