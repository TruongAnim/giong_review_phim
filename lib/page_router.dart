import 'package:get/get.dart';
import 'package:giongreviewphim/bindings/content_binding.dart';
import 'package:giongreviewphim/bindings/result_binding.dart';
import 'package:giongreviewphim/views/content_screen.dart';
import 'package:giongreviewphim/views/result_screen.dart';

class PageRouter {
  static String contentScreen = '/content';
  static String resultScreen = '/result';

  static List<GetPage> listPage = [
    GetPage(
        name: contentScreen,
        page: () => const ContentScreen(),
        binding: ContentBinding()),
    GetPage(
        name: resultScreen,
        page: () => const ResultScreen(),
        binding: ResultBinding()),
  ];
}
