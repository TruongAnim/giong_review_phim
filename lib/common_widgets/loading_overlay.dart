import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  LoadingOverlay({required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Opacity(
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
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Đang chuyển đổi giọng nói...',
                    style: TextStyle(
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
