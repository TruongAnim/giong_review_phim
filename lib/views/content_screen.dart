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
import 'package:rive/rive.dart' as rive;

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late rive.RiveAnimationController _btnAnimationColtroller;
  late ContentController _contentController;
  late TextEditingController _editingController;
  bool isSignInDialogShown = false;

  @override
  void initState() {
    _btnAnimationColtroller = rive.OneShotAnimation(
      "active",
      autoplay: false,
      // Let's restart the app again
      // No amination
    );
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
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [Color(0xffe7537e), Color(0xfff79168)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Text(
                        "Giọng Review Phim",
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
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
                        final FocusScopeNode currentScope =
                            FocusScope.of(context);
                        if (!currentScope.hasPrimaryFocus &&
                            currentScope.hasFocus) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        _btnAnimationColtroller.isActive = true;
                        await Future.delayed(const Duration(milliseconds: 800));
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
