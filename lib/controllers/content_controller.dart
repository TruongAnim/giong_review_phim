import 'package:get/get.dart';
import 'package:giongreviewphim/page_router.dart';

enum ContentState { ready, processing }

class ContentController extends GetxController {
  Rx<ContentState> state = Rx<ContentState>(ContentState.ready);

  void processing(String text) async {
    text = text.trim();
    if (text.isEmpty) {
      Get.showSnackbar(GetSnackBar(
        title: 'Content is empty!',
        duration: Duration(seconds: 2),
      ));
      return;
    }
    state.value = ContentState.processing;
    await Future.delayed(Duration(seconds: 3));
    state.value = ContentState.ready;
    String url = 'hello';
    Get.toNamed(PageRouter.resultScreen, arguments: {'url': url});
  }
}
