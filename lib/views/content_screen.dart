import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/common_widgets/dropdown_button.dart';
import 'package:giongreviewphim/common_widgets/loading_overlay.dart';
import 'package:giongreviewphim/components/animated_btn.dart';
import 'package:giongreviewphim/components/background.dart';
import 'package:giongreviewphim/components/blur_widget.dart';
import 'package:giongreviewphim/constants.dart';
import 'package:giongreviewphim/controllers/content_controller.dart';
import 'package:giongreviewphim/models/convert_job.dart';
import 'package:http/http.dart';
import 'package:rive/rive.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late RiveAnimationController _btnAnimationColtroller;
  late ContentController _contentController;
  late TextEditingController _editingController;

  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
      // Let's restart the app again
      // No amination
    );
    // TODO: implement initState
    super.initState();
    _contentController = Get.find();
    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Obx(
        () {
          return LoadingOverlay(
            isLoading: _contentController.state == ContentState.processing,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: BlurWidget(
                        borderRadius: BorderRadius.circular(25),
                        child: TextField(
                          textAlign: TextAlign.start,
                          controller: _editingController,
                          expands: true,
                          maxLines: null, // allows for unlimited lines
                          keyboardType: TextInputType
                              .multiline, // allows for multiline input
                          decoration: InputDecoration(
                            hintText:
                                'Enter your text here', // placeholder text
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ), // add an outline border
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlurWidget(
                      borderRadius: BorderRadius.circular(25),
                      child: DropdownOptions(
                        value: _contentController.voice,
                        options: Constants.voice,
                        onChange: (value) =>
                            _contentController.updateVoice(value),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlurWidget(
                      borderRadius: BorderRadius.circular(25),
                      child: DropdownOptions(
                        value: _contentController.speed,
                        options: Constants.speed,
                        onChange: (value) =>
                            _contentController.updateSpeed(value),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedBtn(
                      btnAnimationColtroller: _btnAnimationColtroller,
                      press: () async {
                        _btnAnimationColtroller.isActive = true;
                        await Future.delayed(const Duration(seconds: 1));
                        _contentController.processing(_editingController.text);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
