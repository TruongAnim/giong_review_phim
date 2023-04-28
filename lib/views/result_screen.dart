import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/common_widgets/audio_player.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Map<String, dynamic> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AudioPlayerWidget(url: data['url']),
      ),
    );
  }
}
