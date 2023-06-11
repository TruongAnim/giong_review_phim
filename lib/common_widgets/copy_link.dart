import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/components/animated_btn.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

class CopyLink extends StatefulWidget {
  const CopyLink({super.key, required this.url});
  final String url;

  @override
  State<CopyLink> createState() => _CopyLinkState();
}

class _CopyLinkState extends State<CopyLink> {
  late RiveAnimationController _btnAnimationColtroller;
  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
      // Let's restart the app again
      // No amination
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBtn(
        text: "copy-link".tr,
        icon: const Icon(
          Icons.copy,
          color: Colors.white,
        ),
        btnAnimationColtroller: _btnAnimationColtroller,
        press: () async {
          _btnAnimationColtroller.isActive = true;
          await Future.delayed(const Duration(milliseconds: 800));
          Clipboard.setData(ClipboardData(text: widget.url)).then((_) {
            Get.showSnackbar(GetSnackBar(
              title: "success".tr,
              message: "link-copied".tr,
              duration: Duration(seconds: 2),
            ));
          });
        },
      ),
    );
  }
}
