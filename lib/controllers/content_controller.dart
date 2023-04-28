import 'dart:convert';

import 'package:get/get.dart';
import 'package:giongreviewphim/page_router.dart';
import 'package:http/http.dart' as http;

enum ContentState { ready, processing }

class ContentController extends GetxController {
  final Rx<ContentState> _state = Rx<ContentState>(ContentState.ready);
  final String apiKey = 'onSMw1mVr07YCxpxuWhXVNtLrh7hJPT';
  final String apiEndpoint = 'https://api.fpt.ai/hmi/tts/v5';

  ContentState get state => _state.value;

  void processing(String text) async {
    text = text.trim();
    if (text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Content is empty!',
        message: 'Paste your content to text field above.',
        duration: Duration(seconds: 2),
      ));
      return;
    }
    _state.value = ContentState.processing;
    // await Future.delayed(const Duration(seconds: 3));
    Map<String, String> result = await requestFptAi(text);
    if (result.containsKey('error')) {
      Get.showSnackbar(GetSnackBar(
        title: 'Convert fail!',
        message: result['error'],
        duration: Duration(seconds: 2),
      ));
    } else {
      String url = result['url']!;
      await waitUntilLinkIsAccessible(url);
      Get.toNamed(PageRouter.resultScreen, arguments: {'url': url});
    }
    _state.value = ContentState.ready;
  }

  Future<Map<String, String>> requestFptAi(String text) async {
    Map<String, String> result = {};
    try {
      final response = await http.post(
        Uri.parse(apiEndpoint),
        headers: {
          'api-key': apiKey,
          'speed': '0',
          'voice': 'banmai',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'text': text}),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String audioUrl = data['async'] ?? data['data'] ?? '';
        result = {'url': audioUrl};
      } else {
        result = {'error': data['message']};
      }
    } catch (e) {
      result = {'error': e.toString()};
    }
    return result;
  }

  Future<void> waitUntilLinkIsAccessible(String link) async {
    while (true) {
      try {
        final response = await http.get(Uri.parse(link));
        if (response.statusCode == 200) {
          return;
        }
      } catch (_) {
        // Ignore error and try again
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
