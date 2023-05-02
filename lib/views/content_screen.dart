import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/common_widgets/dropdown_button.dart';
import 'package:giongreviewphim/common_widgets/loading_overlay.dart';
import 'package:giongreviewphim/components/animated_btn.dart';
import 'package:giongreviewphim/components/background.dart';
import 'package:giongreviewphim/components/blur_widget.dart';
import 'package:giongreviewphim/components/custom_textfield.dart';
import 'package:giongreviewphim/constants.dart';
import 'package:giongreviewphim/controllers/content_controller.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isSignInDialogShown = false;

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
                    BlurWidget(
                      borderRadius: BorderRadius.circular(25),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "  Giọng Review Phim  ",
                          style: GoogleFonts.roboto(
                            fontSize: 30,
                            color: const Color(0xFF1ABC9C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: BlurWidget(
                        borderRadius: BorderRadius.circular(25),
                        child: CustomTextField(
                            editingController: _editingController),
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
                      text: "Convert to audio",
                      icon: const Icon(
                        Icons.keyboard_double_arrow_right,
                        color: Colors.white,
                      ),
                      btnAnimationColtroller: _btnAnimationColtroller,
                      press: () async {
                        _btnAnimationColtroller.isActive = true;
                        await Future.delayed(const Duration(milliseconds: 800));
                        bool isOke = await _contentController
                            .processing(_editingController.text);
                        // We made it but
                        // also need to set it false once the dialog close
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
