import 'package:get/get.dart';
import 'package:giongreviewphim/controllers/content_controller.dart';

class ContentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentController>(
      () => ContentController(),
    );
  }
}
