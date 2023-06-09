import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay(
      {super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.5, // Set the opacity here
            child: ModalBarrier(
              color: Colors.grey, // You can set the color to whatever you like
              dismissible: false,
            ),
          ),
        if (isLoading)
          Center(
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "processing".tr,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}
