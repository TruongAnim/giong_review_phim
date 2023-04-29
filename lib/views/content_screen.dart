import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/common_widgets/dropdown_button.dart';
import 'package:giongreviewphim/common_widgets/loading_overlay.dart';
import 'package:giongreviewphim/constants.dart';
import 'package:giongreviewphim/controllers/content_controller.dart';
import 'package:giongreviewphim/models/convert_job.dart';
import 'package:http/http.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late ContentController _contentController;
  late TextEditingController _editingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController = Get.find();
    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Content screen")),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: _contentController.state == ContentState.processing,
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _editingController,
                  expands: true,
                  maxLines: null, // allows for unlimited lines
                  keyboardType:
                      TextInputType.multiline, // allows for multiline input
                  decoration: const InputDecoration(
                    hintText: 'Enter your text here', // placeholder text
                    border: OutlineInputBorder(), // add an outline border
                  ),
                ),
              ),
              DropdownOptions(
                value: _contentController.voice,
                options: Constants.voice,
                onChange: (value) => _contentController.updateVoice(value),
              ),
              // DropdownOptions(
              //   value: _contentController.speed,
              //   options: Constants.speed,
              //   onChange: (value) => _contentController.updateSpeed(value),
              // ),
              ElevatedButton(
                onPressed: () {
                  print(_editingController.text);
                  _contentController.processing(_editingController.text);
                },
                child: const Text('Convert to mp3'),
              )
            ],
          ),
        );
      }),
    );
  }
}
