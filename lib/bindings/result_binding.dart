import 'package:get/get.dart';
import 'package:giongreviewphim/controllers/result_controller.dart';

class ResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultController());
  }
}
