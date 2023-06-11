import 'package:get/get.dart';

class Option {
  final String text;
  final String value;

  Option({required this.text, required this.value});
  String getText() {
    return text.tr;
  }
}
