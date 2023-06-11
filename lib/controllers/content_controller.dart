import 'dart:convert';

import 'package:get/get.dart';
import 'package:giongreviewphim/constants.dart';
import 'package:giongreviewphim/models/convert_job.dart';
import 'package:giongreviewphim/models/options.dart';
import 'package:giongreviewphim/page_router.dart';
import 'package:http/http.dart' as http;

enum ContentState { ready, processing }

class ContentController extends GetxController {
  final Rx<ContentState> _state = Rx<ContentState>(ContentState.ready);
  final Rx<int> _voice = Rx<int>(0);
  final Rx<int> _speed = Rx<int>(0);

  final String apiKey = '6QM7JU6XWxx2WVnxB5VHEw7ESGgj3RUZ';
  final String apiEndpoint = 'https://api.fpt.ai/hmi/tts/v5';

  ContentState get state => _state.value;
  String get voice => Constants.voice[_voice.value].value.tr;
  String get speed => Constants.speed[_speed.value].value.tr;

  void updateVoice(String voice) {
    _voice.value =
        Constants.voice.indexWhere((Option element) => element.value == voice);
  }

  void updateSpeed(String speed) {
    _speed.value =
        Constants.speed.indexWhere((Option element) => element.value == speed);
  }

  Future<bool> processing(String text) async {
    text = text.trim();
    if (text.isEmpty) {
      Get.showSnackbar(GetSnackBar(
        title: "empty-content".tr,
        message: "please-enter-content".tr,
        duration: const Duration(seconds: 2),
      ));
      return false;
    }
    if (text.length > Constants.maxLength) {
      Get.showSnackbar(GetSnackBar(
        title: "content-is-too-long".tr,
        message: "please-enter-below"
            .tr
            .replaceAll('2500', Constants.maxLength.toString()),
        duration: const Duration(seconds: 2),
      ));
      return false;
    }
    _state.value = ContentState.processing;
    Map<String, String> result = await requestFptAi(text);
    if (result.containsKey('error')) {
      Get.showSnackbar(GetSnackBar(
        title: "failed".tr,
        message: result['error'],
        duration: const Duration(seconds: 2),
      ));
      _state.value = ContentState.ready;
      return false;
    } else {
      String url = result['url']!;
      await waitUntilLinkIsAccessible(url);
      Get.toNamed(PageRouter.resultScreen, arguments: {
        'job': ConvertJob(url: url, speed: _speed.value, voice: _voice.value)
      });
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
