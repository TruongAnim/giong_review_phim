import 'package:get/get.dart';
import 'package:giongreviewphim/controllers/result_controller.dart';

class ResultBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ResultController());
  }
}
