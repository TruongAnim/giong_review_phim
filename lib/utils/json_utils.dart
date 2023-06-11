import 'dart:convert';
import 'package:flutter/services.dart';

class JsonUtils {
  JsonUtils._();
  static final JsonUtils _instance = JsonUtils._();
  static JsonUtils get instance => _instance;

  Future<Map<String, String>> loadJsonFile(String filePath) async {
    try {
      String jsonString = await rootBundle.loadString(filePath);
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      Map<String, String> translations = Map<String, String>.from(jsonMap);

      return translations;
    } catch (e) {
      print('Error loading JSON file: $e');
      return {};
    }
  }
}
