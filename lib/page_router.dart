import 'package:get/get.dart';
import 'package:giongreviewphim/bindings/content_binding.dart';
import 'package:giongreviewphim/content_screen.dart';
import 'package:giongreviewphim/result_screen.dart';

class PageRouter {
  static String contentScreen = '/content';
  static String resultScreen = '/result';

  static List<GetPage> listPage = [
    GetPage(
        name: contentScreen,
        page: () => ContentScreen(),
        binding: ContentBinding()),
    // GetPage(name: '/result', page: () => ResultScreen()),
  ];
}
