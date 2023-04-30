import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:giongreviewphim/models/convert_job.dart';
import 'package:giongreviewphim/page_router.dart';
import 'package:http/http.dart' as http;

enum ContentState { ready, processing }

class ContentController extends GetxController {
  final Rx<ContentState> _state = Rx<ContentState>(ContentState.ready);
  final Rx<String> _voice = Rx<String>('banmai');
  final Rx<String> _speed = Rx<String>('0');

  final String apiKey = 'onSMw1mVr07YCxpxuWhXVNtLrh7hJPTS';
  final String apiEndpoint = 'https://api.fpt.ai/hmi/tts/v5';

  ContentState get state => _state.value;
  String get voice => _voice.value;
  String get speed => _speed.value;

  void updateVoice(String voice) {
    _voice.value = voice;
  }

  void updateSpeed(String speed) {
    _speed.value = speed;
  }

  Future<bool> processing(String text) async {
    text = text.trim();
    if (text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Content is empty!',
        message: 'Paste your content to text field above.',
        duration: Duration(seconds: 2),
      ));
      return false;
    }
    _state.value = ContentState.processing;
    await Future.delayed(const Duration(seconds: 3));
    Map<String, String> result = await requestFptAi(text);
    if (result.containsKey('error')) {
      Get.showSnackbar(GetSnackBar(
        title: 'Convert fail!',
        message: result['error'],
        duration: const Duration(seconds: 2),
      ));
      _state.value = ContentState.ready;
      return false;
    } else {
      String url = result['url']!;
      await waitUntilLinkIsAccessible(url);
      Get.toNamed(PageRouter.resultScreen,
          arguments: {'job': ConvertJob(url: url, speed: speed, voice: voice)});
      _state.value = ContentState.ready;
      return true;
    }
  }

  Future<Map<String, String>> requestFptAi(String text) async {
    Map<String, String> result = {};
    try {
      final response = await http.post(
        Uri.parse(apiEndpoint),
        headers: {
          'api-key': apiKey,
          'speed': speed,
          'voice': voice,
          'Content-Type': 'application/json',
        },
        // body: jsonEncode({'text': text}),
        body: text,
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
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
