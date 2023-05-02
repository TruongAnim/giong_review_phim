import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/common_widgets/audio_player.dart';
import 'package:giongreviewphim/common_widgets/copy_link.dart';
import 'package:giongreviewphim/common_widgets/download_file.dart';
import 'package:giongreviewphim/components/background.dart';
import 'package:giongreviewphim/components/blur_widget.dart';
import 'package:giongreviewphim/controllers/result_controller.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Map<String, dynamic> data;
  late ResultController _resultController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _resultController = Get.find();
    data = Get.arguments;
    _resultController.setJob(data['job']);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Background(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            BlurWidget(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: h * 0.5,
                child: AudioPlayerWidget(job: _resultController.job),
              ),
            ),
            const Spacer(),
            DownloadScreen(url: _resultController.job.url),
            const SizedBox(
              height: 15,
            ),
            CopyLink(url: _resultController.job.url),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
