import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/components/animated_btn.dart';
import 'package:giongreviewphim/controllers/result_controller.dart';
import 'package:rive/rive.dart';

class DownloadScreen extends StatefulWidget {
  final String url;

  const DownloadScreen({Key? key, required this.url}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late RiveAnimationController _btnAnimationColtroller;
  final ResultController _controller = Get.find();
  late bool _downloading;

  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
    _downloading = false;
  }

  _download() async {
    _btnAnimationColtroller.isActive = true;
    await Future.delayed(const Duration(milliseconds: 800));
    String result = await _controller.download(widget.url);
    Get.showSnackbar(GetSnackBar(
      title: result.split(':')[0],
      message: result.split(':')[1],
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBtn(
        text: 'Download',
        icon: !_downloading
            ? const Icon(
                Icons.download,
                color: Colors.white,
              )
            : const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
        btnAnimationColtroller: _btnAnimationColtroller,
        press: _download,
      ),
    );
  }
}
