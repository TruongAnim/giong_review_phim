import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BlurWidget extends StatelessWidget {
  const BlurWidget(
      {super.key, required this.child, required this.borderRadius});
  final Widget child;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: borderRadius,
      child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 100.0,
            sigmaY: 100.0,
          ),
          child: child),
    );
  }
}
